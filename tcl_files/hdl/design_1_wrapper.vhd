--Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
--Date        : Mon Dec  6 16:46:04 2021
--Host        : LAPTOP-A4CMJC5F running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    CLK : in STD_LOGIC;
    IM_DATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    INDEX : out STD_LOGIC_VECTOR ( 31 downto 0 );
    INDEX_VALID : out STD_LOGIC;
    RE_DATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RE_VALID : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    CLK : in STD_LOGIC;
    RE_DATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RE_VALID : in STD_LOGIC;
    IM_DATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    INDEX : out STD_LOGIC_VECTOR ( 31 downto 0 );
    INDEX_VALID : out STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      CLK => CLK,
      IM_DATA(31 downto 0) => IM_DATA(31 downto 0),
      INDEX(31 downto 0) => INDEX(31 downto 0),
      INDEX_VALID => INDEX_VALID,
      RE_DATA(31 downto 0) => RE_DATA(31 downto 0),
      RE_VALID => RE_VALID
    );
end STRUCTURE;
