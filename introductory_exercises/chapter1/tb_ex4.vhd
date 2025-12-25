library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_ex4 is
end entity tb_ex4;

architecture test of tb_ex4 is
    constant N: natural := 4;
    signal enc: std_ulogic_vector(N-1 downto 0);
    signal dec: std_ulogic_vector(2**N-1 downto 0);
begin

    dut: entity work.ex4
        generic map(N => N)
        port map(enc => enc, dec => dec);

    stimulus: process
        variable expected: std_ulogic_vector(2**N-1 downto 0) := (others => '0');
    begin
        for i in 0 to 2**N-1 loop
            enc <= std_ulogic_vector(to_unsigned(i, N));
            expected(i) := '1';
            wait for 10 ns;

            assert(dec = expected)report "TEST " & integer'image(i+1) & " FAIL" severity failure;
            report "TEST " & integer'image(i+1) & " PASS" severity note;

            expected(i) := '0'; wait for 1 ns;

        end loop;
        wait;
    end process;

end architecture test;