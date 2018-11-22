----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:42:34 11/22/2018 
-- Design Name: 
-- Module Name:    TReg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: TReg
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TReg is
    Port ( Twrite : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Tin : in  STD_LOGIC;
           Tout : out  STD_LOGIC);
end TReg;

architecture Behavioral of TReg is
	
begin

	process(clk, rst)
	begin
		if (rst = '0') then
			Tout <= '0';
		elsif(falling_edge(clk)) then
			if (Twrite = '1') then 
				Tout <= Tin;
			end if;
		end if;	
	end process;

end Behavioral;