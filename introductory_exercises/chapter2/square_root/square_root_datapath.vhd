library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity square_root_datapath is
    generic(
        N: natural := 32
    );
    port(
        clk:   in  std_ulogic;
        ce:    in  std_ulogic; --clock gating
        load:  in  std_ulogic;
        x:     in  std_ulogic_vector(N-1 downto 0);
        gt:    out std_ulogic;
        r_out: out std_ulogic_vector(N-1 downto 0)
    );
end entity square_root_datapath;

architecture rtl of square_root_datapath is
    signal gt_internal: std_ulogic;
    signal r,s,next_r,next_s,shifted_next_r: std_ulogic_vector(N-1 downto 0);
    constant one_vector : std_ulogic_vector(N-1 downto 0) := (others=>'1');
begin
    r_out <= r when gt_internal='1' else (others=>'0');
    gt <= gt_internal;
    reg_r: entity work.reg
        generic map(
            N => N,
            init_val => 0
        )
        port map(
            clk  => clk,
            ce   => ce,
            load => load,
            d    => next_r,
            q    => r
        );
    reg_s: entity work.reg
        generic map(
            N => N,
            init_val => 1
        )
        port map(
            clk  => clk,
            ce   => ce,
            load => load,
            d    => next_s,
            q    => s
        );
    compute_next_r: entity work.adder
        generic map(
            N => N
        )
        port map(
            a => r,
            b => one_vector,
            c => (others => '0'),
            s => next_r
        );
    shift_next_r: entity work.left_shifter
        generic map(
            N => N
        )
        port map(
            a => next_r,
            y => shifted_next_r
        );
    compute_next_s: entity work.adder
        generic map(
            N => N
        )
        port map(
            a => shifted_next_r,
            b => s,
            c => one_vector,
            s => next_s
        );
    compute_gt: entity work.comparator_gt
        generic map(
            N => N
        )
        port map(
            a => next_s,
            b => x,
            gt => gt_internal
        );
end architecture rtl;
