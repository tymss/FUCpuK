----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:22 11/24/2018 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( rst : in  STD_LOGIC;
           ins : in  STD_LOGIC_VECTOR (15 downto 0);
           reg1 : out  STD_LOGIC_VECTOR (3 downto 0);
           reg2 : out  STD_LOGIC_VECTOR (3 downto 0);
           aluOp : out  STD_LOGIC_VECTOR (2 downto 0);
           imm : out  STD_LOGIC_VECTOR (15 downto 0);
           regDst : out  STD_LOGIC_VECTOR (3 downto 0);
           aluSel : out  STD_LOGIC;
           memR : out  STD_LOGIC;
           memW : out  STD_LOGIC;
           regW : out  STD_LOGIC;
			  TW : out STD_LOGIC;
           b_cont : out  STD_LOGIC_VECTOR (2 downto 0));
end Decoder;

architecture Behavioral of Decoder is
	
	signal imm3 : std_logic_vector (2 downto 0);
	signal imm4 : std_logic_vector (3 downto 0);
	signal imm5 : std_logic_vector (4 downto 0);
	signal imm8 : std_logic_vector (7 downto 0);
	signal imm11 : std_logic_vector (10 downto 0);
	signal imm_extOp : std_logic_vector (2 downto 0);
	component ImmExt
		port(
		rst : in  STD_LOGIC;
      Extop : in  STD_LOGIC_VECTOR (2 downto 0);
      Imm8 : in  STD_LOGIC_VECTOR (7 downto 0);
      Imm4 : in  STD_LOGIC_VECTOR (3 downto 0);
      Imm11 : in  STD_LOGIC_VECTOR (10 downto 0);
      Imm5 : in  STD_LOGIC_VECTOR (4 downto 0);
      Imm3 : in  STD_LOGIC_VECTOR (2 downto 0);
      output : out  STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;	
	
begin
	
	Imm_Ext : ImmExt port map(rst, imm_extOp, imm8, imm4, imm11, imm5, imm3, imm);
	
	process(rst, ins)
	begin
		if (rst = '0') then
			reg1 <= ZeroAddr;
			reg2 <= ZeroAddr;
			aluOp <= "000";
			regDst <= ZeroAddr;
			aluSel <= '0';
			memR <= '0';
			memW <= '0';
			regW <= '0';
			TW <= '0';
			b_cont <= "000";
			imm_extOp <= "000";
			imm3 <= "000";
			imm4 <= "0000";
			imm5 <= "00000";
			imm8 <= "00000000";
			imm11 <= "00000000000";
		else
			case ins(15 downto 11) is
				when "01001" =>   --ADDIU
					reg1 <= '0' & ins(10 downto 8);
					reg2 <= ZeroAddr;
					regDst <= '0' & ins(10 downto 8);
					imm_extOp <= "001";
					imm8 <= ins(7 downto 0);
					aluOp <= "000";
					memR <= '0';
					memW <= '0';
					regW <= '1';
					TW <= '0';
					b_cont <= "000";
					aluSel <= '1';
				when "01000" =>  --ADDIU3
					reg1 <= '0' & ins(10 downto 8);
					reg2 <= ZeroAddr;
					regDst <= '0' & ins(7 downto 5);
					imm_extOp <= "010";
					imm4 <= ins(3 downto 0);
					aluOp <= "000";
					memR <= '0';
					memW <= '0';
					regW <= '1';
					TW <= '0';
					b_cont <= "000";
					aluSel <= '1';
				when "01100" => 
					case ins(10 downto 8) is
						when "011" =>  --ADDSP
							reg1 <= RegSP;
							reg2 <= ZeroAddr;
							regDst <= RegSP;
							imm_extOp <= "001";
							imm8 <= ins(7 downto 0);
							aluOp <= "000";
							memR <= '0';
							memW <= '0';
							regW <= '1';
							TW <= '0';
							b_cont <= "000";
							aluSel <= '1';
						when "000" =>  --BTEQZ
							reg1 <= ZeroAddr;
							reg2 <= ZeroAddr;
							regDst <= ZeroAddr;
							imm_extOp <= "001";
							imm8 <= ins(7 downto 0);
							memR <= '0';
							memW <= '0';
							regW <= '0';
							TW <= '0';
							b_cont <= "101";
						when others =>
							reg1 <= ZeroAddr;
							reg2 <= ZeroAddr;
							aluOp <= "000";
							regDst <= ZeroAddr;
							aluSel <= '0';
							memR <= '0';
							memW <= '0';
							regW <= '0';
							TW <= '0';
							b_cont <= "000";
							imm_extOp <= "000";
							imm3 <= "000";
							imm4 <= "0000";
							imm5 <= "00000";
							imm8 <= "00000000";
							imm11 <= "00000000000";
					end case;
				when "11100" =>  --ADDU
					reg1 <= '0' & ins(10 downto 8);
					reg2 <= '0' & ins(7 downto 5);
					regDst <= '0' & ins(4 downto 2);
					aluOp <= "000";
					memR <= '0';
					memW <= '0';
					regW <= '1';
					TW <= '0';
					b_cont <= "000";
					aluSel <= '0';
				when "11101" =>  
					case ins(4 downto 0) is
						when "01100" =>  --AND
							reg1 <= '0' & ins(10 downto 8);
							reg2 <= '0' & ins(7 downto 5);
							regDst <= '0' & ins(10 downto 8);
							aluOp <= "001";
							memR <= '0';
							memW <= '0';
							regW <= '1';
							TW <= '0';
							b_cont <= "000";
							aluSel <= '0';
						when "01010" =>  --CMP	
						   reg1 <= '0' & ins(10 downto 8);
							reg2 <= '0' & ins(7 downto 5);
							regDst <= ZeroAddr;
							aluOp <= "010";
							memR <= '0';
							memW <= '0';
							regW <= '0';
							TW <= '1';
							b_cont <= "000";
							aluSel <= '0';
						when "00000" =>
							case ins(7 downto 6) is
								when "00" =>  --JR
									reg1 <= '0' & ins(10 downto 8);
									reg2 <= ZeroAddr;
									regDst <= ZeroAddr;
									memR <= '0';
									memW <= '0';
									regW <= '0';
									TW <= '0';
									b_cont <= "010";
								when others =>
									reg1 <= ZeroAddr;
									reg2 <= ZeroAddr;
									aluOp <= "000";
									regDst <= ZeroAddr;
									aluSel <= '0';
									memR <= '0';
									memW <= '0';
									regW <= '0';
									TW <= '0';
									b_cont <= "000";
									imm_extOp <= "000";
									imm3 <= "000";
									imm4 <= "0000";
									imm5 <= "00000";
									imm8 <= "00000000";
									imm11 <= "00000000000";
							end case;		
						when others =>
							reg1 <= ZeroAddr;
							reg2 <= ZeroAddr;
							aluOp <= "000";
							regDst <= ZeroAddr;
							aluSel <= '0';
							memR <= '0';
							memW <= '0';
							regW <= '0';
							TW <= '0';
							b_cont <= "000";
							imm_extOp <= "000";
							imm3 <= "000";
							imm4 <= "0000";
							imm5 <= "00000";
							imm8 <= "00000000";
							imm11 <= "00000000000";
					end case;	
				when "00010" =>  --B
					reg1 <= ZeroAddr;
					reg2 <= ZeroAddr;
					regDst <= ZeroAddr;
					imm_extOp <= "101";
					imm11 <= ins(10 downto 0);
					memR <= '0';
					memW <= '0';
					regW <= '0';
					TW <= '0';
					b_cont <= "001";
				when "00100" =>  --BEQZ
					reg1 <= '0' & ins(10 downto 8);
					reg2 <= ZeroAddr;
					regDst <= ZeroAddr;
					imm_extOp <= "001";
					imm8 <= ins(7 downto 0);
					memR <= '0';
					memW <= '0';
					regW <= '0';
					TW <= '0';
					b_cont <= "011";
				when "00101" =>  --BNEZ
					reg1 <= '0' & ins(10 downto 8);
					reg2 <= ZeroAddr;
					regDst <= ZeroAddr;
					imm_extOp <= "001";
					imm8 <= ins(7 downto 0);
					memR <= '0';
					memW <= '0';
					regW <= '0';
					TW <= '0';
					b_cont <= "100";
				when "01101" =>  --LI
					reg1 <= ZeroAddr;
					reg2 <= ZeroAddr;
					regDst <= '0' & ins(10 downto 8);
					imm_extOp <= "000";
					imm8 <= ins(7 downto 0);
					aluOp <= "000";
					memR <= '0';
					memW <= '0';
					regW <= '1';
					TW <= '0';
					b_cont <= "000";
					aluSel <= '1';
				when "10011" =>  --LW
					reg1 <= '0' & ins(10 downto 8);
					reg2 <= ZeroAddr;
					regDst <= '0' & ins(7 downto 5);
					imm_extOp <= "100";
					imm5 <= ins(4 downto 0);
					aluOp <= "000";
					memR <= '1';
					memW <= '0';
					regW <= '1';
					TW <= '0';
					b_cont <= "000";
					aluSel <= '1';
				when others =>
					reg1 <= ZeroAddr;
					reg2 <= ZeroAddr;
					aluOp <= "000";
					regDst <= ZeroAddr;
					aluSel <= '0';
					memR <= '0';
					memW <= '0';
					regW <= '0';
					TW <= '0';
					b_cont <= "000";
					imm_extOp <= "000";
					imm3 <= "000";
					imm4 <= "0000";
					imm5 <= "00000";
					imm8 <= "00000000";
					imm11 <= "00000000000";
			end case;
		end if;
	end process;

end Behavioral;

