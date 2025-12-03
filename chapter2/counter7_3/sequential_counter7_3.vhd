library ieee;
use ieee.std_logic_1164.all;
entity sequential_counter7_3 is -- sum of xi = y1 + 2*y2 + 4*y3
    generic(
        N: natural := 32
    );
    port(
        clk:   in  std_ulogic;
        rst:   in  std_ulogic;
        start: in  std_ulogic;
        x1:    in  std_ulogic_vector(N-1 downto 0);
        x2:    in  std_ulogic_vector(N-1 downto 0);
        x3:    in  std_ulogic_vector(N-1 downto 0);
        x4:    in  std_ulogic_vector(N-1 downto 0);
        x5:    in  std_ulogic_vector(N-1 downto 0);
        x6:    in  std_ulogic_vector(N-1 downto 0);
        x7:    in  std_ulogic_vector(N-1 downto 0);
        y1:    out std_ulogic_vector(N-1 downto 0);
        y2:    out std_ulogic_vector(N-1 downto 0);
        y3:    out std_ulogic_vector(N-1 downto 0);
        done:  out std_ulogic
    );
end entity sequential_counter7_3;

architecture rtl of sequential_counter7_3 is
    -- here we use 2 step FSM to optimize circuit area and energy consumption
    signal state_internal: std_ulogic_vector(2 downto 0);
begin
    control_unit: entity work.counter7_3_control_unit
        port map(
            clk => clk,
            rst => rst,
            start => start,
            state_out => state_internal,
            done => done
        );
    datapath: entity work.counter7_3_datapath
        generic map(
            N => N
        )
        port map(
            clk => clk,
            fsm_state => state_internal,
            x1 => x1,
            x2 => x2,
            x3 => x3,
            x4 => x4,
            x5 => x5,
            x6 => x6,
            x7 => x7,
            y1 => y1,
            y2 => y2,
            y3 => y3
        );
end architecture rtl;
