----------------------------------------------------------------------------------
-- Company: AUV-IITB 
-- Engineer: 
-- 
-- Create Date: 23.03.2021 04:46:57
-- Design Name: 
-- Module Name: frequency_finder - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frequency_finder is
generic (  NO_OF_SAMPLES : integer ;
           FREQUENCY     : INTEGER ;
           FREQ_THRESH   : INTEGER ;
           SAMPLING_FREQ : INTEGER);
Port (  S_AXIS_TVALID   :   IN STD_LOGIC;                               
        RESET           :   IN STD_LOGIC;
        S_AXIS_TDATA    :   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        CLK             :   IN STD_LOGIC;
        M_AXIS_TVALID   :   OUT STD_LOGIC;                                              
        M_AXIS_TDATA:       OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(others=>'0');   --WIll give out (Amplitude)^2 from the FFT
        INDEX           :   OUT STD_LOGIC_VECTOR(15 DOWNTO 0):=(OTHERS=>'0');   --Give out the max index
        VALID_FREQ    :   OUT STD_LOGIC:='0';                                   --Tell whehter Freq Bin is detected or not
        M_AXIS_FIFO_RESET   : OUT STD_LOGIC:='1');                              --If it's not detected then, flush the FIFO and give output=0 
end frequency_finder;

architecture Behavioral of frequency_finder is
TYPE MYSTATE IS(IDLE, BUSY,RESET_FIFO);
SIGNAL STATE:MYSTATE:=IDLE; 
CONSTANT LOWER_INDEX  : INTEGER:=((FREQUENCY-2000)*NO_OF_SAMPLES)/SAMPLING_FREQ;
CONSTANT UPPER_INDEX  : INTEGER:=((FREQUENCY+2000)*NO_OF_SAMPLES)/SAMPLING_FREQ;    


  
BEGIN
    
PROCESS(S_AXIS_TVALID,S_AXIS_TDATA,CLK,STATE,RESET)
VARIABLE MAX: STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');                         --Variable to store the MAX amplitude
VARIABLE COUNTER: INTEGER:=1;                                                       --Counter to count number of samples which have been checked                                                    
VARIABLE MAX_INDEX : INTEGER;                                                       --Store the MAX amplitude's Index
BEGIN
    IF(RESET = '0') THEN                                                            --If RESET then reset all the values
        M_AXIS_TDATA<=(OTHERS=>'0');
        INDEX<=(OTHERS=>'0');
    ELSIF(RISING_EDGE(CLK)) THEN
        CASE STATE IS
            WHEN IDLE=>                                                             --If STATE is IDLE, then don't do anything
                M_AXIS_TVALID<='0';
                INDEX<=(OTHERS=>'0');
                M_AXIS_TDATA<=(OTHERS=>'0');
                COUNTER:=2;
                MAX:=(OTHERS=>'0');
                VALID_FREQ<='0';
                --FREQ:=0;
                MAX_INDEX:=0;
                M_AXIS_FIFO_RESET<='1';
            
            IF(S_AXIS_TVALID = '1') THEN                                            --If we are getting valid DATA (Ampltiude)^2 then we would now start measuring
                MAX:=S_AXIS_TDATA;                                                  --Store the 1st data into MAX
                STATE<=BUSY;                                                        --Enter into BUSY state
            ELSE
                STATE<=IDLE;
            END IF;
            
            WHEN BUSY=>
                IF(S_AXIS_TDATA > MAX) THEN                                         --Basic algo is if the data is >MAX then MAX = data and MAX_index = counter
                    MAX:=S_AXIS_TDATA;
                    M_AXIS_TDATA<=MAX;
                    INDEX<=STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER,INDEX'LENGTH));
                    MAX_INDEX:= COUNTER;
                END IF;
                
                COUNTER:=COUNTER+1;                                                 --Update the counter value after each data is compared
                
                IF(S_AXIS_TVALID = '0') THEN                                        --If all the data have been checked then we would make the M_AXIS_TVALID=1
                    STATE<=IDLE;
                    M_AXIS_TVALID<='1';
                    IF((MAX_INDEX > LOWER_INDEX) AND (MAX_INDEX < UPPER_INDEX)) THEN    --Chk if the frequecny is present in the bin or not
                        VALID_FREQ<='1';
                    ELSE
                        VALID_FREQ<='0';                                                --If freq bin is not present then reset the fifo and flush all it's value
                        STATE<=RESET_FIFO;
                    END IF;

                ELSE
                    STATE<=BUSY;
                END IF;
           
           WHEN RESET_FIFO=>
                    M_AXIS_FIFO_RESET<='0';
                    STATE<=IDLE;
             
           WHEN OTHERS=>
                STATE<=IDLE;
                         
                
        END CASE;
    END IF;
END PROCESS;
    

end Behavioral;
