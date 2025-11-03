-- Calcula si el numero absoluto en complemento a 2 es mayor que 5
library ieee;
use ieee.std_logic_1164.all;

entity abs_gt5_4b is
port(
  a: in std_logic_vector(3 downto 0);
  y: buffer std_logic
);
end entity;

architecture rtl of abs_gt5_4b is
begin
  -- Positivos > 5: 0110 o 0111
  -- Negativos con |x| > 5: 1000,1001,1010 
  y <= ((not a(3)) and a(2) and a(1))
        or
        (a(3) and (not a(2)) and (not (a(1) and a(0))));
end architecture;