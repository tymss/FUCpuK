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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CPU_test IS
END CPU_test;
 
ARCHITECTURE behavior OF CPU_test IS 
 
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '0';
      wait for 8 ns;	
		rst <= '1';
		ins_in <= "0110100100000111"; --LI R1 7
		wait for 20 ns;
		ins_in <= "0110101000000001";	--LI R2 1
		wait for 20 ns;
		ins_in <= "0100000101101111";	--ADDIU3 R1 R3 F
		wait for 20 ns;
		ins_in <= "0100001010000000";	--ADDIU3 R2 R4 0
		wait for 20 ns;
		ins_in <= "1110010001001001";	--ADDU R4 R2 R2
		wait for 20 ns;
		ins_in <= "0100101111111111"; --ADDIU R3 FF
		wait for 20 ns;
		ins_in <= "0010101111111101";	--BNEZ R3 FD
		wait for 20 ns;
		ins_in <= "0000100000000000"; --NOP
		wait for 20 ns;
		ins_in <= "0110001100000011";	--ADDSP 3
		wait for 20 ns;
		ins_in <= "0001011111111111";	--B -1
		wait for 20 ns;
		ins_in <= "0000100000000000"; --NOP
		wait for 20 ns;
		ins_in <= "0010010111111111"; --BEQZ R5 -1
		wait for 20 ns;
		ins_in <= "0000100000000000"; --NOP
		wait for 20 ns;
		ins_in <= "1110100101001010"; --CMP R1 R2
		wait for 20 ns;
		ins_in <= "0110000011111110"; --BTEQZ -2
		wait for 20 ns;
		ins_in <= "0000100000000000"; --NOP
		wait for 20 ns;
		ins_in <= "1110100101001100"; --AND R1 R2
		wait for 20 ns;
		ins_in <= "1110100100000000"; --JR R1
		wait for 20 ns;
		ins_in <= "0000100000000000"; --NOP
		wait for 20 ns;
		ins_in <= "1111000100000000"; --MFIH R1
		wait for 20 ns;
		ins_in <= "1110100001000000"; --MFPC R0
		wait for 20 ns;
		ins_in <= "1111000000000001"; --MTIH R0
		wait for 20 ns;
		ins_in <= "0110010000100000"; --MTSP R1
		wait for 20 ns;
		ins_in <= "1110100100001101"; --OR R1 R0
		wait for 20 ns;
		ins_in <= "0011000000100100"; --SLL R0 R1 1
		wait for 20 ns;
		ins_in <= "0011001000100011"; --SRA R2 R1 0
		wait for 20 ns;
		ins_in <= "1110001001111111"; --SUBU R2 R3 R7
		wait for 20 ns;
		ins_in <= "1110100000100100"; --SLLV R0 R1
		wait for 20 ns;
		ins_in <= "1110100110000011"; --SLTU R1 R4
		wait for 20 ns;
		ins_in <= "1110101111100111"; --SRAV R3 R5
		wait for 20 ns;
		ins_in <= "0111000000000000"; --CMPI R0 0
		wait for 20 ns;
		ins_in <= "0000100000000000"; --NOP
		wait for 20 ns;
		ins_in <= "1101100100000000"; --SW R1 R0 0
		wait for 20 ns;
		ins_in <= "0000100000000000"; --NOP
		wait for 20 ns;
		ins_in <= "1001100100000000"; --LW R1 R0 0
		wait for 20 ns;
		ins_in <= "0100100000000001"; --ADDIU R0 1 
		wait for 20 ns;
		ins_in <= "0000100000000000";
      -- insert stimulus here 

      wait;
   end process;

END;
