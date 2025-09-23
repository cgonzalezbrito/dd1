-- Test-bench de un decodificador
-- BCD a 7 segmentos realizado para
-- el tutorial de la actividad AINP4
-- (23-09-2025)

-- Clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;

-- Declaracion de entidad sin puertos
entity   tb_decodBCD7seg is
end entity;

architecture test of tb_decodBCD7seg is
  signal digBCD: std_logic_vector(3 downto 0); -- Estimulo
  signal segDisp: std_logic_vector(6 downto 0); -- Respuesta
  
begin
  dut: entity Work.decodBCD7seg(rtl)
       port map(digBCD => digBCD,    
                segDisp => segDisp
                );
                                
  process
  begin                                        -- (3) Est\ufffdmulos
    digBCD <= "0000";  -- En T = 0 ns
    wait for 100 ns;  
    digBCD <= "0001";  -- En T = 100 ns
    wait for 100 ns;
    digBCD <= "0010";  -- En T = 200 ns
    wait for 100 ns;  
    digBCD <= "0011";  -- En T = 300 ns
    wait for 100 ns;
    digBCD <= "0100";  -- En T = 400 ns
    wait for 100 ns;  
    digBCD <= "0101";  -- En T = 500 ns
    wait for 100 ns;
    digBCD <= "0110";  -- En T = 600 ns
    wait for 100 ns;  
    digBCD <= "0111";  -- En T = 700 ns
    wait for 100 ns;
    digBCD <= "1000";  -- En T = 800 ns
    wait for 100 ns;  
    digBCD <= "1001";  -- En T = 900 ns
    wait for 100 ns;  
    digBCD <= "1010";  -- En T = 1000 ns
    wait for 100 ns;  
    digBCD <= "1011";  -- En T = 1100 ns
    wait for 100 ns;  
    digBCD <= "1100";  -- En T = 1200 ns
    wait for 100 ns;  
    digBCD <= "1101";  -- En T = 1300 ns
    wait for 100 ns;  
    digBCD <= "1110";  -- En T = 1400 ns
    wait for 100 ns;  
    digBCD <= "1111";  -- En T = 1500 ns
    wait;            
  end process;               
end test;
