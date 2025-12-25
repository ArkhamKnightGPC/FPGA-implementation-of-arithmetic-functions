library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity comparator_gt is
    generic(
        N: natural := 32
    );
    port(
        a:   in   std_ulogic_vector(N-1 downto 0);
        b:   in   std_ulogic_vector(N-1 downto 0);
        gt:  out  std_ulogic
    );
end entity comparator_gt;

architecture rtl of comparator_gt is
begin
    gt <= '1' when unsigned(a) > unsigned(b) else '0';
end architecture rtl;
