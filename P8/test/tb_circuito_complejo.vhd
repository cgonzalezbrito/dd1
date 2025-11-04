library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_circuito_complejo is
end entity;

architecture test of tb_circuito_complejo is
  signal clk:   std_logic;
  signal an_rst:  std_logic;
  signal P_1:  std_logic;
  signal P_2:  std_logic;

  signal LEDS: std_logic_vector(7 downto 0);
  signal seg: std_logic_vector(6 downto 0);
  
  constant T_CLK: time := 100 ns;

begin

--Emplazamiento del modelo
dut: entity Work.p8_cc (rtl)
     port map(clk => clk,
              an_rst => an_rst,
              P_1 => P_1,
              P_2 => P_2,

              LEDS => LEDS,
              seg => seg
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

   P_1 <= '1';
   P_2 <= '1';

   wait until clk'event and clk = '1'; 

   wait for 64*T_CLK;

   wait until clk'event and clk = '1'; 
   
   P_2 <= '0';
   wait for 550 ns;
   P_2 <= '1';

   wait until clk'event and clk = '1'; 

   wait for 64*T_CLK;

   wait until clk'event and clk = '1'; 

   P_1 <= '0';
   wait for 550 ns;
   P_1 <= '1';

   for i in 1 to 8 loop

     wait for 8*T_CLK;

     P_2 <= '0';
     wait for 550 ns;
     P_2 <= '1';
   end loop;

   P_1 <= '0';
   wait for 550 ns;
   P_1 <= '1';

   for i in 1 to 8 loop

     wait for 8*T_CLK;

     P_2 <= '0';
     wait for 550 ns;
     P_2 <= '1';
   end loop;


   wait for 5*T_CLK;
   assert false
   report "fin sim"
   severity failure;
end process;

end test;