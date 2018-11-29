library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity vga is
  port(
    clk : in std_logic;

    -- gpu position
    gpu_pos : out std_logic_vector(11 downto 0);
    -- data from gpu according to gpu 
    gpu_data : in std_logic_vector(7 downto 0);
    
    -- data from ram2
    ram_data : in std_logic_vector(11 downto 0);
    -- ram2 address
    ram_addr : out std_logic_vector(15 downto 0);
    
    -- synchro signal
    HS, VS : out std_logic;

    -- colour
    R : out std_logic_vector(2 downto 0);
    G : out std_logic_vector(2 downto 0);
    B : out std_logic_vector(2 downto 0)
);
end vga;


architecture Behaviour of vga is
  -- initial address for image
  constant start_addr: std_logic_vector(17 downto 0) := "000000000000000000";
  -- block size
  constant img_size: integer := 96;
  
  -- counting block
  signal H_count, V_count : integer := 0;
  -- next block 
  signal next_H_count, next_V_count : integer := 0;

  -- Block information
  -- now x, y coordinate
  signal block_x, block_y : integer := 0;
  -- next x, y coordinate
  signal next_block_x, next_block_y : integer := 0;
  -- R, G, B for block
  signal R_block, G_block, B_block : integer := 0;
  -- receive current block info
  signal current_block : std_logic_vector(15 downto 0);
  -- pixel relatively with block
  signal pixel_x : integer := 0;
  signal pixel_y : integer := 0;

begin

  -- calculate next H_count
  nexH: process(H_count)
  begin
    if (H_count = 799) then
      next_H_count <= 0;
    else
      next_H_count <= H_count + 1;
    end if; 
  end process;
    
  -- calculate next V_count
  nextV: process(H_count, V_count)
  begin
    if (H_count = 799) then
      if(V_count = 599) then
        next_V_count <= 0;
      else
        next_V_count <= V_count + 1;
      end if; 
    else 
      next_V_count <= V_count;
    end if;
  end process;

  -- calculate which block
  block_x <= H_count / 8;
  block_y <= V_count / 12;
  -- calclate pixel coordination
  pixel_x <= H_count - 8 * block_x;
  pixel_y <= V_count - 12 * block_y;
  -- calculate next block
  next_block_x <= next_H_count / 8;
  next_block_y <= next_V_count / 12;

  -- next block
  pos_in <= conv_std_logic_vector(next_block_x + 80 * next_block_y, 12);
  -- block colour
  R_block <= conv_integer(current_block(15 downto 13));
  G_block <= conv_integer(current_block(12 downto 10));
  B_block <= conv_integer(current_block(9 downto 7));

  -- request ram_addr
  ram_addr <= start_addr + conv_integer(data_in(7 downto 0)) * img_size + pixel_x + pixel_y * 8;

  display: process(H_count, V_count, ram_data)
  begin
    if (V_count >= 480 or H_count >= 640) then
      R <= "000";
      G <= "000";
      B <= "000";
    else
      R <= ram_data(2 downto 0);
      G <= ram_data(5 downto 3);
      B <= ram_data(8 downto 6);
    end if;
  end process;

  update : process(V_count, H_count)
  begin
    if (H_count >= 656 and H_count <= 751) then
      HS <= '0';
    else
      HS <= '1';
    end if;
    if (V_count >= 490 and V_count <= 491) then
      VS <= '0';
    else 
      VS <= '1';
    end if;
  end process;

  Hupdate : process(clk)
  begin
    if (rising_edge(clk)) then
      if (H_count < 799) then
        H_count <= H_count + 1;
      else 
        H_count <= 0;
      end if;
    end if;
  end process;

  Vupdate : process(clk)
    begin
      if (rising_edge(clk)) then
        if(H_count = 799) then
          if (V_count < 524) then
            V_count <= V_count + 1;
          else        
            V_count <= 0;
          end if;
        end if;
      end if;
    end process;

end Behaviour;
