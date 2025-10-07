-- Autor: DTE
-- Fecha: 9-9-2016
-- Sumador de 8 bits con acarreo de entrada y salida y salida OV
-- Versi\C3\B3n 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity sum8bits is             
port(
	C_in:  in     std_logic;
	A:     in     std_logic_vector(7 downto 0);
	B:     in     std_logic_vector(7 downto 0);
	S:     buffer std_logic_vector(7 downto 0);
	C_out: buffer std_logic;
	OV:    buffer std_logic
    );
end entity; 

architecture rtl of sum8bits is
    signal S_aux: std_logic_vector(8 downto 0);
begin
    S_aux <= ('0' & A) + ('0' & B) + C_in;
    C_out <= S_aux(8);
    S <= S_aux(7 downto 0);

	-- Esta linea es confusa. Cuando A = b'01111111' y B = b'000000001', entonces S = b'10000000'. Por lo que A(7) = B(7) y A(7) != S(7) 
	-- Sin embargo no es un overflow
    OV <= '1' when (A(7) = B(7)) and (A(7) /= S(7))
	else '0';
    
end rtl;