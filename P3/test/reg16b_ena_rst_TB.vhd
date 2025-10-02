
-- Autor: TBC
-- Fecha: TBC
-- Testbench del registro de 16 bits con entrada de habilitacuon
-- y reset sincrono (independiente de habilitacion)
--
-------------------------------------------------------------------------
-- Descripcion de las pruebas
---- Reset as\C3\ADncrono inicial
---- Con la habilitacion activa:
------ Carga de datos paralelo 
------ Reset sincrono
---- Con la habilitacion desactivada:
------ Carga de datos paralelo (no se produce)
------ Reset sincrono (debe producirse)
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity reg16b_ena_rst_TB is
end entity;

architecture Test of reg16b_ena_rst_TB is

  signal clk : std_logic;
  signal nRST: std_logic;
  signal sRST: std_logic;
  signal ena : std_logic;
  signal Din : std_logic_vector(15 downto 0);
  signal Dout: std_logic_vector(15 downto 0);

  constant T_CLK: time:= 100 ns;

begin

   dut: entity work.reg16b_ena_rst(rtl)
        port map( clk => clk,
                  nRST => nRST,
                  sRST => sRST,
                  ena => ena,
                  Din => Din,
                  Dout => Dout);

   reloj: process
      begin
        clk <= '0';
	wait for T_CLK/2;
        clk <= '1';
	wait for T_CLK/2;
      end process;

   estimulos: process
      begin
         -- reset asincrono inicial
         nRST <= '0';
         sRst <= '0';
         ena <= '0';
         Din <= X"0000";
         wait until clk'event and clk='1';
         wait until clk'event and clk='1';
         -- carga de datos
         nRST <= '1'; -- desactivacion de reset asincrono
	 ena <= '1'; -- carga de datos
	 Din <= X"AAAA";

         wait until clk'event and clk='1';
         -- reset sincrono con habilitacion
         sRst <= '1';
         
         wait until clk'event and clk='1';
         -- carga de dato
         sRst <= '0';
	 Din <= X"5555";
        
	 wait until clk'event and clk='1';
         -- desactivacion de la habilitacion
         ena <= '0';
         Din <= X"1234"; -- este dato no debe cargarse
         wait until clk'event and clk='1';
         -- reset sincrono sin habilitacion
         sRst <= '1';
         wait until clk'event and clk='1';
         wait;
      end process;
      
end test;