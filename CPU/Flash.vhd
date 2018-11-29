----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:46 11/26/2018 
-- Design Name: 
-- Module Name:    Flash - Behavioral 
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

entity Flash is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           addr_in : in  STD_LOGIC_VECTOR (22 downto 1);
           Flash_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
           finish_read : out  STD_LOGIC;
           Byte : out  STD_LOGIC;
           CE : out  STD_LOGIC;
           WE : out  STD_LOGIC;
           OE : out  STD_LOGIC;
           RP : out  STD_LOGIC;
           Vpen : out  STD_LOGIC;
           Flash_addr : out  STD_LOGIC_VECTOR (22 downto 1));
end Flash;

architecture Behavioral of Flash is

	type states is (
		state0, state1, state2, state3, state4, state5
	);
	
	signal state : states;

begin

	Byte <= '1';
	Vpen <= '1';
	RP <= '1';
	CE <= '0';
	
	read_flash : process(clk, rst)
	begin
		if (rst = '0') then
			OE <= '1';
			WE <= '1';
			state <= state0;
			Flash_data <= (others => 'Z');
			Flash_addr <= (others => '0');
			finish_read <= '0';
			output <= NopIns;
		elsif (rising_edge(clk)) then
			case state is
				when state0 =>
					WE <= '0';
					state <= state1;
					finish_read <= '0';
				when state1 =>
					Flash_data <= x"00FF";
					WE <= '1';
					state <= state2;
				when state2 =>
					OE <= '0';
					state <= state3;
				when state3 =>
					Flash_addr <= addr_in;
					Flash_data <= (others => 'Z');
					state <= state4;
				when state4 =>
					output <= Flash_data;
					state <= state5;
				when state5 =>
					state <= state0;
					finish_read <= '1';
				end case;
		end if;
	end process;
	
end Behavioral;

