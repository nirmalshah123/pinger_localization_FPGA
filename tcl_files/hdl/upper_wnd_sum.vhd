----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2021 12:35:01
-- Design Name: 
-- Module Name: upper_wnd_sum - Behavioral
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

entity upper_wnd_sum is
  GENERIC(  LWR_WND_SIZE    :   INTEGER:=60;
            UPPR_WND_SIZE   :   INTEGER:=100);
  
  Port (    CLK             :   IN STD_LOGIC;
            S_AXIS_SUM_TVALID   : IN STD_LOGIC;
            S_AXIS_TADDR    :   OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            S_AXIS_TDATA    :   IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
            S_AXIS_ENB      :   OUT STD_LOGIC:='0';
            S_AXIS_INIT_UPPR_WND:   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            M_AXIS_TDATA    :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            M_AXIS_TVALID   :   OUT STD_LOGIC:='0');
end upper_wnd_sum;

architecture Behavioral of upper_wnd_sum is
TYPE MYSTATE IS (IDLE,UPPER1,UPPER2);
SIGNAL STATE:MYSTATE:=IDLE;
begin

PROCESS(CLK,S_AXIS_TDATA,S_AXIS_INIT_UPPR_WND)
VARIABLE UPPER_COUNTER:INTEGER:=(LWR_WND_SIZE + UPPR_WND_SIZE);
VARIABLE LOWER_COUNTER:INTEGER:=LWR_WND_SIZE;
VARIABLE UPPER_SUM:INTEGER:=0;
BEGIN
    IF(CLK = '1' AND CLK'EVENT) THEN
    CASE STATE IS
        WHEN IDLE=>
            S_AXIS_TADDR<=(others=>'0');
            S_AXIS_ENB<='0';
            M_AXIS_TVALID<='0';
            UPPER_SUM:=0;
            LOWER_COUNTER:=LWR_WND_SIZE;
            UPPER_COUNTER:=(LWR_WND_SIZE + UPPR_WND_SIZE);
            
            IF(S_AXIS_SUM_TVALID = '1') THEN
                STATE<=UPPER1;
                UPPER_SUM:=TO_INTEGER(SIGNED(S_AXIS_INIT_UPPR_WND));
            ELSE 
                STATE<=IDLE;
            END IF;
        
        WHEN UPPER1=>
                   S_AXIS_ENB<='1';
                   S_AXIS_TADDR<=STD_LOGIC_VECTOR(TO_UNSIGNED(LOWER_COUNTER,S_AXIS_TADDR'LENGTH));
                   UPPER_SUM:=UPPER_SUM - TO_INTEGER(SIGNED(S_AXIS_TDATA));
                   LOWER_COUNTER:=LOWER_COUNTER+1;
                   STATE<=UPPER2;
                   M_AXIS_TDATA<=STD_LOGIC_VECTOR(TO_SIGNED(UPPER_SUM,M_AXIS_TDATA'LENGTH));
                   M_AXIS_TVALID<='0';
                   
        WHEN UPPER2=>
                   S_AXIS_TADDR<=STD_LOGIC_VECTOR(TO_UNSIGNED(UPPER_COUNTER,S_AXIS_TADDR'LENGTH));
                   UPPER_SUM:=UPPER_SUM + TO_INTEGER(SIGNED(S_AXIS_TDATA));
                   UPPER_COUNTER:=UPPER_COUNTER+1;
                   STATE<=UPPER1;
                   M_AXIS_TDATA<=STD_LOGIC_VECTOR(TO_SIGNED(UPPER_SUM,M_AXIS_TDATA'LENGTH));
                   M_AXIS_TVALID<='1';
                   IF(UPPER_COUNTER > 4096) THEN
                        STATE<=IDLE;
                   END IF;
            
        
    END CASE;
    END IF;

END PROCESS;




end Behavioral;
