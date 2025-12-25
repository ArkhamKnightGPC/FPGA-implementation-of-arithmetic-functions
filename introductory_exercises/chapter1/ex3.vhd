library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ex3 is
    generic(
        N: natural := 32
    );
    port(
        s : in  std_ulogic_vector(2 downto 0);
        d : in  std_ulogic_vector(8*N-1 downto 0);
        y : out std_ulogic_vector(N-1 downto 0)
    );
end entity ex3;

architecture behavioral of ex3 is
begin
    process(s, d)
        variable x: integer := 0;
    begin
        x := to_integer(unsigned(s));
        y <= d( (x+1)*N - 1  downto  x*N );
    end process;
end architecture behavioral;