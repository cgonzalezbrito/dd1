library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_NA_4_conf is
end entity;

architecture test of tb_NA_4_conf is

  signal umbral_tb : std_logic_vector(1 downto 0) := (others => '0');
  signal ent_tb    : std_logic_vector(3 downto 0) := (others => '0');
  signal sal_tb    : std_logic;

  constant T_CLK: time := 100 ns;

begin
  -- Instancia del DUT
  dut: entity work.NA_4_conf
    port map (
      umbral => umbral_tb,
      ent    => ent_tb,
      sal    => sal_tb
    );

  -- Estímulos
  stim_proc: process
  begin
    -- Barrido de umbral (00..11)
    for u in 0 to 3 loop
      umbral_tb <= std_logic_vector(to_unsigned(u, 2));
      wait for T_CLK;

      -- Para cada umbral, barrer todas las entradas ent (0000..1111)
      for e in 0 to 15 loop
        ent_tb <= std_logic_vector(to_unsigned(e, 4));
        wait for T_CLK;
      end loop;

      wait for T_CLK;
    end loop;

    -- Fin de la simulación
    wait;
  end process;
end architecture;

