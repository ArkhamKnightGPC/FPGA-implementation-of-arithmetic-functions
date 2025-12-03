library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity adder is
    generic(
        N: natural := 32
    );
    port(
        a: in  std_ulogic_vector(N-1 downto 0);
        b: in  std_ulogic_vector(N-1 downto 0);
        c: in  std_ulogic_vector(N-1 downto 0);
        s: out std_ulogic_vector(N-1 downto 0)
    );
end entity adder;

architecture rtl of adder is
    signal tmp : unsigned(N+1 downto 0);
begin
    tmp <= ("00" & unsigned(a)) + ("00" & unsigned(b)) + ("00" & unsigned(c)); -- pad to avoid overflow
    s <= std_ulogic_vector(tmp(N-1 downto 0));
end architecture rtl;

