library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_ex2 is
end entity tb_ex2;

architecture test of tb_ex2 is
    signal a,b,b_in: std_ulogic := '0';
    signal d1, d2, d3: std_ulogic;
    signal b_out1, b_out2, b_out3: std_ulogic;
begin

    arch1: entity work.ex2(boolean_equations)
        port map(a=>a, b=>b, b_in=>b_in, d=>d1, b_out=>b_out1);

    arch2: entity work.ex2(truth_table)
        port map(a=>a, b=>b, b_in=>b_in, d=>d2, b_out=>b_out2);

    arch3: entity work.ex2(lut)
        port map(a=>a, b=>b, b_in=>b_in, d=>d3, b_out=>b_out3);

    stimulus: process
    begin
        -- Test 1: a = 0, b = 0, b_in = 0
        a <= '0';
        b <= '0';
        b_in <= '0';
        wait for 10 ns;

        assert (d1='0' and d2='0' and d3='0' and b_out1='0' and b_out2='0' and b_out3='0')
        report "TEST 1 FAIL" severity failure;
        report "TEST 1 PASS" severity note;

        -- Test 2: a = 0, b = 0, b_in = 1
        a <= '0';
        b <= '0';
        b_in <= '1';
        wait for 10 ns;

        assert (d1='1' and d2='1' and d3='1' and b_out1='1' and b_out2='1' and b_out3='1')
        report "TEST 2 FAIL" severity failure;
        report "TEST 2 PASS" severity note;

        -- Test 3: a = 0, b = 1, b_in = 0
        a <= '0';
        b <= '1';
        b_in <= '0';
        wait for 10 ns;

        assert (d1='1' and d2='1' and d3='1' and b_out1='1' and b_out2='1' and b_out3='1')
        report "TEST 3 FAIL" severity failure;
        report "TEST 3 PASS" severity note;

        -- Test 4: a = 0, b = 1, b_in = 1
        a <= '0';
        b <= '1';
        b_in <= '1';
        wait for 10 ns;

        assert (d1='0' and d2='0' and d3='0' and b_out1='1' and b_out2='1' and b_out3='1')
        report "TEST 4 FAIL" severity failure;
        report "TEST 4 PASS" severity note;

        -- Test 5: a = 1, b = 0, b_in = 0
        a <= '1';
        b <= '0';
        b_in <= '0';
        wait for 10 ns;

        assert (d1='1' and d2='1' and d3='1' and b_out1='0' and b_out2='0' and b_out3='0')
        report "TEST 5 FAIL" severity failure;
        report "TEST 5 PASS" severity note;

        -- Test 6: a = 1, b = 0, b_in = 1
        a <= '1';
        b <= '0';
        b_in <= '1';
        wait for 10 ns;

        assert (d1='0' and d2='0' and d3='0' and b_out1='0' and b_out2='0' and b_out3='0')
        report "TEST 6 FAIL" severity failure;
        report "TEST 6 PASS" severity note;

        -- Test 2: a = 1, b = 1, b_in = 0
        a <= '1';
        b <= '1';
        b_in <= '0';
        wait for 10 ns;

        assert (d1='0' and d2='0' and d3='0' and b_out1='0' and b_out2='0' and b_out3='0')
        report "TEST 7 FAIL" severity failure;
        report "TEST 7 PASS" severity note;

        -- Test 8: a = 1, b = 1, b_in = 1
        a <= '1';
        b <= '1';
        b_in <= '1';
        wait for 10 ns;

        assert (d1='1' and d2='1' and d3='1' and b_out1='1' and b_out2='1' and b_out3='1')
        report "TEST 8 FAIL" severity failure;
        report "TEST 8 PASS" severity note;
        wait;

    end process;

end architecture test;