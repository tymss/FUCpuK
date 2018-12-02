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
                if (upperMode = '1') then
                  ASCIIBuff <= x"0044"; -- D
                else
                  ASCIIBuff <= x"0064"; -- d
                end if;
                state <= delay;	
              when x"24" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0045"; -- E
                else
                  ASCIIBuff <= x"0065"; -- e
                end if;
                state <= delay;	
              when x"2b" => 								
                if (upperMode = '1') then
                  ASCIIBuff <= x"0046"; -- F
                else
                  ASCIIBuff <= x"0066"; -- f
                end if;
                state <= delay;		
              when x"34" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0047"; -- G
                else
                  ASCIIBuff <= x"0067"; -- g
                end if;
                state <= delay;	
              when x"33" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0048"; -- H
                else
                  ASCIIBuff <= x"0068"; -- h
                end if;
                state <= delay;	
              when x"43" =>
                if (upperMode = '1') then
                  ASCIIBuff <= x"0049"; -- I
                else
                  ASCIIBuff <= x"0069"; -- i
                end if;
                state <= delay;	
              when x"3b" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"004a"; -- J
                else
                  ASCIIBuff <= x"006a"; -- j
                end if;
                state <= delay;	
              when x"42" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"004b"; -- K
                else
                  ASCIIBuff <= x"006b"; -- k
                end if;
                state <= delay;		
              when x"4b" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"004c"; -- L
                else
                  ASCIIBuff <= x"006c"; -- l
                end if;
                state <= delay;	
              when x"3a" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"004d"; -- M
                else
                  ASCIIBuff <= x"006d"; -- m
                end if;
                state <= delay;	
              when x"31" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"004e"; -- N
                else
                  ASCIIBuff <= x"006e"; -- n
                end if;
                state <= delay;	
              when x"44" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"004f"; -- O
                else
                  ASCIIBuff <= x"006f"; -- o
                end if;
                state <= delay;	
              when x"4d" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0050"; -- P
                else
                  ASCIIBuff <= x"0070"; -- p
                end if;
                state <= delay;			
              when x"15" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0051"; -- Q
                else
                  ASCIIBuff <= x"0071"; -- q
                end if;
                state <= delay;				
              when x"2d" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0052"; -- R
                else
                  ASCIIBuff <= x"0072"; -- r
                end if;
                state <= delay;		
              when x"1b" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0053"; -- S
                else
                  ASCIIBuff <= x"0073"; -- s
                end if;
                state <= delay;		
              when x"2c" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0054"; -- T
                else
                  ASCIIBuff <= x"0074"; -- t
                end if;
                state <= delay;	
              when x"3c" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0055"; -- U
                else
                  ASCIIBuff <= x"0075"; -- u
                end if;
                state <= delay;						
              when x"2a" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0056"; -- V
                else
                  ASCIIBuff <= x"0076"; -- v
                end if;
                state <= delay;	
              when x"1d" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0057"; -- W
                else
                  ASCIIBuff <= x"0077"; -- w
                end if;
                state <= delay;		
              when x"22" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0058"; -- X
                else
                  ASCIIBuff <= x"0078"; -- x
                end if;
                state <= delay;	
              when x"35" => 
                if (upperMode = '1') then
                  ASCIIBuff <= x"0059"; -- Y
                else
                  ASCIIBuff <= x"0079"; -- y
                end if;
                state <= delay;									
              when x"1a" => 								
                if (upperMode = '1') then
                  ASCIIBuff <= x"005a"; -- Z
                else
                  ASCIIBuff <= x"007a"; -- z
                end if;
                state <= delay;	
              -- 0-9		
              when x"16" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0021"; -- !
                else
                  ASCIIBuff <= x"0031"; -- 1
                end if;
                state <= delay;		
              when x"1e" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0040"; -- @
                else
                  ASCIIBuff <= x"0032"; -- 2
                end if;
                state <= delay;		
              when x"26" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0023"; -- #
                else
                  ASCIIBuff <= x"0033"; -- 3
                end if;
                state <= delay;		
              when x"25" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0024"; -- $
                else
                  ASCIIBuff <= x"0034"; -- 4
                end if;
                state <= delay;		
              when x"2e" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0025"; -- %
                else
                  ASCIIBuff <= x"0035"; -- 5
                end if;
                state <= delay;		
              when x"36" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"005e"; -- ^
                else
                  ASCIIBuff <= x"0036"; -- 6
                end if;
                state <= delay;		
              when x"3d" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0026"; -- &
                else
                  ASCIIBuff <= x"0037"; -- 7
                end if;
                state <= delay;		
              when x"3e" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"002a"; -- *
                else
                  ASCIIBuff <= x"0038"; -- 8
                end if;
                state <= delay;		
              when x"46" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0028"; -- (
                else
                  Asciibuff <= x"0039"; -- 9
                end if;
                state <= delay;
              when x"45" => 
                if (shiftMode = '1') then
                  ASCIIBuff <= x"0029"; -- )
                else
                  ASCIIBuff <= x"0030"; -- 0
                end if;
                state <= delay;
             -- mode
              when x"12" => 
                Lshift <= '1'; -- LShift
                state <= delay;	
              when x"59" => 
                Rshift <= '1'; -- Rshift
                state <= delay;		
              when x"58" => 
                capsMode <= not(capsMode); -- caps lock
                state <= delay;	
              -- control
              when x"75" =>
                ASCIIBuff <= x"0011"; -- Up
                state <= delay;
              when x"72" =>
                ASCIIBuff <= x"0012"; -- Down
                state <= delay;
              when x"6B" =>
                ASCIIBuff <= x"0013"; -- Left
                state <= delay;
              when x"74" =>
                ASCIIBuff <= x"0014"; -- Right
                state <= delay;
              when x"5a" =>
                ASCIIBuff <= x"000a"; -- enter
                state <= delay;
              when x"66" =>
                ASCIIBuff <= x"0008"; -- back space
                state <= delay;
              when x"29" =>
                ASCIIBuff <= x"0020"; -- space
                state <= delay;
              when x"76" =>
                ASCIIBuff <= x"001b"; -- esc
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
