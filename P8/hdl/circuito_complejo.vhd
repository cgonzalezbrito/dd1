library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity p8_cc is
port(
   clk    : in std_logic;
   an_rst : in std_logic;

   P_1   : in std_logic;
   P_2   : in std_logic;

   LEDS  : buffer std_logic_vector(7 downto 0);
   seg   : buffer std_logic_vector(6 downto 0)
);
end entity;

architecture rtl of p8_cc is

  signal modo:  std_logic;
  signal shift: std_logic;
  
  signal tic: std_logic;
  signal ena_shift: std_logic;
  signal nL_R: std_logic;

  signal D_in: std_logic;

  signal S: std_logic_vector(2 downto 0);

  signal q_p_1     : std_logic;                  -- p1 registrado
  signal q_p_2     : std_logic;                  -- p2 registrado

  signal timer_count: std_logic_vector(23 downto 0);
  signal timer_tic: std_logic;

  type t_estado is (Pi, Pd, Md, Mi);
  signal estado: t_estado := Pi;

begin

  conf_p1_modo: process(an_rst, clk)
  begin
    if an_rst = '0' then
      q_p_1 <= '1';
    elsif clk'event and clk = '1' then
      q_p_1 <= P_1;
    end if;
  end process;
  modo <= '0' when an_rst='0' else (q_p_1 and (not P_1));

  conf_p2_shift: process(an_rst, clk)
  begin
    if an_rst = '0' then
      q_p_2 <= '1';
    elsif clk'event and clk = '1' then
      q_p_2 <= P_2;
    end if;
  end process;

  shift <= '0' when an_rst='0' else (q_p_2 and (not P_2));

  timer: process(clk, an_rst)
  begin
    if an_rst = '0' then
      timer_count <= (others => '0');
    elsif clk'event and clk = '1' then
      if timer_count = 12000000 then
        timer_count <= (others => '0');
        timer_tic <= '1';
      else
        timer_count <= timer_count + 1;
        timer_tic <= '0';
      end if;
    end if;
  end process;

  proc_deco: process(S)
  begin
    case S is
	  when "000" => seg <= "0000001";
	  when "001" => seg <= "1001111";
	  when "010" => seg <= "0010010";
	  when "011" => seg <= "0000110";
	  when "100" => seg <= "1001100";
	  when "101" => seg <= "0100100";
	  when "110" => seg <= "0100000";
	  when "111" => seg <= "0001111";
	  when others => seg <= "XXXXXXX";
	end case;
  end process;

  proc_code: process(LEDS)
  begin
    case LEDS is
	  when "00000001" => S <= "000";
	  when "00000010" => S <= "001";
	  when "00000100" => S <= "010";
	  when "00001000" => S <= "011";
	  when "00010000" => S <= "100";
	  when "00100000" => S <= "101";
	  when "01000000" => S <= "110";
	  when "10000000" => S <= "111";
	  when others => S <= "XXX";
	end case;
  end process;

  -- Procesamiento del registro de desplazamiento
  reg_desp: process(clk, an_rst)
  begin
    if an_rst = '0' then  -- Reset asincr\C3\B3nico activo a nivel bajo
      LEDS <= "00000001";
    elsif clk'event and clk = '1' then
        if ena_shift = '1' then  -- Desplazamiento habilitado
          if nL_R = '1' then  -- Desplazamiento a la derecha
            LEDS <= LEDS(0) & LEDS(7 downto 1);
          else  -- Desplazamiento a la izquierda
            LEDS <= LEDS(6 downto 0) & LEDS(7);
          end if;
        end if;
    end if;
  end process;

  aut_estado: process(an_rst, clk)
  begin
    if an_rst = '0' then
      estado <= Pi;
    elsif clk'event and clk = '1' then
      case estado is
        when Pi =>          
          if modo = '1' then
            estado <= Md;
          elsif shift = '1' then
             estado <= Pd;
          end if;
        when Pd =>
          if modo = '1' then
            estado <= Md;
          elsif shift = '1' then
             estado <= Pi;
          end if;
        when Md =>
          if modo = '1' then
            estado <= Mi;
          end  if;
        when Mi =>
          if modo = '1' then
            estado <= Pi;
          end if;
      end case;   
    end if;
  end process;

  nL_R <= '0' when estado = Pi or estado = Mi else '1';
  ena_shift <= timer_tic when estado = Pi or estado = Pd else shift;

end rtl;
