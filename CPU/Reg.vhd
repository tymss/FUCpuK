----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:08:25 11/23/2018 
-- Design Name: 
-- Module Name:    Reg - Behavioral 
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

entity Reg is
    Port ( Regin : in  STD_LOGIC_VECTOR (15 downto 0);
           RegW : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Regout : out  STD_LOGIC_VECTOR (15 downto 0));
		   
end Reg;

architecture Behavioral of Reg is

begin
	
	process(clk, rst)
	begin
		if (rst = '0') then
			Regout <= ZeroData;
		elsif (falling_edge(clk)) then
			if (RegW = '1') then
				Regout <= Regin;
			end if;	
		end if;
	end process;

end Behavioral;

