----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2021 13:10:41
-- Design Name: 
-- Module Name: delay - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity delay_by_1 is
  Port ( CLK    :   IN STD_LOGIC;
         INP_DATA   :   IN STD_LOGIC;
         OUT_DATA   :   OUT STD_LOGIC);
end delay_by_1;

architecture Behavioral of delay_by_1 is
TYPE MYSTATE IS (IDLE,BUSY);
SIGNAL STATE:MYSTATE:=IDLE;
begin
PROCESS(CLK)
BEGIN
    IF(RISING_EDGE(CLK)) THEN
    CASE STATE IS
        WHEN IDLE=>
            STATE<=BUSY;
        WHEN BUSY=>
            OUT_DATA<=INP_DATA;
    END CASE;
    END IF;
END PROCESS;

end Behavioral;
