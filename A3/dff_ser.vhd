library ieee;
use ieee.std_logic_1164.all;

entity dff_ser is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        nSet_syn: in std_logic;
        ena : in std_logic;
        rst_syn : in std_logic;
        D : in std_logic;
        Q : buffer std_logic
    );
end entity;

architecture rtl of dff_ser is
begin
    process(clk, nRst)
    begin
        if nRst = '0' then
            Q <= (others => '0');
        elsif clk'event and clk = '1' then
            --código para modelar el funcionamiento síncrono (para completar másadelante #2)
        end if;
    end process;
end rtl;