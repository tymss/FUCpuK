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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
use WORK.DEFINES.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
	Port ( 
	ALUop : in  STD_LOGIC_VECTOR (2 downto 0);
	rst : in  STD_LOGIC;
	oper_1 : in  STD_LOGIC_VECTOR (15 downto 0);
	oper_2 : in  STD_LOGIC_VECTOR (15 downto 0);
	ALUflag : out  STD_LOGIC;
	ALUout : out STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is

signal temp : STD_LOGIC_VECTOR (15 downto 0);	
	
begin
	
	process(rst, ALUop, oper_1, oper_2, temp)
	begin
		if (rst = '0') then
			ALUout <= ZeroData;
			ALUflag <= '0';
		else	
			case ALUop is
				when "000" =>
					ALUout <= oper_1 + oper_2;
				when "001" =>
					ALUout <= oper_1 and oper_2;
				when "010" =>
					ALUout <= oper_1 - oper_2;
					temp <= oper_1 - oper_2;
					if (temp = ZeroData) then
						ALUflag <= '0';
					else
						ALUflag <= '1';
					end if;
				when "011" =>
					ALUout <= oper_1 or oper_2;
				when "100" =>
					ALUout <= to_stdlogicvector(to_bitvector(oper_1) sll conv_integer(oper_2));
				when "101" =>
					ALUout <= to_stdlogicvector(to_bitvector(oper_1) sra conv_integer(oper_2));
				when "110" =>
					temp <= oper_1 - oper_2;
					ALUflag <= temp(15);
				when others =>	
			end case;
		end if;
	end process;

end Behavioral;

