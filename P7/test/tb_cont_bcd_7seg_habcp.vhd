library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  -- para DUT si hiciera falta en el TB

entity tb_cont_bcd_7seg_habcp is
end entity;

architecture sim of tb_cont_bcd_7seg_habcp is
  -- DUT
  component cont_bcd_7seg_habcp is
    port (
      an_rst    : in  std_logic;
      clk       : in  std_logic;
      pulso_hab : in  std_logic;
      disp7seg  : buffer std_logic_vector(6 downto 0)
    );
  end component;

  signal an_rst    : std_logic := '0';
  signal clk       : std_logic := '0';
  signal pulso_hab : std_logic := '0';
  signal disp7seg  : std_logic_vector(6 downto 0);

  constant Tclk : time := 100 ns;

  -- Tabla esperada (ánodo común, activo en bajo): (a..g) = (6..0)
  type seg_array_t is array (0 to 9) of std_logic_vector(6 downto 0);
  constant SEG : seg_array_t := (
    "0000001", -- 0
    "1001111", -- 1
    "0010010", -- 2
    "0000110", -- 3
    "1001100", -- 4
    "0100100", -- 5
    "0100000", -- 6
    "0001111", -- 7
    "0000000", -- 8
    "0000100"  -- 9
  );

begin
  -- Instancia del DUT
  DUT: cont_bcd_7seg_habcp
    port map (
      an_rst    => an_rst,
      clk       => clk,
      pulso_hab => pulso_hab,
      disp7seg  => disp7seg
    );

  -- Reloj 10 ns
  clk_proc: process
  begin
    clk <= '0';
    wait for Tclk/2;
    clk <= '1';
    wait for Tclk/2;
  end process;

  -- Estímulos
  stim: process
    variable expected : std_logic_vector(6 downto 0);
  begin
    -- Reset asíncrono bajo durante unos ciclos
    an_rst <= '0';
    pulso_hab <= '0';
    wait for 3*Tclk;
    an_rst <= '1';

    -- Espera a un flanco para estabilizar y comprueba que muestra "0"
    wait until rising_edge(clk);
    wait for 1 ns;  -- delta para evaluar combinacional
    expected := SEG(0);
    assert disp7seg = expected
      report "Tras reset, debería mostrar 0" severity error;

    -- Emite 12 pulsos: cada pulso = 1 ciclo en '1' seguido de 1 ciclo en '0'
    -- (el incremento ocurre en la BAJADA)
    for i in 1 to 12 loop
      -- sube pulso_hab un ciclo
      pulso_hab <= '1';
      wait until rising_edge(clk);  -- q captura '1'

      -- baja pulso_hab; en la siguiente subida se incrementa el contador
      pulso_hab <= '0';
      wait until rising_edge(clk);  -- aquí se hace el +1 por c_in

      -- pequeño margen y comprobación del patrón esperado
      wait for 1 ns;
      expected := SEG(i mod 10);
      assert disp7seg = expected
        report "Mismatch en pulso " & integer'image(i)
        severity error;
    end loop;

   wait for 5*Tclk;
   assert false
   report "fin sim"
   severity failure;
   -- wait;
  end process;

end architecture;

