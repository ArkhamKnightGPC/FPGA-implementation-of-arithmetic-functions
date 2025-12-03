library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_sequential_counter7_3 is
end entity tb_sequential_counter7_3;

architecture test of tb_sequential_counter7_3 is
    constant N: natural := 4;
    constant T: time := 20 ns;
    signal clk,rst,start: std_ulogic := '0';
    signal done : std_ulogic;
    signal x1,x2,x3,x4,x5,x6,x7 : std_ulogic_vector(N-1 downto 0) := (others => '0');
    signal y1,y2,y3 : std_ulogic_vector(N-1 downto 0);
begin
    clk <= (not clk) after T;
    dut: entity work.sequential_counter7_3
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            start => start,
            x1 => x1,
            x2 => x2,
            x3 => x3,
            x4 => x4,
            x5 => x5,
            x6 => x6,
            x7 => x7,
            y1 => y1,
            y2 => y2,
            y3 => y3,
            done => done
        );
    stimulus: process
        variable sum_x, sum_y : integer := 0;
    begin
        rst <= '1'; wait for T;
        rst <= '0';
        x1 <= "0001";
        x2 <= "0010";
        x3 <= "0011";
        x4 <= "0100";
        x5 <= "0101";
        x6 <= "0110";
        x7 <= "0111";
        start <= '1'; wait until done ='1';

        sum_x := to_integer(unsigned(x1)) + to_integer(unsigned(x2))
            + to_integer(unsigned(x3)) + to_integer(unsigned(x4))
            + to_integer(unsigned(x5)) + to_integer(unsigned(x6)) + to_integer(unsigned(x7));
        sum_y := to_integer(unsigned(y1)) + 2*to_integer(unsigned(y2)) + 4*to_integer(unsigned(y3));

        report "sum_x = " & integer'image(sum_x);
        report "sum_y = " & integer'image(sum_y);

        assert(sum_y = sum_x)report "TEST 1 FAILED" severity failure;
        report "TEST 1 PASS" severity note;
        wait;

    end process;
end architecture test;