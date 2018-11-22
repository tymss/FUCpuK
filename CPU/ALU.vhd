----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:52:48 11/22/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
	Port ( ALUop : in  STD_LOGIC_VECTOR (3 downto 0);
          rst : in  STD_LOGIC;
          oper_1 : in  STD_LOGIC_VECTOR (15 downto 0);
			 oper_2 : in  STD_LOGIC_VECTOR (15 downto 0);
          ALUflag : out  STD_LOGIC;
		    ALUout : out STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is
	
begin


end Behavioral;

