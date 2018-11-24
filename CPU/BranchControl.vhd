----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:17:58 11/24/2018 
-- Design Name: 
-- Module Name:    BranchControl - Behavioral 
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

entity BranchControl is
    Port ( rst : in  STD_LOGIC;
           b_op : in  STD_LOGIC_VECTOR (2 downto 0);
           Tdata : in  STD_LOGIC;
           RegData : in  STD_LOGIC_VECTOR (15 downto 0);
           sel : out  STD_LOGIC_VECTOR (1 downto 0));
end BranchControl;

architecture Behavioral of BranchControl is

begin

	process(rst, b_op, Tdata, RegData)
	begin
		if (rst = '0') then
			sel <= "00";
		else
			case b_op is
				when "000" => sel <= "00";
				when "001" => sel <= "01";
				when "010" => sel <= "10";
				when "011" => 
					if (RegData = ZeroData) then
						sel <= "01";
					else
						sel <= "00";
					end if;
				when "100" =>
					if (RegData /= ZeroData) then
						sel <= "01";
					else
						sel <= "00";
					end if;
				when "101" =>
					if (Tdata = '0') then
						sel <= "01";
					else
						sel <= "00";
					end if;	
				when others => sel <= "00";
			end case;
		end if;
	end process;
	
end Behavioral;

