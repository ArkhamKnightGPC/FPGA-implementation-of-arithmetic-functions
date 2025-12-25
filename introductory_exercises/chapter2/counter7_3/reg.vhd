library ieee;
use ieee.std_logic_1164.all;
entity reg is
    generic(
        N : natural := 32
    );
    port(
        clk: in  std_ulogic;
        d:   in  std_ulogic_vector(N-1 downto 0);
        q:   out std_ulogic_vector(N-1 downto 0)
    );
end entity reg;

architecture rtl of reg is
begin
    process(clk)
    begin
        if clk'event and clk='1' then
            q <= d;
        end if;
    end process;
end architecture rtl;