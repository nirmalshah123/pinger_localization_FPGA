----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2021 19:18:25
-- Design Name: 
-- Module Name: read_bram - Behavioral
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

entity read_from_bram is
GENERIC (START  :   INTEGER:=70;
         STOP   :   INTEGER:=70; 
         NO_OF_SAMPLES  :   INTEGER:=4096);  
  Port ( CLK    :   IN STD_LOGIC;
         ADDR   :   OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
         VALID_CORR_SINE  :   OUT STD_LOGIC:='0';
         VALID_CORR_HYD  :   OUT STD_LOGIC:='0';
         BIN_DETECTED   :   IN STD_LOGIC;
         BIN_DETECTED_VALID :   IN STD_LOGIC;
         DATA_FROM_BRAM_REAL :   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         DATA_FROM_BRAM_IMAG :   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         OUT_REAL_CORR_SINE           :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         OUT_IMAG_CORR_SINE           :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         INDEX                        :   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         INDEX_VALID                    : IN STD_LOGIC;
         OUT_REAL_CORR_HYD          :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         OUT_IMAG_CORR_HYD          :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
end read_from_bram;

architecture Behavioral of read_from_bram is
TYPE MYSTATE IS (IDLE,BUSY,CORR_HYD1);
SIGNAL STATE:MYSTATE:=IDLE;
begin
PROCESS(CLK)
VARIABLE COUNT:INTEGER RANGE 0 TO 4096:=0;
VARIABLE PREVIOUS   :   INTEGER RANGE 0 TO 4096:=0;
VARIABLE FOLLOWING   :  INTEGER RANGE 0 TO 4096:=0;
VARIABLE COUNT_HYD  :   INTEGER:=0;
VARIABLE TOTAL_NO_OF_POINTS :   INTEGER:=0;
 
BEGIN
    IF(RISING_EDGE(CLK)) THEN
        CASE STATE IS
            WHEN IDLE=>
                VALID_CORR_SINE<='0';
                VALID_CORR_HYD<='0';
                TOTAL_NO_OF_POINTS:=0;
                COUNT:=0;
                COUNT_HYD:=0;
                OUT_REAL_CORR_SINE<=(others=>'0');
                OUT_IMAG_CORR_SINE<=(OTHERS=>'0');
                PREVIOUS:=0;
                FOLLOWING:=0;
                ADDR<=(OTHERS=>'0');
                IF(BIN_DETECTED_VALID = '1') THEN
                    IF(BIN_DETECTED = '1') THEN
                        STATE<=BUSY;
                    ELSE
                        STATE<=IDLE;
                    END IF;
                END IF;
                IF(INDEX_VALID = '1') THEN
                    STATE<=CORR_HYD1;
                    IF(UNSIGNED(INDEX) > START) then
                        PREVIOUS:=TO_INTEGER(UNSIGNED(INDEX))-START;
                    ELSE
                        PREVIOUS:=0;
                    END IF;
                    
                    IF(UNSIGNED(INDEX)<NO_OF_SAMPLES-STOP) THEN
                        FOLLOWING:=TO_INTEGER(UNSIGNED(INDEX))+STOP;
                    ELSE
                        FOLLOWING:=NO_OF_SAMPLES-1;
                    END IF;    
                    TOTAL_NO_OF_POINTS:=FOLLOWING-PREVIOUS;        
                END IF;                     
                
            WHEN BUSY=>
                ADDR<=STD_LOGIC_VECTOR(TO_UNSIGNED(COUNT,ADDR'LENGTH));
                OUT_REAL_CORR_SINE<=DATA_FROM_BRAM_REAL;
                OUT_IMAG_CORR_SINE<=DATA_FROM_BRAM_IMAG;
                COUNT:=COUNT+1;
                VALID_CORR_SINE<= '1';
                IF(COUNT = 4096) THEN
                    STATE<=IDLE;
                END IF;
                
            WHEN CORR_HYD1=>
                 ADDR<=STD_LOGIC_VECTOR(TO_UNSIGNED(PREVIOUS,ADDR'LENGTH));
                 PREVIOUS:=PREVIOUS+1;
                 COUNT_HYD:=COUNT_HYD+1;
                 OUT_REAL_CORR_HYD<=DATA_FROM_BRAM_REAL;
                 OUT_IMAG_CORR_HYD<=DATA_FROM_BRAM_IMAG;
                 VALID_CORR_HYD<='1';
                 IF(COUNT_HYD = TOTAL_NO_OF_POINTS+3) THEN
                    STATE<=idle;   
                 END IF;
                 IF(COUNT_HYD > TOTAL_NO_OF_POINTS+1) then
                    VALID_CORR_HYD<='0';
                 END IF;
                           
        END CASE;
    END IF;
END PROCESS;

end Behavioral;
