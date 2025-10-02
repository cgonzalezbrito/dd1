-- Autor: cgonzalezbrito
-- Fecha: 25-09-2025
-- TBC
-- TBC

library ieee;
use ieee.std_logic_1164.all;

entity reg16b_ena_rst is
port(
  clk : in std_logic;
  nRST: in std_logic;
  sRST: in std_logic;
  ena : in std_logic;
  Din : in std_logic_vector(15 downto 0);
  Dout: buffer std_logic_vector(15 downto 0)
);
end entity;

architecture rtl of reg16b_ena_rst is
begin

   process(clk, nRST)
   begin
      if nRST = '0' then
	     Dout <= (others => '0');
      elsif clk'event and clk = '1' then
         if sRST = '1' then
           Dout <=(others => '0');
         elsif ena = '1' then
           Dout <= Din;
         end if;
      end if;
   end process;
end rtl;
