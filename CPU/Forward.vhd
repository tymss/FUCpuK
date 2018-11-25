----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:40 11/24/2018 
-- Design Name: 
-- Module Name:    Forward - Behavioral 
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

entity Forward is
    Port ( rst : in  STD_LOGIC;
           src_addr : in  STD_LOGIC_VECTOR (3 downto 0);
           regW1 : in  STD_LOGIC;
           regW2 : in  STD_LOGIC;
           reg_dst1 : in  STD_LOGIC_VECTOR (3 downto 0);
           reg_dst2 : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : out  STD_LOGIC_VECTOR (1 downto 0));
end Forward;

architecture Behavioral of Forward is
	
begin
	
	process(rst, src_addr, regW1, regW2, reg_dst1, reg_dst2)
	begin
		if (rst = '0') then
			sel <= "00";
		else
			if ((regW1 = '1') and (reg_dst1 = src_addr) and (reg_dst1 /= ZeroAddr)) then
				sel <= "01";
			elsif ((regW2 = '1') and (reg_dst2 = src_addr) and (reg_dst2 /= ZeroAddr) and ((regW1 = '0') or (reg_dst1 /= src_addr) or (reg_dst1 = ZeroAddr))) then
				sel <= "10";
			else
				sel <= "00";
			end if;
		end if;
	end process;

end Behavioral;

