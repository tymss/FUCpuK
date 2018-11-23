----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:08:52 11/24/2018 
-- Design Name: 
-- Module Name:    Adder - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.DEFINES.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder is
    Port ( 
	 rst : in STD_LOGIC;
	 oper_1 : in  STD_LOGIC_VECTOR (15 downto 0);
	 oper_2 : in  STD_LOGIC_VECTOR (15 downto 0);
	 output : out  STD_LOGIC_VECTOR (15 downto 0));
end Adder;

architecture Behavioral of Adder is

begin
	
	process(rst, oper_1, oper_2)
	begin
		if (rst = '0') then
			output <= ZeroData;
		else
			output <= oper_1 + oper_2;
		end if;
	end process;

end Behavioral;

