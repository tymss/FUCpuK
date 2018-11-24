----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:34 11/24/2018 
-- Design Name: 
-- Module Name:    EXE_MEM - Behavioral 
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

entity EXE_MEM is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           exe_aluResult : in  STD_LOGIC_VECTOR (15 downto 0);
           exe_reg2 : in  STD_LOGIC_VECTOR (15 downto 0);
           exe_regDst : in  STD_LOGIC_VECTOR (3 downto 0);
           exe_memW : in  STD_LOGIC;
           exe_memR : in  STD_LOGIC;
           exe_regW : in  STD_LOGIC;
           mem_aluResult : out  STD_LOGIC_VECTOR (15 downto 0);
           mem_reg2 : out  STD_LOGIC_VECTOR (15 downto 0);
           mem_regDst : out  STD_LOGIC_VECTOR (3 downto 0);
           mem_memW : out  STD_LOGIC;
           mem_memR : out  STD_LOGIC;
           mem_regW : out  STD_LOGIC);
end EXE_MEM;

architecture Behavioral of EXE_MEM is

begin

	process(clk, rst)
	begin
		if (rst = '0') then
			mem_aluResult <= ZeroData;
			mem_reg2 <= ZeroData;
			mem_regDst <= ZeroAddr;
			mem_memW <= '0';
			mem_memR <= '0';
			mem_regW <= '0';
		elsif (rising_edge(clk)) then
			mem_aluResult <= exe_aluResult;
			mem_reg2 <= exe_reg2;
			mem_regDst <= exe_regDst;
			mem_memW <= exe_memW;
			mem_memR <= exe_memR;
			mem_regW <= exe_regW;
		end if;
	end process;

end Behavioral;

