-- Autor: DTE
-- Fecha: 9-9-2016
-- Modelo de restador de 6 bits con acarreo de entrada y salida y salida OV
-- Versi\C3\B3n 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity rest4bits is             
port(
	A:     in     std_logic_vector(3 downto 0);
	B:     in     std_logic_vector(3 downto 0);
	S:     buffer std_logic_vector(3 downto 0)
    );
end entity; 

architecture rtl of rest4bits is
begin
	S <= A + (not B) + 1;    
end rtl;