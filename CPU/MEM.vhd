----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:57 11/25/2018 
-- Design Name: 
-- Module Name:    MEM - Behavioral 
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

entity MEM is
    Port ( rst : in  STD_LOGIC;
           memR_in : in STD_LOGIC;
			  memW_in : in STD_LOGIC;
			  mem_addr_in : in STD_LOGIC_VECTOR (15 downto 0);
			  mem_data_in : in STD_LOGIC_VECTOR (15 downto 0);
			  memR_out : out STD_LOGIC;
			  memW_out : out STD_LOGIC;
			  mem_addr_out : out STD_LOGIC_VECTOR (15 downto 0);
			  mem_data_out : out STD_LOGIC_VECTOR (15 downto 0);
			  mem_EN : out STD_LOGIC);
end MEM;

architecture Behavioral of MEM is

begin

	process(rst, memR_in, memW_in, mem_addr_in, mem_data_in)
	begin 
		if (rst = '0') then
			memR_out <= '0';
			memW_out <= '0';
			mem_addr_out <= ZeroData;
			mem_data_out <= ZeroData;
			mem_EN <= '1';
		else
			memR_out <= memR_in;
			memW_out <= memW_in;
			if (memR_in = '1') then
				mem_EN <= '0';
				mem_addr_out <= mem_addr_in;
			elsif (memW_in = '1') then
				mem_EN <= '0';
				mem_addr_out <= mem_addr_in;
				mem_data_out <= mem_data_in;
			else
				mem_EN <= '1';
			end if;	
		end if;
	end process;
	
end Behavioral;

