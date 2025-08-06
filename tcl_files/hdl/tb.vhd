----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2021 23:09:42
-- Design Name: 
-- Module Name: tb1 - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Std_logic_textio.all;
library std;
use std.textio.all;
use std.env.stop;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
COMPONENT design_1_wrapper IS
  port (
    CLK : in STD_LOGIC;
    IM_DATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    INDEX : out STD_LOGIC_VECTOR ( 31 downto 0 );
    INDEX_VALID : out STD_LOGIC;
    RE_DATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RE_VALID : in STD_LOGIC
  );
 END COMPONENT;

SIGNAL CLK  : STD_LOGIC;
SIGNAL INP_DATA :   std_logic_vector(31 DOWNTO 0);
SIGNAL INP_VALID    :   std_logic:='0';
signal IM_DATA: std_logic_vector(31 DOWNTO 0):=(OTHERS=>'0');
SIGNAL BIN_DETECTED :   std_logic:='0';
SIGNAL BIN_DETECTED_VALID   :   std_logic:='0';
CONSTANT CLOCK_PERIOD: TIME := 10 ns;
BEGIN

I0  : DESIGN_1_WRAPPER PORT MAP (CLK=>CLK,
                                 RE_DATA=>INP_DATA,
                                 RE_VALID=>INP_VALID,
                                 IM_DATA=>IM_DATA
                                 );

STIMULUS: PROCESS
    FILE FIN    : TEXT OPEN READ_MODE IS "D:\AUV_Elec\Pinger_task_using_FPGA\test_2021_version\project_1\pass.txt";
    VARIABLE READ_LINE  : LINE;
    VARIABLE LINE_VAL   : STD_LOGIC_VECTOR(31 DOWNTO 0);

    FILE FIN1    : TEXT OPEN READ_MODE IS "D:\AUV_Elec\Pinger_task_using_FPGA\test_2021_version\project_1\pass1.txt";
    VARIABLE READ_LINE1  : LINE;
    VARIABLE LINE_VAL1   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    BEGIN
    INP_DATA<=(OTHERS=>'0');
    IM_DATA<=(OTHERS=>'0');
    BIN_DETECTED_VALID<='0';
    BIN_DETECTED<='0';
    INP_VALID<='0';
    WAIT FOR CLOCK_PERIOD/2;
    WHILE (NOT ENDFILE(FIN)) LOOP
        READLINE(FIN,READ_LINE);
        READ(READ_LINE,LINE_VAL);
        INP_DATA<=LINE_VAL;
        INP_VALID<='1';
        WAIT FOR CLOCK_PERIOD;
    END LOOP;
    
    IF(ENDFILE(FIN) = TRUE) THEN
        INP_VALID<='0';
    END IF;
    
--    WAIT FOR 200 US;
    
--    WHILE (NOT ENDFILE(FIN1)) LOOP
--        READLINE(FIN1,READ_LINE1);
--        READ(READ_LINE1,LINE_VAL1);
--        INP_DATA<=LINE_VAL1;
--        INP_VALID<='1';
--        WAIT FOR CLOCK_PERIOD;
--    END LOOP;
    
--    IF(ENDFILE(FIN1) = TRUE) THEN
--        INP_VALID<='0';
--    END IF;
    
    WAIT;
  END PROCESS;
  
  CLOCKING: PROCESS
  BEGIN
    WHILE(TRUE) loop
      CLK <= '0', '1' AFTER CLOCK_PERIOD/ 2;
      WAIT FOR CLOCK_PERIOD;
    END LOOP;
    WAIT;
  END PROCESS;
    
    


end Behavioral;
