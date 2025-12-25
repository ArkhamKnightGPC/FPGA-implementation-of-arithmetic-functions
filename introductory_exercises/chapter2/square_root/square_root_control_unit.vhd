library ieee;
use ieee.std_logic_1164.all;
entity square_root_control_unit is
    port(
        clk:          in  std_ulogic;
        rst:          in  std_ulogic;
        start:        in  std_ulogic;
        gt:           in  std_ulogic;
        in_main_loop: out std_ulogic;
        state_out:    out std_ulogic_vector(1 downto 0)
    );
end entity square_root_control_unit;

architecture rtl of square_root_control_unit is
    type state is(
        RESET,
        WAIT_START,
        MAIN_LOOP,
        FINAL
    );
    signal present_state, next_state: state;
begin

    process(clk, rst) -- asynchronous reset
    begin
        if rst='1' then
            present_state <= RESET;
        elsif clk'event and clk='1' then
            present_state <= next_state;
        end if;
    end process;

    process(present_state, start, gt, rst)
    begin
        case present_state is
            when RESET =>
                if start = '0' then
                    next_state <= WAIT_START;
                else
                    next_state <= RESET;
                end if;
            when WAIT_START =>
                if start = '1' then
                    next_state <= MAIN_LOOP;
                else
                    next_state <= WAIT_START;
                end if;
            when MAIN_LOOP =>
                if gt = '1' then
                    next_state <= FINAL;
                else
                    next_state <= MAIN_LOOP;
                end if;
            when FINAL =>
                if rst = '1' then
                    next_state <= RESET;
                else
                    next_state <= FINAL;
                end if;
            when others =>
                next_state <= RESET;
        end case;
    end process;

    in_main_loop <= '1' when present_state=MAIN_LOOP else '0';
    with present_state select state_out <=
        "00" when RESET,
        "01" when WAIT_START,
        "10" when MAIN_LOOP,
        "11" when others; --FINAL
end architecture rtl;