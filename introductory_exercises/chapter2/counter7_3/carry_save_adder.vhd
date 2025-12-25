library ieee;
use ieee.std_logic_1164.all;
entity carry_save_adder is -- sum of xi = y1 + 2*y2
    generic(
        N: natural := 32
    );
    port(
        x1: in  std_ulogic_vector(N-1 downto 0);
        x2: in  std_ulogic_vector(N-1 downto 0);
        x3: in  std_ulogic_vector(N-1 downto 0);
        y1: out std_ulogic_vector(N-1 downto 0);
        y2: out std_ulogic_vector(N-1 downto 0)
    );
end entity carry_save_adder;

architecture rtl of carry_save_adder is
begin
    generate_fas: for i in 0 to N-1 generate
        fa: entity work.full_adder
            port map(
                a => x1(i),
                b => x2(i),
                cin => x3(i),
                s => y1(i),
                cout => y2(i)
            );
    end generate generate_fas;
end architecture rtl;