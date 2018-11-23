----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:25:01 11/24/2018 
-- Design Name: 
-- Module Name:    RegFile - Behavioral 
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
use WORK.DEFINES.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegFile is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Reg1Addr : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg2Addr : in  STD_LOGIC_VECTOR (3 downto 0);
           RegWrite : in  STD_LOGIC;
           WriteAddr : in  STD_LOGIC_VECTOR (3 downto 0);
           WriteData : in  STD_LOGIC_VECTOR (15 downto 0);
           PCin : inout  STD_LOGIC_VECTOR (15 downto 0);
           Reg1Data : out  STD_LOGIC_VECTOR (15 downto 0);
           Reg2Data : out  STD_LOGIC_VECTOR (15 downto 0));
end RegFile;

architecture Behavioral of RegFile is
	
	signal w_con : std_logic_vector (10 downto 0);
	signal out0, out1, out2, out3, out4, out5, out6, out7, outSP, outIH, outRA : std_logic_vector (15 downto 0);
	component Reg
		port(
		Regin : in  STD_LOGIC_VECTOR (15 downto 0);
      RegW : in  STD_LOGIC;
      clk : in  STD_LOGIC;
      rst : in  STD_LOGIC;
      Regout : out  STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;
	
begin

	r0 : Reg port map(WriteData, w_con(0), clk, rst, out0);
	r1 : Reg port map(WriteData, w_con(1), clk, rst, out1);
	r2 : Reg port map(WriteData, w_con(2), clk, rst, out2);
	r3 : Reg port map(WriteData, w_con(3), clk, rst, out3);
	r4 : Reg port map(WriteData, w_con(4), clk, rst, out4);
	r5 : Reg port map(WriteData, w_con(5), clk, rst, out5);
	r6 : Reg port map(WriteData, w_con(6), clk, rst, out6);
	r7 : Reg port map(WriteData, w_con(7), clk, rst, out7);
	ra : Reg port map(WriteData, w_con(8), clk, rst, outRA);
	sp : Reg port map(WriteData, w_con(9), clk, rst, outSP);
	ih : Reg port map(WriteData, w_con(10), clk, rst, outIH);
	
	with Reg1Addr select
		Reg1Data <= 
			out0 when "0000",
			out1 when "0001",
			out2 when "0010",
			out3 when "0011",
			out4 when "0100",
			out5 when "0101",
			out6 when "0110",
			out7 when "0111",
			outRA when "1000",
			outSP when "1001",
			outIH when "1010",
			PCin when "1011",
			ZeroData when others;
			
	with Reg2Addr select
		Reg2Data <= 
			out0 when "0000",
			out1 when "0001",
			out2 when "0010",
			out3 when "0011",
			out4 when "0100",
			out5 when "0101",
			out6 when "0110",
			out7 when "0111",
			outRA when "1000",
			outSP when "1001",
			outIH when "1010",
			PCin when "1011",
			ZeroData when others;
	
	with WriteAddr select
		w_con(0) <=
			RegWrite when "0000",
			'0' when others;
	
	with WriteAddr select
		w_con(1) <=
			RegWrite when "0001",
			'0' when others;
	
	with WriteAddr select
		w_con(2) <=
			RegWrite when "0010",
			'0' when others;
	
	with WriteAddr select
		w_con(3) <=
			RegWrite when "0011",
			'0' when others;
		
	with WriteAddr select
		w_con(4) <=
			RegWrite when "0100",
			'0' when others;	

	with WriteAddr select
		w_con(5) <=
			RegWrite when "0101",
			'0' when others;

	with WriteAddr select
		w_con(6) <=
			RegWrite when "0110",
			'0' when others;
	
	with WriteAddr select
		w_con(7) <=
			RegWrite when "0111",
			'0' when others;
	
	with WriteAddr select
		w_con(8) <=
			RegWrite when "1000",
			'0' when others;
	
	with WriteAddr select
		w_con(9) <=
			RegWrite when "1001",
			'0' when others;
	
	with WriteAddr select
		w_con(10) <=
			RegWrite when "1010",
			'0' when others;
	
end Behavioral;

