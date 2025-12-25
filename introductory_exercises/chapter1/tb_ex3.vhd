library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ex3 is
end entity;

architecture test of tb_ex3 is

    constant N: natural := 32;
    signal s: std_ulogic_vector(2 downto 0) := (others => '0');
    signal d: std_ulogic_vector(8*N-1 downto 0);
    signal expected, y: std_ulogic_vector(N-1 downto 0);

begin

    dut: entity work.ex3
        generic map (N => N)
        port map (
            s => s,
            d => d,
            y => y
        );

    stimulus: process
    begin
        d <= x"0000000011111111222222223333333344444444555555556666666677777777"; wait for 1 ns;
        for i in 0 to 7 loop
            s <= std_ulogic_vector(to_unsigned(i, 3));
            expected <= d((i+1)*N - 1 downto i*N);
            wait for 10 ns;

            assert (y=expected) report "TEST " & integer'image(i) & " FAIL" severity failure;
            report "TEST " & integer'image(i) & " PASS" severity note;
        end loop;

        wait;
    end process;

end architecture test;
