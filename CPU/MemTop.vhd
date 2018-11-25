----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:01:14 11/25/2018 
-- Design Name: 
-- Module Name:    MemTop - Behavioral 
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

entity MemTop is
	Port ( clk : in STD_LOGIC;
			 rst : in STD_LOGIC;
			 
			 --if¶Î
			 ins_addr : in STD_LOGIC_VECTOR (15 downto 0);
			 ins_out : out STD_LOGIC_VECTOR (15 downto 0);
			 ins_stall : out STD_LOGIC;
			 
			 --mem¶Î
			 memR : in STD_LOGIC;
			 memW : in STD_LOGIC;
			 mem_addr : in STD_LOGIC_VECTOR (15 downto 0);
			 mem_dataW : in STD_LOGIC_VECTOR (15 downto 0);
			 mem_dataOut : out STD_LOGIC_VECTOR (15 downto 0);
			 
			 --ram1 and serialport
			 data_ready : in STD_LOGIC;
			 tbre : in STD_LOGIC;
			 tsre : in STD_LOGIC;
			 Ram1Addr : out STD_LOGIC_VECTOR (17 downto 0);
			 Ram1Data : inout STD_LOGIC_VECTOR (15 downto 0);
			 Ram1EN : out STD_LOGIC;
			 Ram1WE : out STD_LOGIC;
			 Ram1OE : out STD_LOGIC;
			 rdn : out STD_LOGIC;
			 wrn : out STD_LOGIC;
			 
			 --ram2
			 Ram2Addr : out STD_LOGIC_VECTOR (17 downto 0);
			 Ram2Data : inout STD_LOGIC_VECTOR (15 downto 0);
			 Ram2EN : out STD_LOGIC;
			 Ram2WE : out STD_LOGIC;
			 Ram2OE : out STD_LOGIC
			 
			 --TODO: FLASH PS2 VGA
			 );
end MemTop;

architecture Behavioral of MemTop is
	
	signal finishLoad : std_logic;
	signal write_ready : std_logic;
	signal read_ready : std_logic;
	signal ins_ctrl : std_logic;
	
begin

	finishLoad <= '1';  --TODO: FLASH finish
	
	ins_stall_process : process(memR, memW)
	begin
		if ((memR = '1') or (memW = '1')) then
			ins_ctrl <= '1';
		else
			ins_ctrl <= '0';
		end if;	
	end process;
	
	ins_stall <= ins_ctrl;
	
	Ram1WE_process : process(rst, clk, mem_addr, memW, finishLoad)
	begin
		if (rst = '0') then
			Ram1WE <= '1';
		elsif ((finishLoad = '1') and (memW = '1')) then
			Ram1WE <= clk;
		else
			Ram1WE <= '1';
		end if;	
	end process;

	wrn_process : process(rst, clk, memW, write_ready, finishLoad)
	begin
		if (rst = '0') then
			wrn <= '1';
		elsif ((write_ready = '1') and (finishLoad = '1') and (memW = '1')) then
			wrn <= clk;
		else
			wrn <= '1';
		end if;	
	end process;
	
	rdn_process : process(rst, clk, memR, read_ready, finishLoad)
	begin
		if (rst = '0') then
			rdn <= '1';
		elsif ((read_ready = '1') and (finishLoad = '1') and (memR = '1')) then
			rdn <= clk;
		else
			rdn <= '1';
		end if;	
	end process;
	
	Ram1_process : process(rst, ins_addr, mem_addr, memR, memW, mem_dataW, data_ready, tbre, tsre, finishLoad)
	begin
		if (rst = '0') then
			Ram1EN <= '0';
			Ram1OE <= '1';
			Ram1Addr <= "00" & ZeroData;
			Ram1Data <= AllZData;
			read_ready <= '0';
			write_ready <= '0';
		else
			if (finishLoad = '1') then
				if ((memR = '1') and (memW = '1')) then
					Ram1Addr <= "00" & ins_addr;
				else
					Ram1Addr <= "00" & mem_addr;
				end if;
				if ((memR = '1') and (memW = '1')) then
					read_ready <= '0';
					write_ready <= '0';
					Ram1EN <= '0';
					Ram1OE <= '0';
					Ram1Data <= AllZData;
				end if;	
			else
				--¶ÁÈ¡flashData
			end if;
		end if;	
	end process;
	
end Behavioral;

