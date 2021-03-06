----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:04:53 11/24/2018 
-- Design Name: 
-- Module Name:    IF_ID - Behavioral 
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

entity IF_ID is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           if_pc : in  STD_LOGIC_VECTOR (15 downto 0);
           if_ins : in  STD_LOGIC_VECTOR (15 downto 0);
           stall_structure : in  STD_LOGIC;
           stall_hazard : in  STD_LOGIC;
           id_pc : out  STD_LOGIC_VECTOR (15 downto 0);
           id_ins : out  STD_LOGIC_VECTOR (15 downto 0));
end IF_ID;

architecture Behavioral of IF_ID is

begin

	process(clk, rst)
	begin
		if (rst = '0') then
			id_pc <= ZeroData;
			id_ins <= NopIns;
		elsif (rising_edge(clk)) then
			if ((stall_structure = '1') or (stall_hazard = '1')) then
			else
				id_ins <= if_ins;
				id_pc <= if_pc;
			end if;	
		end if;	
	end process;

end Behavioral;

