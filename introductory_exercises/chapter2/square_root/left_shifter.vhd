library ieee;
use ieee.std_logic_1164.all;
entity left_shifter is
    generic(
        N: natural := 32
    );
    port(
        a: in  std_ulogic_vector(N-1 downto 0);
        y: out std_ulogic_vector(N-1 downto 0)
    );
end entity left_shifter;

architecture rtl of left_shifter is
begin
    y <= a(N-2 downto 0)&'0';
end architecture rtl;
