library ieee;
use ieee.std_logic_1164.all;
entity tb_ex1 is
end entity tb_ex1;

architecture test of tb_ex1 is
    constant N: natural := 8;
    signal a: std_ulogic := '0';
    signal x: std_ulogic_vector(N-1 downto 0) := (others=>'0');
    signal y: std_ulogic_vector(N-1 downto 0);

    -- ghdl does not include VHDL-2008
    function to_string (inp: std_ulogic_vector) return string is
        variable image_str: string (1 to inp'length);
        alias input_str: std_ulogic_vector (1 to inp'length) is inp;

    begin
        for i in input_str'range loop
            image_str(i) := character'VALUE(std_ulogic'IMAGE(input_str(i)));
        end loop;
        return image_str;
    end function;

begin

    dut: entity work.ex1
    generic map(
        N => N
    )
    port map(
        a => a,
        x => x,
        y => y
    );

    stimulus: process
        variable expected : std_ulogic_vector(N-1 downto 0);
    begin
        -- Test 1: a = 0, x = 10101010
        a <= '0';
        x <= "10101010";
        wait for 10 ns;

        expected := "00000000";

        assert (y = expected)
        report "TEST 1 FAIL: y=" & to_string(y) &
               " expected=" & to_string(expected)
        severity failure;

        report "TEST 1 PASS" severity note;

        -- Test 2: a = 1, same x
        a <= '1';
        wait for 10 ns;

        expected := "10101010";

        assert (y = expected)
        report "TEST 2 FAIL: y=" & to_string(y) &
               " expected=" & to_string(expected)
        severity failure;

        report "TEST 2 PASS" severity note;

        -- Test 3: a = 0, x = 11111111
        a <= '0';
        x <= (others => '1');
        wait for 10 ns;

        expected := "00000000";

        assert (y = expected)
        report "TEST 3 FAIL: y=" & to_string(y) &
               " expected=" & to_string(expected)
        severity failure;

        report "TEST 3 PASS" severity note;

        wait;

    end process;

end architecture test;