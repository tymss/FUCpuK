library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity ps2ascii is
  port(
    CLK, RST: in std_logic;
    PS2_DATA: in std_logic_vector(7 downto 0);
    PS2_OE: in std_logic;
    ASCII: out std_logic_vector(15 downto 0);
    ASCII_OE: out std_logic
);
end ps2ascii;

architecture behaviour of ps2ascii is
  type state_type is (delay, normal, arrow, break);
  signal CODEbuff, PREVbuff: std_logic_vector(7 downto 0);
  signal ASCIIbuff: std_logic_vector(15 downto 0);
  signal shitfMode, capsMode, upperMode: std_logic;
  signal Lshift, Rshift: std_logic;

begin
  ASCII <= ASCIIBuff;
  shitMode <= Lshift or Rshift;
  upperMode <= shiftMode xor capsMode;
  
  encode: process(RST, CLK, PS2_OE, PS2_DATA, CODEbuff)
  begin
    if (RST = '0') then
      CODEBuff <= x"00";
      PREVbuff <= x"00";
      Lshift  <= '0';
      Rshift <= '0';
      capsMode <= '0';
      ASCIIBuff <= x"0000";
      state <= delay;
    elsif rising_edge(CLK) then
      case state is
        when delay =>
          ASCII_OE <= '0';
          if ASCII_OE = '1' then
            case PS_DATA is
              -- arrow
              when x"e0" =>
                state <= arrow;
              -- break
              when x"f0" =>
                state <= break;
              -- normal
              when others =>
                CODEbuff <= PS2_DATA;
                state <= noraml;
            end case;
          end if;

        when arrow =>
          -- todo: input is arrow

        when normal =>
          if (CODEbuff /= PREVbuff) then
            PREVbuff <= CODEbuff;
            case CODEbuff is
              -- a-z
              when x"1c" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0041"; -- A
                else
                  ASCIIBuff <= x"0061"; -- a
                end if;
                state <= delay;

              when x"32" =>
                if (upperMode = '1') then
                  ASCIIBuff <= x"0042"; -- B
                else
                  ASCIIBuff <= x"0062"; -- b
                end if;
                state <= delay;

              when x"21" =>
                if (upperMode = '1') then
                  ASCIIBuff <= x"0043"; -- C
                else
                  ASCIIBuff <= x"0063"; -- c
                  state <= delay;
                end if;
                
              when others =>
                ASCIIBuff <= x"0000";
                state <= delay;

            end case;
            ASCII_OE <= '1';

          else
            ASCIIbuff <= x"0000";
            ASCII_OE <= '0';
            state <= delay;
          end if;
          
        when break =>
          if ASCII_OE = '1' then
            if (PS2_DATA = PREVbuff) then
              PREVbuff <= (others => '0');
            end if;
            ASCIIBuff <= x"0000";
            ASCII_OE <= '1';
            state <= delay;
          end if;

        when others =>
          state <= delay;

      end case;
    end if;
  end process;
  
end behaviour;
