library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity PS2 is
  port (
    FCLK, RST: in std_logic;
    -- clk and data from ps2
    PS2_CLK, PS2_DATA: in std_logic;
    -- input from ps2
    SCANCODE: out std_logic_vector(7 downto 0);
    -- ?
    OE: out std_logic
);      
end PS2;

architecture behaviour of PS2 is
  type state_type is (delay, start, s0, s1, s2, s3, s4, s5, s6, s7, checksum, last, finish);
  signal data: std_logic;
  signal clk, clk1, clk2: std_logic;
  signal odd_num, complete: std_logic;
  signal code: std_logic_vector(7 downto 0);
  signal state: state_type;

begin
  clk1 <= PS2_CLK when rising_edge(FCLK);
  clk2  <= clk1 when rising_edge(FCLK);
  clk <= (not clk1) and clk2;
  
  data <= PS2_DATA when rising_edge(FCLK);
  
  odd_num <= code(0) xor code(1) xor code(2) xor code(3) xor code(4) xor code(5) xor code(6) xor code(7);

  SCANCODE <= code when complete = '1';

  process(RST, FCLK)
  begin
    if rising_edge(FCLK) then
      complete <= '0';
      OE <= '0';

      case state is

        when delay =>
          state <= start;

        when start => 
          if clk = '1' then
            if data = '0' then
              state <= s0;
            else
              state <= delay;
            end if;
          end if;
          
        when s0 =>
          if clk = '1' then
            code(0) <= data;
            state <= s1;
          end if;
          
        when s1 =>
          if clk = '1' then
            code(1) <= data;
            state <= s2;
          end if;
          
        when s2 =>
          if clk = '1' then
            code(2) <= data;
            state <= s3;
          end if;

        when s3 =>
          if clk = '1' then
            code(3) <= data;
            state <= s4;
          end if;

        when s4 =>
          if clk = '1' then
            code(4) <= data;
            state <= s5;
          end if;


        when s5 =>
          if clk = '1' then
            code(5) <= data;
            state <= s6;
          end if;
          
        when s6 =>
          if clk = '1' then
            code(6) <= data;
            state <= s7;
          end if;

        when s7 =>
          if clk = '1' then
            code(7) <= data;
            state <= checksum;
          end if;

        when checksum =>
          if clk = '1' then
            if (odd xor data) = '1' then
              state <= last;
            else
              state <= delay;
            end if;
          end if;

        when last =>
          if clk = '1' then
            if data = '1' then
              state <= finish;
            else
              state <= delay;
            end if;
          end if;
          
        when finish =>
          complete <= '1';
          OE <= '1';
          state <= delay;
            
        when others =>
          state <= delay;

      end case;
    end if;
  end process;
end behaviour;
