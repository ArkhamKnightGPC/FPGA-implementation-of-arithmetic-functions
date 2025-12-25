library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_pipelined_adder is
end entity tb_pipelined_adder;

architecture test of tb_pipelined_adder is
    signal cin, cout: std_ulogic;
    signal a,b,s: std_ulogic_vector(127 downto 0);

    constant T: time := 20 ns;
    signal clk: std_ulogic := '0';
begin
    clk <= not clk after T/2;
    dut: entity work.pipelined_adder
        port map(
            clk => clk,
            cin => cin,
            a => a,
            b => b,
            cout => cout,
            s => s
        );
    stimulus: process
    begin
        cin <= '0';
        a <= x"00000000000000000000000000000001";
        b <= x"00000000000000000000000000000000";
        wait for T;

        cin <= '0';
        a <= x"10101010101010101010101010101010";
        b <= x"07070707070707070707070707070707";
        wait for T;

        cin <= '1';
        a <= x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
        b <= x"00000000000000000000000000000001";
        wait for T;

        report "cout = " & std_ulogic'image(cout);
        report "s = " & to_hstring(s);
        assert(cout='0' and s=x"00000000000000000000000000000001")report "TEST 1 FAILED" severity failure;
        report "TEST 1 PASS" severity note;

        wait for T;
        report "cout = " & std_ulogic'image(cout);
        report "s = " & to_hstring(s);
        assert(cout='0' and s=x"17171717171717171717171717171717")report "TEST 2 FAILED" severity failure;
        report "TEST 2 PASS" severity note;

        wait for T;
        report "cout = " & std_ulogic'image(cout);
        report "s = " & to_hstring(s);
        assert(cout='1' and s=x"00000000000000000000000000000001")report "TEST 3 FAILED" severity failure;
        report "TEST 3 PASS" severity note;

        wait;
    end process;
end architecture test;