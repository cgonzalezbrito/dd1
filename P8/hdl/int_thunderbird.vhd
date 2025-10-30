-- Autor: cgonzalezbrt
-- Fecha: 29 oct
-- TBC

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity int_thunderbird is
port(
   clk   : in std_logic;
   Rst_n : in std_logic;
   -- Intermitente izquierdo (L) o derecho (R)
   L     : in std_logic;
   R     : in std_logic;
   --- Luces izquierda
   LA: buffer std_logic;
   LB: buffer std_logic;
   LC: buffer std_logic;
   -- Luces derecha
   RA: buffer std_logic;
   RB: buffer std_logic;
   RC: buffer std_logic
);
end entity;

architecture rtl of int_thunderbird is
  signal interLR: std_logic_vector(1 downto 0);
  signal luces: std_logic_vector(5 downto 0);
  
  type t_estado is (inicial, izda_1, izda_2, izda_3, dcha_1, dcha_2, dcha_3, emer);
  signal estado: t_estado := inicial;

  signal timer_tic: std_logic;
  signal timer_count: std_logic_vector(21 downto 0);

begin
  interLR <= L & R; -- para utilizarla en la sentencia case

  process(clk, Rst_n)
  begin
    if Rst_n = '0' then
      timer_count <= (others => '0');
    elsif clk'event and clk = '1' then
      if timer_count = 3600000 then
        timer_count <= (others => '0');
        timer_tic <= '1';
      else
        timer_count <= timer_count + 1;
        timer_tic <= '0';
      end if;
    end if;
  end process;

  process(clk, Rst_n)
  begin
    if Rst_n = '0' then
      estado <= inicial;
    
    elsif clk'event and clk = '1' then
      if timer_tic = '1' then
        case estado is

          when inicial => 
            if interLR = "01" then
              estado <= dcha_1;
            elsif interLR = "10" then
              estado <= izda_1;
            elsif interLR = "11" then
              estado <= emer;
            end if;

          when izda_1 => 
            if interLR = "10" then
              estado <= izda_2;
            else
              estado <= inicial;
            end if;

          when izda_2 => 
            if interLR = "10" then
              estado <= izda_3;
            else
              estado <= inicial;
            end if;

          when izda_3 =>
            estado <= inicial; 

          when dcha_1 => 
            if interLR = "01" then
              estado <= dcha_2;
            else
              estado <= inicial;
            end if;

          when dcha_2 => 
            if interLR = "01" then
              estado <= dcha_3;
            else
              estado <= inicial;
            end if;

          when dcha_3 =>
            estado <= inicial; 

          when emer =>
            estado <= inicial; 

        end case;
      end if;
    end if;
  end process;

  luces <= "000000" when estado = inicial else
           "001000" when estado = izda_1 else
           "010000" when estado = izda_2 else
           "100000" when estado = izda_3 else
           "000100" when estado = dcha_1 else
           "000010" when estado = dcha_2 else
           "000001" when estado = dcha_3 else
           "111111" when estado = emer else
           "000000";
  
  RA <= luces(2);
  RB <= luces(1);
  RC <= luces(0);

  LA <= luces(3);
  LB <= luces(4);
  LC <= luces(5);
end rtl;