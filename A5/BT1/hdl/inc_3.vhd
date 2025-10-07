-- Autor: DTE
-- Fecha: 9-9-2016
-- Modelo de sumador de 5 bits con una constante de valor 3
-- Versi\C3\B3n 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity inc_3 is             
port(
     A: in     std_logic_vector(4 downto 0);
	   S: buffer std_logic_vector(4 downto 0)
    );
end entity; 

architecture rtl of inc_3 is
begin
    S <= A + 3;
  
end rtl;