library ieee;
use ieee.std_logic_1164.all;
entity combinatorial_counter7_3 is -- sum of xi = y1 + 2*y2 + 4*y3
    generic(
        N: natural := 32
    );
    port(
        x1: in  std_ulogic_vector(N-1 downto 0);
        x2: in  std_ulogic_vector(N-1 downto 0);
        x3: in  std_ulogic_vector(N-1 downto 0);
        x4: in  std_ulogic_vector(N-1 downto 0);
        x5: in  std_ulogic_vector(N-1 downto 0);
        x6: in  std_ulogic_vector(N-1 downto 0);
        x7: in  std_ulogic_vector(N-1 downto 0);
        y1: out std_ulogic_vector(N-1 downto 0);
        y2: out std_ulogic_vector(N-1 downto 0);
        y3: out std_ulogic_vector(N-1 downto 0)
    );
end entity combinatorial_counter7_3;

architecture rtl of combinatorial_counter7_3 is
    -- IMPORTANT: computation takes 2*T_fa, so output displayed at T_fa in this arch is undetermined
    -- in simulation, computations are instant... so we shouldn't see this propagation delay effect
    signal a1,a2,b1,b2,c1,c2,d1,d2 : std_ulogic_vector(N-1 downto 0);
begin

    op1: entity work.carry_save_adder
        generic map(N => N)
        port map(
            x1 => x1,
            x2 => x2,
            x3 => x3,
            y1 => a1,
            y2 => a2
        );
    op2: entity work.carry_save_adder
        generic map(N => N)
        port map(
            x1 => x4,
            x2 => x5,
            x3 => x6,
            y1 => b1,
            y2 => b2
        );
    op3: entity work.carry_save_adder
        generic map(N => N)
        port map(
            x1 => a1,
            x2 => b1,
            x3 => x7,
            y1 => c1,
            y2 => c2
        );
    op4: entity work.carry_save_adder
        generic map(N => N)
        port map(
            x1 => a2,
            x2 => b2,
            x3 => c2,
            y1 => d1,
            y2 => d2
        );
    y1 <= c1;
    y2 <= d1;
    y3 <= d2;
end architecture rtl;
