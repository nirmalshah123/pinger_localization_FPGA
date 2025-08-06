----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2021 21:54:33
-- Design Name: 
-- Module Name: compare - Behavioral
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

entity compare is
 GENERIC(LWR_WND_SIZE:INTEGER:=60;
         UPPR_WND_SIZE:INTEGER:=100);
 
  Port (    CLK : IN STD_LOGIC;
            S_AXIS_TDATA    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            S_AXIS_TVALID   : IN STD_LOGIC;
            M_AXIS_TDATA    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            M_AXIS_TVALID   : OUT STD_LOGIC:='0');
end compare;

architecture Behavioral of compare is
CONSTANT MAX_INDEX:INTEGER:=4095-UPPR_WND_SIZE;
TYPE MYSTATE IS (IDLE, BUSY);
SIGNAL STATE:MYSTATE:=IDLE;
begin

PROCESS(CLK,S_AXIS_TVALID)
VARIABLE MAX:INTEGER:=0;
VARIABLE COUNTER:INTEGER:=lwr_wnd_size-2;
VARIABLE DATA:INTEGER;
BEGIN
    IF(RISING_EDGE(CLK)) THEN
        CASE STATE IS
            WHEN IDLE=>
                M_AXIS_TVALID<='0';
            IF(S_AXIS_TVALID='1') THEN
                STATE<=BUSY;
                DATA:=TO_INTEGER(UNSIGNED(S_AXIS_TDATA));
                COUNTER:=COUNTER+1;
            ELSE
                STATE<=IDLE;
            END IF;
            
            WHEN BUSY=>
                IF(DATA > MAX) THEN
                    MAX:=DATA;
                    M_AXIS_TDATA<=STD_LOGIC_VECTOR(TO_UNSIGNED(counter,M_AXIS_TDATA'LENGTH));
                END IF;
                
                IF(S_AXIS_TVALID = '0') THEN
                    STATE<=IDLE;
                END IF;
                
                IF(COUNTER = MAX_INDEX) THEN
                    M_AXIS_TVALID<='1';
                    STATE<=IDLE;
                    COUNTER:=LWR_WND_SIZE-2;
                    MAX:=0;
                END IF;    
             
        END CASE;
    END IF;

END PROCESS;

end Behavioral;
