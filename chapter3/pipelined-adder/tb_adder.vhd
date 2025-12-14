library ieee;
use ieee.std_logic_1164.all;
entity tb_adder is
end entity tb_adder;

architecture test of tb_adder is
    signal cin, cout : std_ulogic;
    signal a,b,s : std_ulogic_vector(31 downto 0);
begin
    dut: entity work.adder
        port map(
            cin => cin,
            a => a,
            b => b,
            cout => cout,
            s => s
        );

    stimulus: process
    begin
        wait for 1 ns;
        cin <= '0';
        a <= x"10101010";
        b <= x"01010101";
        wait for 1 ns;

        assert(cout='0' and s=x"11111111")report "TEST 1 FAILED" severity failure;
        report "TEST 1 PASS" severity note;

        wait for 1 ns;
        cin <= '1';
        a <= x"FFFFFFFF";
        b <= x"00000001";
        wait for 1 ns;

        assert(cout='1' and s=x"00000001")report "TEST 2 FAILED" severity failure;
        report "TEST 2 PASS" severity note;

        wait;

    end process;
end architecture test;