library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity ex4 is
    generic(
        N: natural := 4
    );
    port(
        enc: in   std_ulogic_vector(N-1 downto 0);
        dec: out  std_ulogic_vector(2**N-1 downto 0)
    );
end entity ex4;

architecture behavioral of ex4 is
begin
    process(enc)
        variable tmp: std_ulogic_vector(2**N-1 downto 0);
    begin
        tmp := (others => '0');
        tmp(to_integer(unsigned(enc))) := '1';
        dec <= tmp;
    end process;
end architecture behavioral;