--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:33:46 11/26/2018
-- Design Name:   
-- Module Name:   G:/workspace/FUCpuK/CPU/CPU_test.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
use work.defines.all; 
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CPU_test IS
END CPU_test;
 
ARCHITECTURE behavior OF CPU_test IS 


	 TYPE mem_type is array (0 TO 49152) of std_logic_vector (15 downto 0);
	 signal mem : mem_type := (
	 x"0000",
	x"0000",
	x"0800",
	x"1044",
	x"0800",
	x"0800",
	x"0800",
	x"0800",
	x"6EBF",
	x"36C0",
	x"4E10",
	x"DE00",
	x"DE21",
	x"DE42",
	x"9100",
	x"6301",
	x"68FF",
	x"E90C",
	x"9200",
	x"6301",
	x"63FF",
	x"D300",
	x"63FF",
	x"D700",
	x"6B0F",
	x"EF40",
	x"4F03",
	x"0800",
	x"108A",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1081",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE20",
	x"0800",
	x"6B0F",
	x"EF40",
	x"4F03",
	x"0800",
	x"1077",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"0800",
	x"42C0",
	x"F300",
	x"6880",
	x"3000",
	x"EB0D",
	x"6FBF",
	x"37E0",
	x"4F10",
	x"9F00",
	x"9F21",
	x"9F42",
	x"9700",
	x"6301",
	x"6301",
	x"0800",
	x"F301",
	x"EE00",
	x"93FF",
	x"0800",
	x"6807",
	x"F001",
	x"68BF",
	x"3000",
	x"4810",
	x"6400",
	x"0800",
	x"6EBF",
	x"36C0",
	x"4E10",
	x"6800",
	x"0800",--x"DE00",
	x"0800",--x"DE01",
	x"0800",--x"DE02",
	x"0800",--x"DE03",
	x"0800",--x"DE04",
	x"0800",--x"DE05",
	x"EF40",
	x"4F03",
	x"0800",
	x"104A",
	x"6EBF",
	x"36C0",
	x"684F",
	x"DE00",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1041",
	x"6EBF",
	x"36C0",
	x"684B",
	x"DE00",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1038",
	x"6EBF",
	x"36C0",
	x"680A",
	x"DE00",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"102F",
	x"6EBF",
	x"36C0",
	x"680D",
	x"DE00",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1031",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E20",
	x"6EFF",
	x"E9CC",
	x"0800",
	x"6852",
	x"E82A",
	x"6032",
	x"0800",
	x"6844",
	x"E82A",
	x"604D",
	x"0800",
	x"6841",
	x"E82A",
	x"600E",
	x"0800",
	x"6855",
	x"E82A",
	x"6007",
	x"0800",
	x"6847",
	x"E82A",
	x"6009",
	x"0800",
	x"17E0",
	x"0800",
	x"0800",
	x"10C0",
	x"0800",
	x"0800",
	x"1082",
	x"0800",
	x"0800",
	x"1103",
	x"0800",
	x"0800",
	x"6EBF",
	x"36C0",
	x"4E01",
	x"9E00",
	x"6E01",
	x"E8CC",
	x"20F8",
	x"0800",
	x"EF00",
	x"0800",
	x"0800",
	x"6EBF",
	x"36C0",
	x"4E01",
	x"9E00",
	x"6E02",
	x"E8CC",
	x"20F8",
	x"0800",
	x"EF00",
	x"0800",
	x"6906",
	x"6A06",
	x"68BF",
	x"3000",
	x"4810",
	x"E22F",
	x"E061",
	x"9860",
	x"EF40",
	x"4F03",
	x"0800",
	x"17DE",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"3363",
	x"EF40",
	x"4F03",
	x"0800",
	x"17D5",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"49FF",
	x"0800",
	x"29E6",
	x"0800",
	x"17A2",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"17D2",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9EA0",
	x"6EFF",
	x"EDCC",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"17C7",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E20",
	x"6EFF",
	x"E9CC",
	x"0800",
	x"3120",
	x"E9AD",
	x"EF40",
	x"4F03",
	x"0800",
	x"17BA",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9EA0",
	x"6EFF",
	x"EDCC",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"17AF",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E40",
	x"6EFF",
	x"EACC",
	x"0800",
	x"3240",
	x"EAAD",
	x"9960",
	x"EF40",
	x"4F03",
	x"0800",
	x"1796",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"3363",
	x"EF40",
	x"4F03",
	x"0800",
	x"178D",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"4901",
	x"4AFF",
	x"0800",
	x"2AEA",
	x"0800",
	x"1759",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1789",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9EA0",
	x"6EFF",
	x"EDCC",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"177E",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E20",
	x"6EFF",
	x"E9CC",
	x"0800",
	x"3120",
	x"E9AD",
	x"6800",
	x"E82A",
	x"601D",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"176D",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9EA0",
	x"6EFF",
	x"EDCC",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1762",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E40",
	x"6EFF",
	x"EACC",
	x"0800",
	x"3240",
	x"EAAD",
	x"D940",
	x"0800",
	x"17C9",
	x"0800",
	x"0800",
	x"171E",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"174E",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9EA0",
	x"6EFF",
	x"EDCC",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1743",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E20",
	x"6EFF",
	x"E9CC",
	x"0800",
	x"3120",
	x"E9AD",
	x"EF40",
	x"4F03",
	x"0800",
	x"1736",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9EA0",
	x"6EFF",
	x"EDCC",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"172B",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E40",
	x"6EFF",
	x"EACC",
	x"0800",
	x"3240",
	x"EAAD",
	x"9960",
	x"EF40",
	x"4F03",
	x"0800",
	x"1712",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"3363",
	x"EF40",
	x"4F03",
	x"0800",
	x"1709",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE60",
	x"4901",
	x"4AFF",
	x"0800",
	x"2AEA",
	x"0800",
	x"16D5",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"1705",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9EA0",
	x"6EFF",
	x"EDCC",
	x"0800",
	x"EF40",
	x"4F03",
	x"0800",
	x"16FA",
	x"0800",
	x"6EBF",
	x"36C0",
	x"9E40",
	x"6EFF",
	x"EACC",
	x"0800",
	x"3240",
	x"EAAD",
	x"42C0",
	x"6FBF",
	x"37E0",
	x"4F10",
	x"9FA5",
	x"63FF",
	x"D500",
	x"F500",
	x"6980",
	x"3120",
	x"ED2D",
	x"9F00",
	x"9F21",
	x"9F42",
	x"9F63",
	x"9F84",
	x"EF40",
	x"4F04",
	x"F501",
	x"EE00",
	x"9500",
	x"0800",
	x"0800",
	x"6301",
	x"6FBF",
	x"37E0",
	x"4F10",
	x"DF00",
	x"DF21",
	x"DF42",
	x"DF63",
	x"DF84",
	x"DFA5",
	x"F000",
	x"697F",
	x"3120",
	x"6AFF",
	x"E94D",
	x"E82C",
	x"F001",
	x"6907",
	x"EF40",
	x"4F03",
	x"0800",
	x"16B9",
	x"0800",
	x"6EBF",
	x"36C0",
	x"DE20",
	x"168A",
	x"0800",
	48912=>x"0001",
	48913=>x"0002",
	48914=>x"0003",
	48915=>x"0004",
	48916=>x"0005",
	48917=>x"0006",
	 others => NopIns
	 );

 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         struct_ins_stall : IN  std_logic;
         ins_in : IN  std_logic_vector(15 downto 0);
         ram_data_in : IN  std_logic_vector(15 downto 0);
         ins_addr : OUT  std_logic_vector(15 downto 0);
         ram_addr_out : OUT  std_logic_vector(15 downto 0);
         ram_memR : OUT  std_logic;
         ram_memW : OUT  std_logic;
         ram_data_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal struct_ins_stall : std_logic := '0';
   signal ins_in : std_logic_vector(15 downto 0) := (others => '0');
   signal ram_data_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal ins_addr : std_logic_vector(15 downto 0);
   signal ram_addr_out : std_logic_vector(15 downto 0);
   signal ram_memR : std_logic;
   signal ram_memW : std_logic;
   signal ram_data_out : std_logic_vector(15 downto 0);

	signal serial_time : std_logic_vector(2 downto 0) := "000";
	
   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
  
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          clk => clk,
          rst => rst,
          struct_ins_stall => struct_ins_stall,
          ins_in => ins_in,
          ram_data_in => ram_data_in,
          ins_addr => ins_addr,
          ram_addr_out => ram_addr_out,
          ram_memR => ram_memR,
          ram_memW => ram_memW,
          ram_data_out => ram_data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

	-- mem proc
	mem_proc : process(clk)
	begin
		if (falling_edge(clk)) then
			if ((ram_memR = '0') and (ram_memW = '0')) then
				struct_ins_stall <= '0';
				ins_in <= (mem(to_integer(unsigned(ins_addr))));
			elsif (ram_memR = '1') then
				struct_ins_stall <= '1';
				if (ram_addr_out = x"bf00") then
					if (serial_time = "000") then
						ram_data_in <= x"0052";
						serial_time <= "001";
					elsif (serial_time = "001") then
						ram_data_in <= x"0055";
						serial_time <= "010";
					elsif (serial_time = "010") then
						ram_data_in <= x"0000";
						serial_time <= "011";
					elsif (serial_time = "011") then
						ram_data_in <= x"0040";
						serial_time <= "100";
					elsif (serial_time = "100") then
						ram_data_in <= x"000a";
						serial_time <= "101";
					elsif (serial_time = "101") then
						ram_data_in <= x"0000";
						serial_time <= "110";
					end if;
				elsif (ram_addr_out = x"bf01") then
					ram_data_in <= x"0003";
				else
					ram_data_in <= (mem(to_integer(unsigned(ram_addr_out))));
				end if;
			elsif (ram_memW = '1') then
				struct_ins_stall <= '1';
				(mem(to_integer(unsigned(ram_addr_out)))) <= ram_data_out;			
			end if;	
		end if;
	end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '0';
      wait for 8 ns;	
		rst <= '1';
--		ins_in <= "0110100100000111"; --LI R1 7
--		wait for 20 ns;
--		ins_in <= "0110101000000001";	--LI R2 1
--		wait for 20 ns;
--		ins_in <= "0100000101101111";	--ADDIU3 R1 R3 F
--		wait for 20 ns;
--		ins_in <= "0100001010000000";	--ADDIU3 R2 R4 0
--		wait for 20 ns;
--		ins_in <= "1110010001001001";	--ADDU R4 R2 R2
--		wait for 20 ns;
--		ins_in <= "0100101111111111"; --ADDIU R3 FF
--		wait for 20 ns;
--		ins_in <= "0010101111111101";	--BNEZ R3 FD
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "0110001100000011";	--ADDSP 3
--		wait for 20 ns;
--		ins_in <= "0001011111111111";	--B -1
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "0010010111111111"; --BEQZ R5 -1
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "1110100101001010"; --CMP R1 R2
--		wait for 20 ns;
--		ins_in <= "0110000011111110"; --BTEQZ -2
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "1110100101001100"; --AND R1 R2
--		wait for 20 ns;
--		ins_in <= "1110100100000000"; --JR R1
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "1111000100000000"; --MFIH R1
--		wait for 20 ns;
--		ins_in <= "1110100001000000"; --MFPC R0
--		wait for 20 ns;
--		ins_in <= "1111000000000001"; --MTIH R0
--		wait for 20 ns;
--		ins_in <= "0110010000100000"; --MTSP R1
--		wait for 20 ns;
--		ins_in <= "1110100100001101"; --OR R1 R0
--		wait for 20 ns;
--		ins_in <= "0011000000100100"; --SLL R0 R1 1
--		wait for 20 ns;
--		ins_in <= "0011001000100011"; --SRA R2 R1 0
--		wait for 20 ns;
--		ins_in <= "1110001001111111"; --SUBU R2 R3 R7
--		wait for 20 ns;
--		ins_in <= "1110100000100100"; --SLLV R0 R1
--		wait for 20 ns;
--		ins_in <= "1110100110000011"; --SLTU R1 R4
--		wait for 20 ns;
--		ins_in <= "1110101111100111"; --SRAV R3 R5
--		wait for 20 ns;
--		ins_in <= "0111000000000000"; --CMPI R0 0
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "1101100100000000"; --SW R1 R0 0
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "1001100100000000"; --LW R1 R0 0
--		wait for 20 ns;
--		ins_in <= "0100100000000001"; --ADDIU R0 1 
--		wait for 20 ns;
--		ins_in <= "0000100000000000"; --NOP
--		wait for 20 ns;
--		ins_in <= "1001100100100000"; --LW R1 R1 0
--		wait for 20 ns;
--		ins_in <= "1110100100000000"; --JR R1
--		wait for 20 ns;
--		ins_in <= "0000100000000000";
      -- insert stimulus here 

      wait;
   end process;

END;
