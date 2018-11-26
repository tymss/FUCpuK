----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:58:09 11/24/2018 
-- Design Name: 
-- Module Name:    Hazard - Behavioral 
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

entity Hazard is
    Port ( rst : in  STD_LOGIC;
           reg1addr : in  STD_LOGIC_VECTOR (3 downto 0);
           reg2addr : in  STD_LOGIC_VECTOR (3 downto 0);
           exe_memR : in  STD_LOGIC;
           regDst : in  STD_LOGIC_VECTOR (3 downto 0);
           flush : out  STD_LOGIC;
           stall_pc : out  STD_LOGIC;
           stall_if_id : out  STD_LOGIC);
end Hazard;

architecture Behavioral of Hazard is

begin

	process(rst, reg1addr, reg2addr, exe_memR, regDst)
	begin
		if (rst = '0') then
			flush <= '0';
			stall_pc <= '0';
			stall_if_id <= '0';
		else
			if ((exe_memR = '1') and (((regDst = reg1addr) and (reg1addr /= ZeroAddr)) or ((regDst = reg2addr) and (reg2addr /= ZeroAddr)))) then
				flush <= '1';
				stall_pc <= '1';
				stall_if_id <= '1';
			else
				flush <= '0';
				stall_pc <= '0';
				stall_if_id <= '0';
			end if;
		end if;
	end process;

end Behavioral;

