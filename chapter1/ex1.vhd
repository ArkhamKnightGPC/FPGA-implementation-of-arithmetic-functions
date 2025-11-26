library ieee;
use ieee.std_logic_1164.all;
entity ex1 is
    generic(
        N: natural := 32
    );
    port(
        a: in  std_ulogic;
        x: in  std_ulogic_vector(N-1 downto 0);
        y: out std_ulogic_vector(N-1 downto 0)
    );
end entity ex1;

architecture behavioral of ex1 is
begin
    y <= x when a='1' else (others => '0');
end architecture behavioral;
