library ieee;
use ieee.std_logic_1164.all;

entity serial_mult is
  port(
  an_rst, clk : in std_logic;
  x : in std_logic;
  y : buffer std_logic
);
end entity serial_mult;

architecture rtl of serial_mult is
  type t_estado is (cero, uno, dos);
  signal estado : t_estado;
begin

  proc_estado : process(an_rst, clk)
  begin
  if an_rst = '0' then
    estado <= cero;
  elsif clk'event and clk = '1' then
    case estado is
      when cero =>
        if x = '1' then
          estado <= uno;
        end if;
      when uno =>
        if x = '0' then
          estado <= cero;
        else 
          estado <= dos;
        end if;
      when dos =>
        if x = '0' then
          estado <= uno;
        end if;        
    end case;
  end if;
end process proc_estado;

  proc_out : process(estado, x)
  begin
    case estado is
      when cero =>
        if x = '1' then
          y <= '1';
        else
          y <= '0';
        end if;
      when uno =>
        if x = '1' then
          y <= '0';
        else
          y <= '1';
        end if;
      when dos =>
        if x = '1' then
          y <= '1';
        else
          y <= '0';
        end if;
      end case;
    end process proc_out;
end architecture rtl;
