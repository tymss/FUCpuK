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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

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
         Ram2OE : out STD_LOGIC;
         
         --Flash 相关信号
         FlashData : inout STD_LOGIC_VECTOR (15 downto 0);
         FlashAddr : out STD_LOGIC_VECTOR (22 downto 1);
         FlashOE : out STD_LOGIC;
         FlashCE : out STD_LOGIC;
         FlashWE : out STD_LOGIC;
         FlashRP : out STD_LOGIC;
         FlashByte : out STD_LOGIC;
         FlashVpen : out STD_LOGIC;
         
         --VGA 相关信号
         VGAHS : out STD_LOGIC;
         VGAVS : out STD_LOGIC;
         VGAR : out STD_LOGIC_VECTOR (2 downto 0);
         VGAG : out STD_LOGIC_VECTOR (2 downto 0);
         VGAB : out STD_LOGIC_VECTOR (2 downto 0);
         
         --Debug
         LEDout : out STD_LOGIC_VECTOR (15 downto 0);
         
         -- PS2
         PS2_CLK : in std_logic;
         PS2_DATA : in std_logic
         );
end aPlusC;

architecture Behavioral of aPlusC is
  
  component CPU
    Port ( 
      --debug : out STD_LOGIC_VECTOR (15 downto 0);
      
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
      Ram2OE : out STD_LOGIC;			 
      
      --Flash
      FlashData : inout STD_LOGIC_VECTOR (15 downto 0);
      FlashWE : out STD_LOGIC;
      FlashOE : out STD_LOGIC;
      FlashCE : out STD_LOGIC;
      FlashRP : out STD_LOGIC;
      FlashByte : out STD_LOGIC;
      FlashVpen : out STD_LOGIC;
      FlashAddr : out STD_LOGIC_VECTOR (22 downto 1);		

      --VGA
      VGAAddr : in STD_LOGIC_VECTOR (17 downto 0);
      VGAData : out STD_LOGIC_VECTOR (15 downto 0);
      GPUPos : out STD_LOGIC_VECTOR (15 downto 0);
      GPUData : out STD_LOGIC_VECTOR (15 downto 0);
      GPUWrite : out STD_LOGIC;
      
      --PS2
      ASCII_Input : in std_logic_vector(15 downto 0);
      ASCII_OE : in std_logic
     --debug : out STD_LOGIC_VECTOR (15 downto 0)
      );
  end component;
  
  component vga
    port(
      clk : in std_logic;

      -- gpu position
      gpu_pos : out std_logic_vector(11 downto 0);
      -- data from gpu according to gpu 
      gpu_data : in std_logic_vector(15 downto 0);
      
      -- data from ram2
      ram_data : in std_logic_vector(15 downto 0);
      -- ram2 address
      ram_addr : out std_logic_vector(17 downto 0);
      
      -- synchro signal
      HS, VS : out std_logic;

      -- colour
      R : out std_logic_vector(2 downto 0);
      G : out std_logic_vector(2 downto 0);
      B : out std_logic_vector(2 downto 0)
      );
  end component;

  
  COMPONENT TM
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKFX_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;
  
  COMPONENT GPU
    PORT (
      clka : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      clkb : IN STD_LOGIC;
      addrb : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
      doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
      );
  END COMPONENT;
  
  component PS2
    port(
      FCLK, RST: in std_logic;
      PS2_CLK, PS2_DATA: in std_logic;
      SCANCODE: out std_logic_vector(7 downto 0);
      OE: out std_logic
		);      
  end component;

  component ps2ascii
    port(
      CLK, RST: in std_logic;
      PS2_DATA: in std_logic_vector(7 downto 0);
      PS2_OE: in std_logic;
      ASCII: out std_logic_vector(15 downto 0);
      ASCII_OE: out std_logic
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
  
  signal clk_2 : std_logic;
  signal my_clk : std_logic;
  
  signal fakerst : std_logic;
  
  signal vga_data : std_logic_vector (15 downto 0);
  signal vga_addr : std_logic_vector (17 downto 0);
  signal gpu_pos_pre : std_logic_vector (15 downto 0);
  signal gpu_pos_s : std_logic_vector (11 downto 0);
  signal gpu_data_s : std_logic_vector (15 downto 0);
  signal gpu_write : std_logic;
  signal gpu_we : std_logic_vector (0 downto 0);
  
  signal gpu_pos_l : std_logic_vector (11 downto 0);
  signal gpu_data_l : std_logic_vector (15 downto 0);
  
  signal PS2DATA: std_logic_vector(7 downto 0);
  signal PS2OE: std_logic;

  signal ASCII: std_logic_vector(15 downto 0);
  signal ASCII_OE: std_logic;
  
begin
  
  LEDout <= "0000000000000000";
  --LEDout <= ins_addr(12 downto 0) & data_ready & tbre & tsre;
  --LEDout <= gpu_we & gpu_pos_pre(6 downto 0) & gpu_pos_s(7 downto 0);
  --LEDout <= memW & ram_addr(3 downto 0) & gpu_pos_s(10 downto 0);
  --my_clk <= clk;
  
  pos_stall : process(my_clk)
  begin
	if (rising_edge(my_clk)) then
		if ((ram_addr = x"bf0a") and (memW = '1')) then
			gpu_pos_s <= conv_std_logic_vector(conv_integer(gpu_pos_pre(15 downto 8)) * 80 + conv_integer(gpu_pos_pre(7 downto 0)), 12);
		end if;
	end if;
  end process;
  
  process(clk)
  begin
    if (rising_edge(clk)) then
      clk_2 <= not clk_2;
    end if;
  end process;
  
  fakerst <= '0';
  
  gpu_we(0) <= gpu_write;	
  
  my_clk <= clk_2;
  
  --my_dcm : TM port map(CLKIN_IN=>clk, RST_IN=>fakerst, CLKFX_OUT=>my_clk);

  my_cpu : CPU port map(clk=>my_clk, rst=>rst, struct_ins_stall=>ins_stall, ins_in=>ins, ram_data_in=>ram_data_r,
                        ins_addr=>ins_addr, ram_addr_out=>ram_addr, ram_memR=>memR, ram_memW=>memW, ram_data_out=>ram_data_w);
  
  my_memtop : MemTop port map(clk=>my_clk, rst=>rst, ins_addr=>ins_addr, ins_out=>ins, ins_stall=>ins_stall, memR=>memR,
                              memW=>memW, mem_addr=>ram_addr, mem_dataW=>ram_data_w, mem_dataOut=>ram_data_r,
                              data_ready=>data_ready, tbre=>tbre, tsre=>tsre, Ram1Addr=>Ram1Addr, Ram1Data=>Ram1Data,
                              Ram1EN=>Ram1EN, Ram1WE=>Ram1WE, Ram1OE=>Ram1OE, rdn=>rdn, wrn=>wrn, Ram2Addr=>Ram2Addr,
                              Ram2Data=>Ram2Data, Ram2EN=>Ram2EN, Ram2WE=>Ram2WE, Ram2OE=>Ram2OE, FlashData=>FlashData,
                              FlashWE=>FlashWE, FlashOE=>FlashOE, FlashCE=>FlashCE, FlashRP=>FlashRP, FlashByte=>FlashByte,
                              FlashVpen=>FlashVpen, FlashAddr=>FlashAddr, VGAAddr=>vga_addr, VGAData=>vga_data, GPUPos=>gpu_pos_pre,
                              GPUData=>gpu_data_s, GPUWrite=>gpu_write, ASCII_Input=>ASCII, ASCII_OE=>ASCII_OE);
  
  my_vga : VGA port map(clk=>my_clk, gpu_pos=>gpu_pos_l, gpu_data=>gpu_data_l, ram_data=>vga_data, ram_addr=>vga_addr,
                        HS=>VGAHS, VS=>VGAVS, R=>VGAR, G=>VGAG, B=>VGAB);
  
  my_gpu : GPU port map(clka=>my_clk, wea=>gpu_we, addra=>gpu_pos_s, dina=>gpu_data_s, clkb=>my_clk, addrb=>gpu_pos_l, doutb=>gpu_data_l);							 

  my_ps2 : PS2 port map(FCLK=>my_clk, RST=>rst, PS2_CLK=>PS2_CLK, PS2_DATA=>PS2_DATA, SCANCODE=>PS2DATA, OE=>PS2OE);

  my_ps2ascii : ps2ascii port map(CLK=>my_clk, RST=>rst, PS2_DATA=>PS2DATA, PS2_OE=>PS2OE, ASCII=>ASCII, ASCII_OE=>ASCII_OE);
end Behavioral;

