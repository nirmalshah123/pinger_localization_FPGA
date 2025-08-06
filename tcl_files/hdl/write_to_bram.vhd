----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2021 23:13:49
-- Design Name: 
-- Module Name: write_bram - Behavioral
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

entity write_to_bram is
  Port ( CLK    :   IN STD_LOGIC; 
         INP_DATA   :   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         INP_VALID  :   IN STD_LOGIC;
         ADDR       :   OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
         OUT_DATA   :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         WEA        :   OUT STD_LOGIC:='0'   );
end write_to_bram;

architecture Behavioral of write_to_bram is
SIGNAL COUNTER:INTEGER:=0;
begin
PROCESS(CLK)
BEGIN
    IF(RISING_EDGE(CLK)) THEN
        IF(INP_VALID = '1') THEN
            WEA<='1';
            OUT_DATA<=INP_DATA;
            COUNTER<=COUNTER+1;
            ADDR<=STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER,ADDR'LENGTH));
        ELSE
            WEA<='0';
            COUNTER<=0;
            OUT_DATA<=(OTHERS=>'0');
            ADDR<=(OTHERS=>'0');
            
        END IF;
    END IF;
END PROCESS;        

end Behavioral;
