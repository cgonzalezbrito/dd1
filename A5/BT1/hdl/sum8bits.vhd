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
	-- VHDL primero resuelve y luego asigna. Es por eso que es necesario concatenar un bit a A y B, caso contrario resolveria en 8 bits, perderia el 9no y asignaria
    S_aux <= ('0' & A) + ('0' & B) + C_in;
    C_out <= S_aux(8);
    S <= S_aux(7 downto 0);

	-- Recordar que un overflow es util en complemento a 2
    OV <= '1' when (A(7) = B(7)) and (A(7) /= S(7))
	else '0';
    
end rtl;