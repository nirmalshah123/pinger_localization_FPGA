----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.09.2021 02:00:46
-- Design Name: 
-- Module Name: bram_control - Behavioral
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

entity corr_sine_bram is
  Port ( ADDR   : OUT STD_LOGIC_VECTOR(11 DOWNTO 0):=(OTHERS=>'0');
         INPUT_REAL    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         INPUT_IMAG    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         SINE_IN_REAL   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         SINE_IN_IMG   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         DATA_OUT_VALID : OUT STD_LOGIC:='0';
         CORR_OUT_REAL   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
         CORR_OUT_IMG  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
         INP_REAL      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
         INP_IMG      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
         INP_VALID  : IN STD_LOGIC;
         CLK        : IN STD_LOGIC);
end corr_sine_bram;

architecture Behavioral of corr_sine_bram is
TYPE MYSTATE IS (IDLE,HYD1,BUSY);
SIGNAL STATE:MYSTATE:=IDLE;
begin
PROCESS(CLK)
VARIABLE COUNTER:INTEGER RANGE 0 TO 4096:=1;
BEGIN
    IF(RISING_EDGE(CLK)) THEN
        IF(INP_VALID = '1') THEN
            DATA_OUT_VALID<= '1';
            CORR_OUT_REAL<=SINE_IN_REAL;
            CORR_OUT_IMG<=SINE_IN_IMG;
            INP_REAL<=INPUT_REAL;
            INP_IMG<=INPUT_IMAG;
            COUNTER:=COUNTER+1;
            ADDR<=STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER,ADDR'LENGTH));
        ELSE
            DATA_OUT_VALID<='0';
            CORR_OUT_REAL<=(OTHERS=>'0');
            CORR_OUT_IMG<=(OTHERS=>'0');
            INP_REAL<=(OTHERS=>'0');
            INP_IMG<=(OTHERS=>'0');
            COUNTER:=1;
            ADDR<=(OTHERS=>'0');
        END IF;
    END IF;
END PROCESS;
end Behavioral;
