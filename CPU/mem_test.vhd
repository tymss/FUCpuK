----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:15:59 11/26/2018 
-- Design Name: 
-- Module Name:    mem_test - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
USE ieee.numeric_std.ALL;
use work.defines.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_test is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end mem_test;

architecture Behavioral of mem_test is

	TYPE mem_type IS ARRAY (0 TO 100) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL mem : mem_type := (
		"0000100000000000", --noP
		"0110111010000000", --LI R6 0080
		"0011011011000000", --SLL R6 R6 0000
		"0110100000000001", --LI R0 0001
		"1101111000000000", --SW R6 R0 0000
		"0110100000000010", --LI R0 0002
		"1101111000000001", --SW R6 R0 0001
		"0110100000000011", --LI R0 0003
		"1101111000000010", --SW R6 R0 0002
		"0110100000000100", --LI R0 0004
		"1101111000000011", --SW R6 R0 0003
		"0110100000010101", --LI R0 0015
		"1101111000000100", --SW R6 R0 0004
		"1001111000000000", --LW(RAM[R[6]+0])->R[0]
		"1001111000100001", --LW(RAM[R[6]+1])->R[1]
		"1001111001000010", --LW(RAM[R[6]+2])->R[2]
		"1101111000000101", --SW R6 R0 0005
		"1101111000100110", --SW R6 R1 0006
		"1101111001000111", --SW R6 R2 0007
		"0001011111111111", -- B -1
		"0000100000000000", --NOP
		others => "0000100000000000"
	);
	
	component aPlusC 
		Port ( 
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		
		--Ram1 and Serial Port 相关信号
		data_ready : in STD_LOGIC;
		tbre : in STD_LOGIC;
		tsre : in STD_LOGIC;
		Ram1Data : inout STD_LOGIC_VECTOR (15 downto 0);
		Ram1Addr : out STD_LOGIC_VECTOR (17 downto 0);
		Ram1EN : out STD_LOGIC;
		Ram1WE : out STD_LOGIC;
		Ram1OE : out STD_LOGIC;
		rdn : out STD_LOGIC;
		wrn : out STD_LOGIC;

		--Ram2 相关信号
		Ram2Data : inout STD_LOGIC_VECTOR (15 downto 0);
		Ram2Addr : out STD_LOGIC_VECTOR (17 downto 0);
		Ram2EN : out STD_LOGIC;
		Ram2WE : out STD_LOGIC;
		Ram2OE : out STD_LOGIC);
	end component;
	
	signal data_ready : STD_LOGIC;
	signal tbre : STD_LOGIC;
	signal tsre : STD_LOGIC;
	signal Ram1Data : STD_LOGIC_VECTOR (15 downto 0);
	signal Ram1Addr : STD_LOGIC_VECTOR (17 downto 0);
	signal Ram1EN : STD_LOGIC;
	signal Ram1WE : STD_LOGIC;
	signal Ram1OE : STD_LOGIC;
	signal rdn : STD_LOGIC;
	signal wrn : STD_LOGIC;
	signal Ram2Data : STD_LOGIC_VECTOR (15 downto 0);
	signal Ram2Addr : STD_LOGIC_VECTOR (17 downto 0);
	signal Ram2EN : STD_LOGIC;
	signal Ram2WE : STD_LOGIC;
	signal Ram2OE : STD_LOGIC;
	signal test : STD_LOGIC;
begin
	myPC : aPlusC port map (
		clk=>clk,
		rst=>rst,
		data_ready=>data_ready,
		tbre=>tbre,
		tsre=>tsre,
		Ram1Data=>Ram1Data,
		Ram1Addr=>Ram1Addr,
		Ram1EN=>Ram1EN,
		Ram1WE=>Ram1WE,
		Ram1OE=>Ram1OE,
		rdn=>rdn,
		wrn=>wrn,
		Ram2Data=>Ram2Data,
		Ram2Addr=>Ram2Addr,
		Ram2EN=>Ram2EN,
		Ram2WE=>Ram2WE,
		Ram2OE=>Ram2OE
	);
	
	write_proc : PROCESS (clk, Ram1WE, Ram1Data, Ram1EN, Ram1Addr)
	BEGIN
		if (clk'event and clk = '1') then
			IF ((Ram1WE = '0') and (Ram1EN = '0')) THEN
				mem(to_integer(unsigned(Ram1Addr))) <= Ram1Data after 3 ns;
			END IF;
		end if;
	END PROCESS;

	read_proc : PROCESS (clk, Ram1OE, Ram1EN, Ram1Data, Ram1Addr)
	BEGIN
		if (clk'event and clk = '1') then
			IF ((Ram1OE = '0') and (Ram1EN = '0') and (Ram1Data = AllZData)) THEN
				test <= '1';
				Ram1Data <= mem(to_integer(unsigned(Ram1Addr))) after 3 ns;
			END IF;
		end if;
	END PROCESS;
end Behavioral;

