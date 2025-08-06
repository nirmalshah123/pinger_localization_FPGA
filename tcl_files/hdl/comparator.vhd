----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2021 10:02:34
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
--GENERIC (NO_OF_SAMPLES  :   INTEGER );
    PORT(   CLK             : IN STD_LOGIC;
            RESET           : IN STD_LOGIC;
            S_AXIS_FIFO_TDATA    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);            --Will get the stored Data from the FIFO if freq bin is detected
            S_AXIS_FIFO_TREADY   : OUT STD_LOGIC:='0';                          
            S_AXIS_FIFO_TVALID   : IN STD_LOGIC;
            S_AXIS_FREQ_FINDER_TVALID  : IN STD_LOGIC;                          --VALID signal from FREQ_FINDER_IP
            S_AXIS_FREQ_FINDER_FREQ_AMP    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);  --Take the MAX amplitude from the freq_finder
            S_AXIS_FREQ_FINDER_FREQ_BIN      : IN STD_LOGIC;                    --Take in the valid freq_bin detection output
            M_AXIS_TDATA    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);                --Will display out the input data it gets from the M_AXIS_TDATA
            M_AXIS_TVALID   : OUT STD_LOGIC:='0';                                
            M_AXIS_COUNTER  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0'));--Counter to count the number of points which have amplitude>MAX_AMPLITUDE/2

end comparator;

architecture Behavioral of comparator is
TYPE MYSTATE IS (IDLE,BUSY);
SIGNAL STATE:MYSTATE:=IDLE;
begin
PROCESS(CLK,RESET,S_AXIS_FIFO_TDATA,S_AXIS_FIFO_TVALID)
VARIABLE COUNTER:INTEGER:=0;
VARIABLE MAX_AMP    : STD_LOGIC_VECTOR(31 DOWNTO 0);
VARIABLE FREQ_FINDER_BIN:STD_LOGIC:='0';
VARIABLE AMP_BY_2       :UNSIGNED(31 DOWNTO 0);
BEGIN
    IF(RESET = '0') THEN
        M_AXIS_TVALID<='0';
        M_AXIS_TVALID<='0';
    ELSIF(RISING_EDGE(CLK)) THEN
    
        CASE STATE IS
            WHEN IDLE=>
                M_AXIS_TVALID<='0';
                M_AXIS_TDATA<=(OTHERS=>'0');
                S_AXIS_FIFO_TREADY<='0';
                COUNTER:=0;
                FREQ_FINDER_BIN:='0';
                M_AXIS_COUNTER<=(OTHERS=>'0');
                AMP_BY_2:=(OTHERS=>'0');
                
                IF(S_AXIS_FREQ_FINDER_TVALID='1') THEN                      --If FREQ_FINDER has calculated if bin is present or not
                    MAX_AMP:=S_AXIS_FREQ_FINDER_FREQ_AMP;                   -- WIll store the MAX_AMP and detection_bin
                    FREQ_FINDER_BIN:=S_AXIS_FREQ_FINDER_FREQ_BIN;
                    STATE<=BUSY;
                    S_AXIS_FIFO_TREADY<='1';                                --Will now tell FIFO to send the data to it
                ELSE
                    STATE<=IDLE;
                END IF;
            
            WHEN BUSY=>
                    IF(S_AXIS_FIFO_TVALID = '1') THEN                       -- Take in the data and display it
                        M_AXIS_TDATA<=S_AXIS_FIFO_TDATA;
                    END IF;
                    
                    IF(FREQ_FINDER_BIN = '0') THEN                          --If freq bin detection is unsuccessful, directly display the output =0 
                        M_AXIS_COUNTER<=(OTHERS=>'0');
                        M_AXIS_TVALID<='1';
                        STATE<=IDLE;
                        
                    ELSIF(FREQ_FINDER_BIN = '1' AND S_AXIS_FIFO_TVALID = '1') THEN  --If freq is successfully detected, start comparing
                        AMP_BY_2(31):=MAX_AMP(31);
                        AMP_BY_2(30 DOWNTO 23):= UNSIGNED(MAX_AMP(30 downto 23))-"00000001";
                        AMP_BY_2(22 DOWNTO 0):=UNSIGNED(MAX_AMP(22 DOWNTO 0));
                        --AMP_BY_2:=SHIFT_RIGHT(UNSIGNED(MAX_AMP),1);

                        IF(TO_INTEGER(UNSIGNED(S_AXIS_FIFO_TDATA)) > TO_INTEGER(AMP_BY_2)) THEN--Calculate number of points, whose amplitude>MAX_AMPLITUDE/2
                            COUNTER:=COUNTER+1;                                     --count the number of values
                        END IF;
                    END IF;
                        
                        IF (S_AXIS_FIFO_TVALID = '0') THEN                          --Once, all the data has been read from the FIFO, send the data to the next IP to chk if threshold is valid or not
                            M_AXIS_TVALID<='1';                                     
                            STATE<=IDLE;
                            M_AXIS_COUNTER<=STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER,M_AXIS_COUNTER'LENGTH));
                        ELSE
                            STATE<=BUSY;
                        END IF;
                    --END IF;
          END CASE;
      END IF;                            
       
END PROCESS;



end Behavioral;
