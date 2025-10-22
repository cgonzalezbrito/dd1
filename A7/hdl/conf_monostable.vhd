library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cont_bcd_7seg_habcp is
  port (
    an_rst      : in std_logic;
    clk         : in std_logic;
    pulso_hab   : in std_logic;
    disp7seg    : buffer std_logic_vector(6 downto 0));

end entity;

architecture rtl of cont_bcd_7seg_habcp is
  signal count : std_logic_vector(3 downto 0);
  signal c_in  : std_logic;
  signal c_out : std_logic;
  signal q     : std_logic;

begin

  proc_FF: process(an_rst, clk)
  begin
    if an_rst = '0' then
      q <= '1';
    elsif clk'event and clk = '1' then
      q <= pulso_hab;
    end if;
  end process;
  
  c_in <= q and (not pulso_hab);

 -- Contador modulo 10

  proc_contador: process (clk, an_rst)
  begin
    if an_rst = '0' then
      count <= (others => '0');
    elsif c_in = '1' then
      count <= count + 1;
     -- end if;
    end if;
  end process;

  c_out <= '1' when c_in = '1' and count = 9 else '0'; 

  -- Codificador 7seg


end rtl;