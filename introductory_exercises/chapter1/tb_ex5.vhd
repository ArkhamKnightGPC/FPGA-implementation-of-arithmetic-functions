library ieee;
use ieee.std_logic_1164.all;
entity tb_ex5 is
end entity tb_ex5;

architecture test of tb_ex5 is
    constant N: natural := 4;
    signal a,b: std_ulogic_vector(N-1 downto 0) := (others=>'0');
    signal expected,gt: std_ulogic;
begin

    dut: entity work.ex5
        generic map(N => N)
        port map(a=>a, b=>b, gt=>gt);

    stimulus: process
    begin
        a <= "1000"; b <= "0111"; expected <= '1'; wait for 10 ns;
        assert(expected=gt)report "TEST 1 FAIL" severity failure;
        report "TEST 1 PASS" severity note;

        a <= "0111"; b <= "0111"; expected <= '1'; wait for 10 ns;
        assert(expected=gt)report "TEST 2 FAIL" severity failure;
        report "TEST 2 PASS" severity note;

        a <= "0110"; b <= "0111"; expected <= '0'; wait for 10 ns;
        assert(expected=gt)report "TEST 3 FAIL" severity failure;
        report "TEST 3 PASS" severity note;

        a <= "0110"; b <= "0110"; expected <= '1'; wait for 10 ns;
        assert(expected=gt)report "TEST 4 FAIL" severity failure;
        report "TEST 4 PASS" severity note;

        wait;
    end process;

end architecture test;