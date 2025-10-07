-- Autor: DTE
-- Fecha: 9-9-2016
-- Test-Bench de un sumador de 8 bits con entrada y salida 
-- de acarreo y salida de overflow 
-- Versi\C3\B3n 1.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sum8bits_tb is
end entity;

architecture test of sum8bits_tb is
  --Declaraci\C3\B3n de se\C3\B1ales
  signal C_in:  std_logic;
  signal A:     std_logic_vector(7 downto 0);
  signal B:     std_logic_vector(7 downto 0);
  signal S:     std_logic_vector(7 downto 0);
  signal C_out: std_logic;
  signal OV:    std_logic;
begin

--Emplazamiento del modelo
dut: entity Work.sum8bits(rtl)
     port map(
              C_in => C_in,
              A => A,
              B => B,
              S => S,
              C_out => C_out,
              OV => OV
             );

-- Definici\C3\B3n de est\C3\ADmulos
process
begin
  C_in <= '0';
  A <= (others => '0');
  B <= (others => '0');
  
  loop
    for i in 0 to 255 loop
      for j in 0 to 255 loop
        wait for 100 ns;
        B <= B + 1;
    
      end loop;
      A <= A + 1;
  
    end loop;
    if C_in = '1' then
      exit;     
    end if;
    C_in <= not C_in;
  end loop;
  wait;
end process;
end test;