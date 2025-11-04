library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_NA_32_seq_conf is
end entity;

architecture test of tb_NA_32_seq_conf is
  signal clk:     std_logic;
  signal an_rst:  std_logic;
  signal start:   std_logic;
  signal umbral:  std_logic_vector(5 downto 0);
  signal ent:     std_logic_vector(31 downto 0);
  signal fin:     std_logic;
  signal sal:     std_logic;
  
  constant T_CLK: time := 100 ns;

begin

--Emplazamiento del modelo
dut: entity Work.NA_32_conf (rtl)
     port map(clk => clk,
              an_rst => an_rst,
              start => start,
              umbral => umbral,
              ent => ent,
              fin => fin,
              sal => sal
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

   wait until clk'event and clk = '1';   
   wait until clk'event and clk = '1'; 

   wait for 5*T_CLK;
   assert false
   report "fin sim"
   severity failure;
end process;

end test;

