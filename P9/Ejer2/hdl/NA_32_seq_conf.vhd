-- Modelo VHDL sintetizable de una neurona artificial configurable con 32 entradas
-- La salida se activa cuando:
--   umbral vale 00001 y el numero de unos en la entrada es mayor que 1
--   umbral vale 00010 y el numero de unos en la entrada es mayor que 2
--   umbral vale 00011 y el numero de unos en la entrada es mayor que 3
--   etc


-- Cuando umbral vale 00000 la salida est\C3\A1 inactiva

-- Version: 1.0
-- Fecha:   17-09-2021
-- Autor:   The mothers of Invention
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity NA_32_conf is
port(
     clk:    in     std_logic;
     an_rst: in     std_logic;
     start:  in     std_logic;
     umbral: in     std_logic_vector(5 downto 0);
     ent:    in     std_logic_vector(31 downto 0);
     fin:    buffer std_logic;
     sal:    buffer std_logic);

end entity;

architecture rtl of NA_32_conf is
  signal no_unos: std_logic_vector(5 downto 0);
  signal ent_reg: std_logic_vector(31 downto 0);

begin

  reg_desp: process(clk, an_rst)
  begin
    if an_rst = '0' then
      ent_reg <= (others => '0');
    elsif clk'event and clk = '1' then
      if start = '1' then
        ent_reg <= ent;
      elsif fin = '0' then
         ent_reg <= ent_reg(30 downto 0) & '0';
      end if;
    end if;
  end process;

  fin <= '1' when ent_reg = 0 or umbral = 0 or no_unos > umbral else '0';

  cont_unos: process(clk, an_rst)
  begin
    if an_rst = '0' then 
      no_unos <= (others => '0');
    elsif start = '1' then
      no_unos <= (others => '0');
    elsif fin = '0' and ent_reg(31) = '1' then
      no_unos <= no_unos + 1;
    end if;
  end process;

  sal <= '1' when umbral /= 0 and no_unos > umbral else '0';

end rtl; 


