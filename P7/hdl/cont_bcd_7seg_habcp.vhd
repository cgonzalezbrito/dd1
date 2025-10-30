library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cont_bcd_7seg_habcp is
  port (
    an_rst      : in std_logic;                   -- reset asincrono, activo en '0'
    clk         : in std_logic;
    pulso_hab   : in std_logic;                   -- nivel; generaremos tick en la bajada
    disp7seg    : buffer std_logic_vector(6 downto 0));

end entity;

architecture rtl of cont_bcd_7seg_habcp is
  signal count : std_logic_vector(3 downto 0);
  signal c_in  : std_logic;                  -- tick de flanco de bajada
  --signal c_out : std_logic;                  -- pulso 1 ciclo al pasar por 9
  signal q     : std_logic;                  -- pulso_hab registrado

begin
 -- 1) Registrar pulso_hab (evitamos q='1' en reset para no generar tick espurio)
  proc_FF: process(an_rst, clk)
  begin
    if an_rst = '0' then
      q <= '0';
    elsif clk'event and clk = '1' then
      q <= pulso_hab;
    end if;
  end process;
  
 -- 2) Detector de flanco de bajada (enmascarado en reset)
  c_in <= '0' when an_rst='0' else (q and (not pulso_hab));

 -- 3) Contador BCD 0..9 con enable c_in y c_out registrado

  proc_contador: process (clk, an_rst)
  begin
    if an_rst = '0' then
      count <= (others => '0');
    elsif clk'event and clk = '1' then
      if c_in = '1' then
        if count = "1001" then
           count <= (others => '0');
        else
      	    count <= count + 1;
        end if;
      end if;
    end if;
  end process;

  -- 4) LUT BCD -> 7 segmentos 
  proc_deco:
  process(count)
  begin
    case count is
	  when "0000" => disp7seg <= "0000001";
	  when "0001" => disp7seg <= "1001111";
	  when "0010" => disp7seg <= "0010010";
	  when "0011" => disp7seg <= "0000110";
	  when "0100" => disp7seg <= "1001100";
	  when "0101" => disp7seg <= "0100100";
	  when "0110" => disp7seg <= "0100000";
	  when "0111" => disp7seg <= "0001111";
	  when "1000" => disp7seg <= "0000000";
	  when "1001" => disp7seg <= "0001100";
	  when others => disp7seg <= "XXXXXXX";
	end case;
  end process;
  
  

end rtl;