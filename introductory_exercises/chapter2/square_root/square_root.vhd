library ieee;
use ieee.std_logic_1164.all;
entity square_root is
    generic(
        N: natural := 32
    );
    port(
        clk:        in  std_ulogic;
        rst:        in  std_ulogic;
        start:      in  std_ulogic;
        x:          in  std_ulogic_vector(N-1 downto 0);
        sqrt_ready: out std_ulogic;
        sqrt_x:     out std_ulogic_vector(N-1 downto 0)
    );
end entity square_root;

architecture rtl of square_root is
    signal gt, in_main_loop, load_internal: std_ulogic;
    signal internal_state: std_ulogic_vector(1 downto 0);
begin
    sqrt_ready <= '1' when internal_state="11" else '0';
    control_unit: entity work.square_root_control_unit
        port map(
            clk => clk,
            rst => rst,
            start => start,
            gt => gt,
            in_main_loop => in_main_loop,
            state_out => internal_state
        );
    datapath: entity work.square_root_datapath
        generic map(
            N => N
        )
        port map(
            clk => clk,
            ce => in_main_loop,
            load => load_internal,
            x => x,
            gt => gt,
            r_out => sqrt_x
        );
    load_internal <= not in_main_loop;

end architecture rtl;