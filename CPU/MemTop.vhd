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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
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
			 
			 --if段
			 ins_addr : in STD_LOGIC_VECTOR (15 downto 0);
			 ins_out : out STD_LOGIC_VECTOR (15 downto 0);
			 ins_stall : out STD_LOGIC;
			 
			 --mem段
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
			 Ram2OE : out STD_LOGIC;
			 
			 --Flash
			 FlashData : inout STD_LOGIC_VECTOR (15 downto 0);
			 FlashWE : out STD_LOGIC;
			 FlashOE : out STD_LOGIC;
			 FlashCE : out STD_LOGIC;
			 FlashRP : out STD_LOGIC;
			 FlashByte : out STD_LOGIC;
			 FlashVpen : out STD_LOGIC;
			 FlashAddr : out STD_LOGIC_VECTOR (22 downto 1)
			 
			 --Debug
			 --debug : out STD_LOGIC_VECTOR (15 downto 0)
			 
			 --TODO: PS2 VGA
			 );
end MemTop;

architecture Behavioral of MemTop is
	
	component Flash
		Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           addr_in : in  STD_LOGIC_VECTOR (22 downto 1);
           Flash_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
           finish_read : out  STD_LOGIC;
           Byte : out  STD_LOGIC;
           CE : out  STD_LOGIC;
           WE : out  STD_LOGIC;
           OE : out  STD_LOGIC;
           RP : out  STD_LOGIC;
           Vpen : out  STD_LOGIC;
           Flash_addr : out  STD_LOGIC_VECTOR (22 downto 1));		
	end component;
	signal finishLoad : std_logic;
	signal write_ready : std_logic;
	signal read_ready : std_logic;
	signal ins_ctrl : std_logic;

	signal rst_flash : std_logic;
	signal clk_2, clk_4, clk_flash : std_logic;  --Flash时钟8分频
	signal flash_addr_in : std_logic_vector (22 downto 1);
	signal flash_finish : std_logic;
	signal flash_out : std_logic_vector (15 downto 0);
	
	signal flash_ins_addr : std_logic_vector (15 downto 0);
	
	constant flash_ins_num : integer := 800;
	
begin

	--DEBUG
	--debug <= flash_out;
	--finishLoad <= '1';


	--flash时钟分频
	process(clk)
	begin
		if (rising_edge(clk)) then
			clk_2 <= not clk_2;
		end if;
	end process;
	
	process(clk_2)
	begin
		if (rising_edge(clk_2)) then
			clk_4 <= not clk_4;
		end if;
	end process;
	
	process(clk_4)
	begin
		if (rising_edge(clk_4)) then
			clk_flash <= not clk_flash;
		end if;
	end process;
	
	flash_process : process(clk_flash, rst)
	begin
		if (rst = '0') then
			rst_flash <= '0';
			flash_addr_in <= (others => '0');
			finishLoad <= '0';
			flash_ins_addr <= (others => '0');
		elsif (rising_edge(clk_flash)) then
			if (finishLoad = '1') then
				rst_flash <= '0';
			else
				rst_flash <= '1';
				flash_addr_in <= "000000" & flash_ins_addr;
				if (flash_finish = '1') then
					if (flash_ins_addr = flash_ins_num) then
						finishLoad <= '1';
						rst_flash <= '0';
					else
						flash_ins_addr <= flash_ins_addr + 1;
					end if;
				end if;
			end if;
		end if;	
	end process;
	
	my_flash : Flash port map(clk=>clk_flash, rst=>rst_flash, addr_in=>flash_addr_in, Flash_data=>FlashData,
									  output=>flash_out, finish_read=>flash_finish, Byte=>FlashByte, CE=>FlashCE, 
									  WE=>FlashWE, OE=>FlashOE, RP=>FlashRP, Vpen=>FlashVpen, Flash_addr=>FlashAddr);
	
	ins_stall_process : process(memR, memW)
	begin
		if ((memR = '1') or (memW = '1') or (finishLoad = '0')) then
			ins_ctrl <= '1';
		else
			ins_ctrl <= '0';
		end if;	
	end process;
	
	ins_stall <= ins_ctrl;
		
	
	Ram1WE_process : process(rst, clk, mem_addr, memW, finishLoad)
	begin
		if ((rst = '0') or (mem_addr = x"bf00") or (mem_addr = x"bf01")) then
			Ram1WE <= '1';
		elsif (((finishLoad = '1') and (memW = '1')) or (finishLoad = '0')) then
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
	
	Ram1_process : process(rst, ins_addr, mem_addr, memR, memW, mem_dataW, data_ready, tbre, tsre, finishLoad, flash_out, flash_ins_addr)
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
				if ((memR = '0') and (memW = '0')) then
					Ram1Addr <= "00" & ins_addr;
					read_ready <= '0';
					write_ready <= '0';
					Ram1EN <= '0';
					Ram1OE <= '0';
					Ram1Data <= AllZData;
				elsif (memR = '1') then
					Ram1Addr <= "00" & mem_addr;
					if (mem_addr = x"bf00") then  --serial port read
						Ram1EN <= '1';
						Ram1OE <= '1';
						Ram1Data <= AllZData;
						read_ready <= '1';
						write_ready <= '0';
					elsif (mem_addr = x"bf01") then  --serial check
						Ram1EN <= '0';
						Ram1OE <= '1';
						read_ready <= '0';
						write_ready <= '0';
						if ((data_ready = '1') and (tbre = '1') and (tsre = '1')) then  --R and W
							Ram1Data <= x"0003";
						elsif ((tbre = '1') and (tsre = '1')) then --W
							Ram1Data <= x"0001";
						elsif (data_ready = '1') then --R
							Ram1Data <= x"0002";
						else
							Ram1Data <= ZeroData;
						end if;
					else								--read mem
						Ram1EN <= '0';
						Ram1OE <= '0';
						Ram1Data <= AllZData;
						read_ready <= '0';
						write_ready <= '0';
					end if;
				elsif (memW = '1') then
					Ram1Addr <= "00" & mem_addr;
					if (mem_addr = x"bf00") then  --serial port write
						Ram1EN <= '1';
						Ram1OE <= '1';
						Ram1Data <= mem_dataW;
						read_ready <= '0';
						write_ready <= '1';
					else									--mem data write
						Ram1EN <= '0';
						Ram1OE <= '1';
						Ram1Data <= mem_dataW;
						read_ready <= '0';
						write_ready <= '0';
					end if;
				else
					Ram1EN <= '0';
					Ram1OE <= '1';
					Ram1Data <= AllZData;
					read_ready <= '0';
					write_ready <= '0';
				end if;	
			else
				--写入flash数据
				Ram1EN <= '0';
				Ram1OE <= '1';
				Ram1Addr <= "00" & flash_ins_addr;
				Ram1Data <= flash_out;
				read_ready <= '0';
				write_ready <= '0';
			end if;
		end if;	
	end process;
	
	mem_dataOut <= Ram1Data;
	
	ins_process : process(rst, ins_ctrl, Ram1Data, finishLoad)
	begin
		if (rst = '0') then
			ins_out <= NopIns;
		elsif ((ins_ctrl = '0') and (finishLoad = '1')) then
			ins_out <= Ram1Data;
		else
			ins_out <= NopIns;
		end if;	
	end process;
	
end Behavioral;

