-- Autor: cgonzalezbrito
-- Fecha: 02-10-2025
-- Modelo de un divisor de frecuencia realizado para la actividad AIP11 
-- del  bloque I de DD1

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity div_freq_4 is
port(
	clk: 		in std_logic;
	nRST: 		in std_logic;
	freq_div_4:	buffer std_logic
);
end entity;

architecture rtl of div_freq_4 is
	signal Q_i: std_logic_vector(1 downto 0);
begin
   -- Proceso que modela el funcionamiento de un contador
   process(clk, nRST)
   	begin
      	if nRST = '0' then
		Q_i <= "00";
      	elsif clk'event and clk = '1' then
		Q_i <= Q_i + 1;
      	end if;
   end process;

   -- Proceso que detecta el estado de cuenta 3
   process(Q_i)
  	begin
	if Q_i = 3 then
		freq_div_4 <= '1';
	else
		freq_div_4 <= '0';
	end if;
   end process;
end rtl;
