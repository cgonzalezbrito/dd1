library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_int_thunderbird is
end entity;

architecture test of tb_int_thunderbird is
  signal clk:   std_logic;
  signal Rst_n:  std_logic;
  signal L:  std_logic;
  signal R:  std_logic;

  signal LA: std_logic;
  signal LB: std_logic;
  signal LC: std_logic;
  signal RA: std_logic;
  signal RB: std_logic;
  signal RC: std_logic;

  constant T_CLK: time := 100 ns;

begin

--Emplazamiento del modelo
dut: entity Work.int_thunderbird(rtl)
     port map(clk => clk,
              Rst_n => Rst_n,
              L => L,
              R => R,

              LA => LA,
              LB => LB,
              LC => LC,
              RA => RA,
              RB => RB,
              RC => RC
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
   Rst_n <= '1';   
     
   wait until clk'event and clk = '1'; 
   Rst_n <= '0';    
   wait until clk'event and clk = '1'; 
   Rst_n <= '1';
  
   -- a izda_1
   L <= '1';
   R <= '0';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 
   
   -- a izda_2
   L <= '1';
   R <= '0';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   -- a izda_3
   L <= '1';
   R <= '0';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 
   
   -- a inicio
   L <= '1';
   R <= '0';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 
   
   -- a dcha_1
   L <= '0';
   R <= '1';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   -- a dcha_2
   L <= '0';
   R <= '1';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   -- a dcha_3
   L <= '0';
   R <= '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   -- a inicio
   L <= '0';
   R <= '1';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   -- emer

   L <= '1';
   R <= '1';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   L <= '1';
   R <= '1';
   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   wait until clk'event and clk = '1'; 
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1'; 

   wait for 5*T_CLK;
   assert false
   report "fin sim"
   severity failure;
end process;

end test;