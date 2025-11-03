library ieee;
use ieee.std_logic_1164.all;
use ieee. std_logic_signed.all;

entity tb_abs_gt5_4b is
end entity;

architecture test of tb_abs_gt5_4b is
  signal a: std_logic_vector(3 downto 0);
  signal y:   std_logic;

  constant T_length: time := 100 ns;    -- Duracion de cada comb. de entrada

begin
  dut: entity work.abs_gt5_4b(rtl)
       port map(a => a,
                y => y);


  process
  begin
    a <= "1000";

    for i in 1 to 15 loop
      wait for T_length;
      a <= a + 1;

    end loop;

    wait for T_length;
    wait;

  end process;
end test;
