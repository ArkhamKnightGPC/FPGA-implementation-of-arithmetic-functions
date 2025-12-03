library ieee;
use ieee.std_logic_1164.all;
entity tb_square_root is
end entity tb_square_root;

architecture test of tb_square_root is
    constant T: time := 20 ns; -- 50MHz clock
    constant N: natural := 32;
    signal clk, rst, start, sqrt_ready: std_ulogic := '0';
    signal x, sqrt_x: std_ulogic_vector(N-1 downto 0) := (others => '0');
begin
    dut: entity work.square_root
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            start => start,
            x => x,
            sqrt_ready => sqrt_ready,
            sqrt_x => sqrt_x
        );

    clk <= not clk after T;
    stimulus: process
    begin
        -- Test 1: x = 49
        x <= x"00000031";
        rst <= '1'; start <= '0'; wait for 2*T;
        rst <= '0'; start <= '1'; wait for 2*T;
        wait until sqrt_ready='1';

        assert(sqrt_x=x"00000007")report "TEST 1 FAILED" severity failure;
        report "TEST 1 PASS" severity note;

        -- Test 2: x = 144
        x <= x"00000090";
        rst <= '1'; start <= '0'; wait for 2*T;
        rst <= '0'; start <= '1'; wait for 2*T;
        wait until sqrt_ready='1';

        assert(sqrt_x=x"0000000B")report "TEST 2 FAILED" severity failure;
        report "TEST 2 PASS" severity note;

        wait;
    end process;
end architecture test;