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
  signal shiftMode, capsMode, upperMode: std_logic;
  signal Lshift, Rshift: std_logic;
  signal state: state_type;
begin
  ASCII <= ASCIIBuff;
  shiftMode <= Lshift or Rshift;
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
          if PS2_OE = '1' then
            case PS2_DATA is
              -- arrow
              when x"e0" =>
                state <= arrow;
              -- break
              when x"f0" =>
                state <= break;
              -- normal
              when others =>
                CODEbuff <= PS2_DATA;
                state <= normal;
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
                end if;
                state <= delay;

              when x"23" => 								
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0044"; -- D
                else
                  ASCIIBuffer <= x"0064"; -- d
                end if;
                state <= delay;	
              when x"24" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0045"; -- E
                else
                  ASCIIBuffer <= x"0065"; -- e
                end if;
                state <= delay;	
              when x"2b" => 								
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0046"; -- F
                else
                  ASCIIBuffer <= x"0066"; -- f
                end if;
                state <= delay;		
              when x"34" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0047"; -- G
                else
                  ASCIIBuffer <= x"0067"; -- g
                end if;
                state <= delay;	
              when x"33" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0048"; -- H
                else
                  ASCIIBuffer <= x"0068"; -- h
                end if;
                state <= delay;	
              when x"43" =>
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0049"; -- I
                else
                  ASCIIBuffer <= x"0069"; -- i
                end if;
                state <= delay;	
              when x"3b" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"004a"; -- J
                else
                  ASCIIBuffer <= x"006a"; -- j
                end if;
                state <= delay;	
              when x"42" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"004b"; -- K
                else
                  ASCIIBuffer <= x"006b"; -- k
                end if;
                state <= delay;		
              when x"4b" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"004c"; -- L
                else
                  ASCIIBuffer <= x"006c"; -- l
                end if;
                state <= delay;	
              when x"3a" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"004d"; -- M
                else
                  ASCIIBuffer <= x"006d"; -- m
                end if;
                state <= delay;	
              when x"31" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"004e"; -- N
                else
                  ASCIIBuffer <= x"006e"; -- n
                end if;
                state <= delay;	
              when x"44" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"004f"; -- O
                else
                  ASCIIBuffer <= x"006f"; -- o
                end if;
                state <= delay;	
              when x"4d" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0050"; -- P
                else
                  ASCIIBuffer <= x"0070"; -- p
                end if;
                state <= delay;			
              when x"15" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0051"; -- Q
                else
                  ASCIIBuffer <= x"0071"; -- q
                end if;
                state <= delay;				
              when x"2d" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0052"; -- R
                else
                  ASCIIBuffer <= x"0072"; -- r
                end if;
                state <= delay;		
              when x"1b" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0053"; -- S
                else
                  ASCIIBuffer <= x"0073"; -- s
                end if;
                state <= delay;		
              when x"2c" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0054"; -- T
                else
                  ASCIIBuffer <= x"0074"; -- t
                end if;
                state <= delay;	
              when x"3c" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0055"; -- U
                else
                  ASCIIBuffer <= x"0075"; -- u
                end if;
                state <= delay;						
              when x"2a" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0056"; -- V
                else
                  ASCIIBuffer <= x"0076"; -- v
                end if;
                state <= delay;	
              when x"1d" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0057"; -- W
                else
                  ASCIIBuffer <= x"0077"; -- w
                end if;
                state <= delay;		
              when x"22" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0058"; -- X
                else
                  ASCIIBuffer <= x"0078"; -- x
                end if;
                state <= delay;	
              when x"35" => 
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"0059"; -- Y
                else
                  ASCIIBuffer <= x"0079"; -- y
                end if;
                state <= delay;									
              when x"1a" => 								
                if (upperModifier = '1') then
                  ASCIIBuffer <= x"005a"; -- Z
                else
                  ASCIIBuffer <= x"007a"; -- z
                end if;
                state <= delay;	
              -- 0-9		
              when x"16" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0021"; -- !
                else
                  ASCIIBuffer <= x"0031"; -- 1
                end if;
                state <= delay;		
              when x"1e" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0040"; -- @
                else
                  ASCIIBuffer <= x"0032"; -- 2
                end if;
                state <= delay;		
              when x"26" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0023"; -- #
                else
                  ASCIIBuffer <= x"0033"; -- 3
                end if;
                state <= delay;		
              when x"25" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0024"; -- $
                else
                  ASCIIBuffer <= x"0034"; -- 4
                end if;
                state <= delay;		
              when x"2e" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0025"; -- %
                else
                  ASCIIBuffer <= x"0035"; -- 5
                end if;
                state <= delay;		
              when x"36" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"005e"; -- ^
                else
                  ASCIIBuffer <= x"0036"; -- 6
                end if;
                state <= delay;		
              when x"3d" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0026"; -- &
                else
                  ASCIIBuffer <= x"0037"; -- 7
                end if;
                state <= delay;		
              when x"3e" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"002a"; -- *
                else
                  ASCIIBuffer <= x"0038"; -- 8
                end if;
                state <= delay;		
              when x"46" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0028"; -- (
                else
                  ASCIIBuffer <= x"0039"; -- 9
                end if;
                state <= delay;
              when x"45" => 
                if (shiftModifier = '1') then
                  ASCIIBuffer <= x"0029"; -- )
                else
                  ASCIIBuffer <= x"0030"; -- 0
                end if;
                state <= delay;
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
          if PS2_OE = '1' then
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
