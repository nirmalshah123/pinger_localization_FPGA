----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2021 17:59:13
-- Design Name: 
-- Module Name: hyd1_store - Behavioral
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

entity hyd1_bram is
  Port (ADDR   :   OUT STD_LOGIC_VECTOR(11 DOWNTO 0):=(OTHERS=>'0');
        DATA_OUT_IMG:   OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
        DATA_OUT_REAL:   OUT STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
        WEA : OUT STD_LOGIC:='0';
        INP_REAL : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        INP_IMAG    :   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        INP_VALID   :   IN STD_LOGIC;
        CLK : IN STD_LOGIC  );
end hyd1_bram;

architecture Behavioral of hyd1_bram is
begin
    PROCESS(CLK)
        VARIABLE COUNTER:INTEGER RANGE -1 TO 4095:=-1;
    BEGIN
        IF(RISING_EDGE(CLK)) THEN
            IF(INP_VALID = '1') THEN
                WEA<='1';
                DATA_OUT_REAL<=INP_REAL;
                DATA_OUT_IMG<=INP_IMAG;
                COUNTER:=COUNTER+1;
                ADDR<=STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER,ADDR'LENGTH));
             ELSE
                WEA<='0';
                DATA_OUT_REAL<=(OTHERS=>'0');
                DATA_OUT_IMG<=(OTHERS=>'0');
                COUNTER:=0;
                ADDR<=(OTHERS=>'0');
            END IF;
        
        END IF;
    END PROCESS;

end Behavioral;
