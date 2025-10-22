library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity serial_mult_tb is
end entity;

architecture test of serial_mult_tb is
  signal clk:   std_logic;
  signal an_rst:  std_logic;
  signal X:  std_logic;
  signal Y:  std_logic;

  constant T_CLK: time := 100 ns;

begin

--Emplazamiento del modelo
dut: entity Work.serial_mult(rtl)
     port map(clk => clk,
              an_rst => an_rst,
              x => x,
              y => y
             );

process
begin
  clk <= '0';
  wait for T_CLK/2;
  clk <= '1';
  wait for T_CLK/2;
end process;

process
begin
-- Inicializacion asincrona
   an_rst <= '1';   
     
   wait until clk'event and clk = '1'; 
   an_rst <= '0';    
   wait until clk'event and clk = '1'; 
   an_rst <= '1';
  
   x <= '1';
   wait until clk'event and clk = '1'; 
   x <= '1';
   wait until clk'event and clk = '1'; 
   x <= '1';
   wait until clk'event and clk = '1'; 
   x <= '1';
   wait until clk'event and clk = '1'; 
   x <= '0';
   wait until clk'event and clk = '1'; 
   x <= '1';
   wait until clk'event and clk = '1'; 
   x <= '0';
   wait until clk'event and clk = '1'; 
   x <= '0';

   wait for 5*T_CLK;
   assert false
   report "fin sim"
   severity failure;
end process;

end test;
