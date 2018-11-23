----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:18:57 11/24/2018 
-- Design Name: 
-- Module Name:    ImmExt - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use WORK.DEFINES.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ImmExt is
    Port ( rst : in  STD_LOGIC;
           Extop : in  STD_LOGIC_VECTOR (2 downto 0);
           Imm8 : in  STD_LOGIC_VECTOR (7 downto 0);
           Imm4 : in  STD_LOGIC_VECTOR (4 downto 0);
           Imm11 : in  STD_LOGIC_VECTOR (10 downto 0);
           Imm5 : in  STD_LOGIC_VECTOR (4 downto 0);
           Imm3 : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0));
end ImmExt;

architecture Behavioral of ImmExt is

begin
		
	process(rst, Extop, Imm3, Imm4, Imm5, Imm8, Imm11)
	begin
		if (rst = '0') then
			output <= ZeroData;
		else
			case ExtOp is
				when "000" =>
					output <= EXT(Imm8, 16);
				when "001" =>
					output <= SXT(Imm8, 16);
				when "010" =>
					output <= SXT(Imm4, 16);
				when "011" =>
					if (Imm3 = "000") then
						output <= EXT("1000", 16);
					else
						output <= EXT(Imm3, 16);
					end if;
				when "100" =>
					output <= SXT(Imm5, 16);
				when "101" =>
					output <= SXT(Imm11, 16);
				when others =>
					output <= ZeroData;
			end case;
		end if;
	end process;

end Behavioral;

