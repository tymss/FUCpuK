----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:18:15 11/23/2018 
-- Design Name: 
-- Module Name:    PCReg - Behavioral 
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

entity PCReg is
    Port ( PCin : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           stall_harzard : in  STD_LOGIC;
           stall_structure : in  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR (15 downto 0));
end PCReg;

architecture Behavioral of PCReg is

begin
	
	process(clk, rst)
	begin
		if (rst = '0') then
			PCout <= ZeroData;
		elsif (rising_edge(clk)) then
			if ((stall_harzard = '0') and (stall_structure = '0')) then
				PCout <= PCin;
			end if;
		end if;
	end process;

end Behavioral;

