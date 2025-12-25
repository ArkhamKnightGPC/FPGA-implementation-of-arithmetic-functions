library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ex5 is
    generic(
        N: natural := 32
    );
    port(
        a:  in   std_ulogic_vector(N-1 downto 0);
        b:  in   std_ulogic_vector(N-1 downto 0);
        gt: out  std_ulogic
    );
end entity ex5;

architecture behavioral of ex5 is
begin
    gt <= '1' when to_integer(unsigned(a)) >= to_integer(unsigned(b)) else '0';
end architecture behavioral;