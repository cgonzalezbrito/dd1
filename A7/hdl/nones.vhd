-- Calcula el numero de unos en un dato de entrada de cuatro bits
library ieee;
use ieee.std_logic_1164.all;

entity calc_n_ones is
port(
  a: in std_logic_vector(3 downto 0);
  y: buffer std_logic_vector(2 downto 0));
end entity;

architecture rtl of calc_n_ones is
begin
   y <= "000" when a = "0000" else
             "001" when a = "0001" or a = "0010" or a = "0100" or a = "1000" else
             "010" when a = "0011" or a = "0101" or a = "0110" or a = "1001" or a = "1010" or a = "1100" else
             "011" when a = "0111" or a = "1011" or a = "1101" or a = "1110" else
             "100" when a = "1111" else
             "000";  -- por seguridad
end architecture;
