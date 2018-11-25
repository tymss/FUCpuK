----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:16:10 11/26/2018 
-- Design Name: 
-- Module Name:    aPlusC - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aPlusC is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
			  
			  --Ram1 and Serial Port 相关信号
			  data_ready : in STD_LOGIC;
			  tbre : in STD_LOGIC;
			  tsre : in STD_LOGIC;
			  Ram1Data : inout STD_LOGIC_VECTOR (15 downto 0);
			  Ram1Addr : out STD_LOGIC_VECTOR (17 downto 0);
			  Ram1EN : out STD_LOGIC;
			  Ram1WE : out STD_LOGIC;
			  Ram1OE : out STD_LOGIC;
			  rdn : out STD_LOGIC;
			  wrn : out STD_LOGIC;
			  
			  --Ram2 相关信号
			  Ram2Data : inout STD_LOGIC_VECTOR (15 downto 0);
			  Ram2Addr : out STD_LOGIC_VECTOR (17 downto 0);
			  Ram2EN : out STD_LOGIC;
			  Ram2WE : out STD_LOGIC;
			  Ram2OE : out STD_LOGIC);
end aPlusC;

architecture Behavioral of aPlusC is
	
	component CPU
		Port ( 
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		struct_ins_stall : in STD_LOGIC;   --取指令阶段结构冲突暂停流水
		ins_in : in STD_LOGIC_VECTOR (15 downto 0);	--取到的指令
		ram_data_in : in STD_LOGIC_VECTOR (15 downto 0);  --访存得到的数据
		ins_addr : out STD_LOGIC_VECTOR (15 downto 0);	--指令地址
		ram_addr_out : out STD_LOGIC_VECTOR (15 downto 0);  --访存地址
		ram_memR : out STD_LOGIC;
		ram_memW : out STD_LOGIC;
		ram_data_out : out STD_LOGIC_VECTOR (15 downto 0)  --需要写入内存的数据
		);
	end component;
	
	component MemTop
		Port (
		clk : in STD_LOGIC;
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
		Ram2OE : out STD_LOGIC			 
		
		--TODO: FLASH PS2 VGA
		);
	end component;
	
	signal ins_stall : std_logic;
	signal ins : std_logic_vector (15 downto 0);
	signal ram_data_r : std_logic_vector (15 downto 0);
	signal ram_data_w : std_logic_vector (15 downto 0);
	signal ins_addr : std_logic_vector (15 downto 0);
	signal ram_addr : std_logic_vector (15 downto 0);
	signal memR : std_logic;
	signal memW : std_logic;
	
begin
	
	my_cpu : CPU port map(clk=>clk, rst=>rst, struct_ins_stall=>ins_stall, ins_in=>ins, ram_data_in=>ram_data_r,
								 ins_addr=>ins_addr, ram_addr_out=>ram_addr, ram_memR=>memR, ram_memW=>memW, ram_data_out=>ram_data_w);
								 
	my_memtop : MemTop port map(clk=>clk, rst=>rst, ins_addr=>ins_addr, ins_out=>ins, ins_stall=>ins_stall, memR=>memR,
										 memW=>memW, mem_addr=>ram_addr, mem_dataW=>ram_data_w, mem_dataOut=>ram_data_r,
										 data_ready=>data_ready, tbre=>tbre, tsre=>tsre, Ram1Addr=>Ram1Addr, Ram1Data=>Ram1Data,
										 Ram1EN=>Ram1EN, Ram1WE=>Ram1WE, Ram1OE=>Ram1OE, rdn=>rdn, wrn=>wrn, Ram2Addr=>Ram2Addr,
										 Ram2Data=>Ram2Data, Ram2EN=>Ram2EN, Ram2WE=>Ram2WE, Ram2OE=>Ram2OE);
											
	
end Behavioral;

