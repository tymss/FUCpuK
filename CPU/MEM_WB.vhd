----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:13 11/24/2018 
-- Design Name: 
-- Module Name:    MEM_WB - Behavioral 
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

entity MEM_WB is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           mem_regW : in  STD_LOGIC;
			  mem_memR : in  STD_LOGIC;
           mem_aluResult : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_regDst : in  STD_LOGIC_VECTOR (3 downto 0);
           mem_readData : in  STD_LOGIC_VECTOR (15 downto 0);
           wb_regW : out  STD_LOGIC;
			  wb_memR : out  STD_LOGIC;
           wb_aluResult : out  STD_LOGIC_VECTOR (15 downto 0);
           wb_regDst : out  STD_LOGIC_VECTOR (3 downto 0);
           wb_readData : out  STD_LOGIC_VECTOR (15 downto 0));
end MEM_WB;

architecture Behavioral of MEM_WB is

begin

	process(clk, rst)
	begin
		if (rst = '0') then
			wb_regW <= '0';
			wb_memR <= '0';
			wb_aluResult <= ZeroData;
			wb_regDst <= ZeroAddr;
			wb_readData <= ZeroData;
		elsif (rising_edge(clk)) then
			wb_regW <= mem_regW;
			wb_memR <= mem_memR;
			wb_aluResult <= mem_aluResult;
			wb_regDst <= mem_regDst;
			wb_readData <= mem_readData;
		end if;
	end process;

end Behavioral;

