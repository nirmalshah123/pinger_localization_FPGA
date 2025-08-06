----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 01:55:52
-- Design Name: 
-- Module Name: testing_bram - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rising_edge_bram is
  GENERIC(LWR_WND       :   INTEGER:=60;
          UPPR_WND      :   INTEGER:=100);
  
  Port( CLK             :   IN STD_LOGIC;
        S_AXIS_TDATA    :   IN STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
        S_AXIS_TVALID   :   IN STD_LOGIC;
        S_AXIS_TREADY   :   OUT STD_LOGIC:='1';
        ADDRA   :   OUT STD_LOGIC_VECTOR(11 DOWNTO 0):=(OTHERS=>'0');
        DINA    :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
        WEA     :   OUT STD_LOGIC:='0';
        INIT_LWR_SUM    :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
        INIT_UPPR_SUM   :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
        M_AXIS_SUM_TVALID      : OUT STD_LOGIC :='0');
end rising_edge_bram;

architecture Behavioral of rising_edge_bram IS
TYPE MYSTATE IS (IDLE, BUSY);
SIGNAL STATE:MYSTATE:=IDLE;
begin
    PROCESS(CLK,S_AXIS_TDATA,S_AXIS_TVALID)
    VARIABLE COUNTER:INTEGER:=0;
    VARIABLE LWR_SUM:INTEGER:=0;
    VARIABLE UPPR_SUM:INTEGER:=0;
    BEGIN
  
    IF(RISING_EDGE(CLK)) THEN  
    CASE STATE IS
        WHEN IDLE=>
            WEA<='0';
            COUNTER:=0;
            LWR_SUM:=0;
            UPPR_SUM:=0;
            ADDRA<=(OTHERS=>'0');
            INIT_LWR_SUM<=(OTHERS=>'0');
            INIT_UPPR_SUM<=(OTHERS=>'0');
            M_AXIS_SUM_TVALID<='0';
            
            IF(S_AXIS_TVALID = '1') THEN
                STATE<=BUSY;
                WEA<='1';
                ADDRA<= STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER,ADDRA'length));
                DINA<=S_AXIS_TDATA;
                LWR_SUM:=TO_INTEGER(SIGNED(S_AXIS_TDATA));
            ELSE
                STATE<=IDLE;
            END IF;
        
        WHEN BUSY=>
            COUNTER:=COUNTER+1;
            ADDRA<= STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER,ADDRA'length));
            DINA<=S_AXIS_TDATA;
            IF(COUNTER < LWR_WND) THEN
                LWR_SUM:=LWR_SUM+TO_INTEGER(SIGNED(S_AXIS_TDATA));
            ELSIF(COUNTER<(LWR_WND + UPPR_WND)) THEN
                UPPR_SUM:=UPPR_SUM+TO_INTEGER(SIGNED(S_AXIS_TDATA));
            END IF;
            
            IF(COUNTER = 4095 or S_AXIS_TVALID = '0') THEN
                STATE<=IDLE;
                --S_AXIS_TREADY<='0';
                --WEA<='0';
                M_AXIS_SUM_TVALID<='1';
                INIT_LWR_SUM<=STD_LOGIC_VECTOR(TO_SIGNED(LWR_SUM,INIT_LWR_SUM'LENGTH));
                INIT_UPPR_SUM<=STD_LOGIC_VECTOR(TO_SIGNED(UPPR_SUM,INIT_UPPR_SUM'LENGTH));
            ELSE
                STATE<=BUSY;
            END IF;
        
    END CASE;
    END IF;    
    END PROCESS;

end Behavioral;
