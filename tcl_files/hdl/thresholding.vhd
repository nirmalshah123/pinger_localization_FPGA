----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2021 10:04:35
-- Design Name: 
-- Module Name: thresholding - Behavioral
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

entity thresholding is
GENERIC(    COUNTER_THRESH  : INTEGER;
            NO_OF_SAMPLES   : INTEGER:=4096);     -- CALCULATE IT AS NO_OF_SAMPLES/(COUNTER_THRESH+1)
 Port (     S_AXIS_TDATA    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            CLK             : IN STD_LOGIC;
            RESET           : IN STD_LOGIC;
            S_AXIS_TVALID   : IN STD_LOGIC;
            M_AXIS_TDATA    : OUT STD_LOGIC:='0';
            M_AXIS_TVALID   : OUT STD_LOGIC:='0');
end thresholding;

architecture Behavioral of thresholding is

TYPE MYSTATE IS (IDLE, BUSY);
SIGNAL STATE: MYSTATE:=IDLE;

CONSTANT FINAL_THRESH: INTEGER  :=NO_OF_SAMPLES/(COUNTER_THRESH+1);     --Threshold ratio constant

begin


PROCESS(CLK,RESET,S_AXIS_TDATA,S_AXIS_TVALID)
VARIABLE COUNTER:INTEGER:=0;                       -- Variable to store the Count we would recive from the FIFO IP
BEGIN
    IF(RESET = '0') THEN
        M_AXIS_TDATA<='0';
        M_AXIS_TVALID<='0';
    ELSIF(RISING_EDGE(CLK)) THEN
        CASE STATE IS
            WHEN IDLE=>
                M_AXIS_TVALID<='0';
                M_AXIS_TDATA<='0';
                COUNTER:=0;
                            
                IF(S_AXIS_TVALID = '1') THEN                            --If FIFO_OUTPUT IP have counted, then we would chk do threshold test
                    COUNTER:=TO_INTEGER(UNSIGNED(S_AXIS_TDATA));
                    IF(COUNTER = 0 ) THEN
                        M_AXIS_TVALID<='1';
                        M_AXIS_TDATA<='0';
                        STATE<=IDLE;
                    ELSE
                        STATE<=BUSY;
                    END IF;
                ELSE
                    STATE<=IDLE;
                END IF; 
            
            WHEN BUSY=>
                
                M_AXIS_TVALID<='1';
                IF(FINAL_THRESH>COUNTER) THEN                           --If we have counter to be less than threshold value, then we have passed the Threshold Detection test
                    M_AXIS_TDATA<='1';
                ELSE
                    M_AXIS_TDATA<='0';
                END IF;
                STATE<=IDLE;
          END CASE;
     END IF;               
                
END PROCESS;
       
end Behavioral;
