----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:08:26 11/24/2018 
-- Design Name: 
-- Module Name:    ID_EXE - Behavioral 
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

entity ID_EXE is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           flush_structure : in  STD_LOGIC;
           flush_hazard : in  STD_LOGIC;
           id_reg1 : in  STD_LOGIC_VECTOR (15 downto 0);
           id_reg2 : in  STD_LOGIC_VECTOR (15 downto 0);
           id_reg1addr : in  STD_LOGIC_VECTOR (3 downto 0);
           id_reg2addr : in  STD_LOGIC_VECTOR (3 downto 0);
           id_imm : in  STD_LOGIC_VECTOR (15 downto 0);
           id_regDst : in  STD_LOGIC_VECTOR (3 downto 0);
           id_aluSel : in  STD_LOGIC;
           id_memR : in  STD_LOGIC;
           id_memW : in  STD_LOGIC;
           id_regW : in  STD_LOGIC;
           id_aluOp : in  STD_LOGIC_VECTOR (2 downto 0);
           exe_reg1 : out  STD_LOGIC_VECTOR (15 downto 0);
           exe_reg2 : out  STD_LOGIC_VECTOR (15 downto 0);
           exe_reg1addr : out  STD_LOGIC_VECTOR (3 downto 0);
           exe_reg2addr : out  STD_LOGIC_VECTOR (3 downto 0);
           exe_regDst : out  STD_LOGIC_VECTOR (3 downto 0);
           exe_imm : out  STD_LOGIC_VECTOR (15 downto 0);
           exe_aluSel : out  STD_LOGIC;
           exe_aluOp : out  STD_LOGIC_VECTOR (2 downto 0);
           exe_memR : out  STD_LOGIC;
           exe_memW : out  STD_LOGIC;
           exe_regW : out  STD_LOGIC;
			  exe_lastLW : out STD_LOGIC);
end ID_EXE;

architecture Behavioral of ID_EXE is

begin

	process(clk, rst)
	begin
		if (rst = '0') then 
			exe_reg1 <= ZeroData;
			exe_reg2 <= ZeroData;
			exe_imm <= ZeroData;
			exe_reg1addr <= ZeroAddr;
			exe_reg2addr <= ZeroAddr;
			exe_regDst <= ZeroAddr;
			exe_aluSel <= '0';
			exe_aluOp <= "000";
			exe_memR <= '0';
			exe_memW <= '0';
			exe_regW <= '0';
			exe_lastLW <= '0';
		elsif (rising_edge(clk)) then
			if ((flush_structure = '1') or (flush_hazard = '1')) then
				exe_reg1 <= ZeroData;
				exe_reg2 <= ZeroData;
				exe_imm <= ZeroData;
				exe_reg1addr <= ZeroAddr;
				exe_reg2addr <= ZeroAddr;
				exe_regDst <= ZeroAddr;
				exe_aluSel <= '0';
				exe_aluOp <= "000";
				exe_memR <= '0';
				exe_memW <= '0';
				exe_regW <= '0';
				if (flush_hazard = '1') then
					exe_lastLW <= '1';
				end if;
			else
				exe_reg1 <= id_reg1;
				exe_reg2 <= id_reg2;
				exe_imm <= id_imm;
				exe_reg1addr <= id_reg1addr;
				exe_reg2addr <= id_reg2addr;
				exe_regDst <= id_regDst;
				exe_aluSel <= id_aluSel;
				exe_aluOp <= id_aluOp;
				exe_memR <= id_memR;
				exe_memW <= id_memW;
				exe_regW <= id_regW;
				exe_lastLW <= '0';
			end if;
		end if;
	end process;

end Behavioral;

