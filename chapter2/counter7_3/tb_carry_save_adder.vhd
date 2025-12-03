library ieee;
use ieee.std_logic_1164.all;
entity tb_carry_save_adder is
end entity tb_carry_save_adder;

architecture test of tb_carry_save_adder is
    constant N: natural := 4;
    signal x1,x2,x3,y1,y2 : std_ulogic_vector(N-1 downto 0);
begin

    dut: entity work.carry_save_adder
        generic map(
            N => N
        )
        port map(
            x1 => x1,
            x2 => x2,
            x3 => x3,
            y1 => y1,
            y2 => y2
        );

    stimulus: process
    begin
        x1 <= "1011"; x2 <= "1101"; x3 <= "0001";
        wait for 10 ns;
        assert(y1="0111" and y2="1001")report "TEST 1 FAILED" severity failure;
        report "TEST 1 PASS" severity note;

        wait for 1 ns;
        x1 <= "1111"; x2 <= "0110"; x3 <= "1001";
        wait for 10 ns;
        assert(y1="0000" and y2="1111")report "TEST 2 FAILED" severity failure;
        report "TEST 2 PASS" severity note;

        wait;
    end process;

end architecture test;