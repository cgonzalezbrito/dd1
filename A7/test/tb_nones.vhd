library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_calc_n_ones is
end entity;

architecture test of tb_calc_n_ones is
  signal a:    std_logic_vector(3 downto 0);
  signal y:     std_logic_vector(2 downto 0);

  constant T_CLK: time := 100 ns;

begin
  dut: entity work.calc_n_ones(rtl)
       port map(a => a,
                y => y);


  process
  begin
    a <= "0000";
    wait for T_CLK;
    for i in 0 to 15 loop
      a <= a + 1;
      wait for T_CLK;
    end loop;
    wait;                           -- fin de simulación   
  end process;
end test;
