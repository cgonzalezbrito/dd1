-- Autor: DTE
-- Fecha: 9-9-2016
-- Sumador de 4 bits
-- Version 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- para poder usar +

entity sum4bits is             
port(
	A: in     std_logic_vector(3 downto 0);
	B: in     std_logic_vector(3 downto 0);
	S: buffer std_logic_vector(3 downto 0)
    );
end entity; 

architecture rtl of sum4bits is
begin
--  process(A, B)
--  begin
    S <= A + B;
  
--  end process;
end rtl;