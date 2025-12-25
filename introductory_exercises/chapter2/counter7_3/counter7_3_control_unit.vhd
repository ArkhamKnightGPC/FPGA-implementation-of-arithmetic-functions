library ieee;
use ieee.std_logic_1164.all;
entity counter7_3_control_unit is
    port(
        clk:       in  std_ulogic;
        rst:       in  std_ulogic;
        start:     in  std_ulogic;
        state_out: out std_ulogic_vector(2 downto 0);
        done:      out std_ulogic
    );
end entity counter7_3_control_unit;

architecture rtl of counter7_3_control_unit is
    type state is(
        RESET,
        FIRST_OP,
        SECOND_OP,
        THIRD_OP,
        FOURTH_OP,
        FINAL
    );
    signal present_state, next_state: state;
begin
    process(clk, rst)
    begin
        if rst='1' then
            present_state <= RESET;
        elsif clk'event and clk='1' then
            present_state <= next_state;
        end if;
    end process;

    process(present_state, start)
    begin
        case present_state is
            when RESET =>
                if start = '1' then
                    next_state <= FIRST_OP;
                else
                    next_state <= RESET;
                end if;
            when FIRST_OP =>
                next_state <= SECOND_OP;
            when SECOND_OP =>
                next_state <= THIRD_OP;
            when THIRD_OP =>
                next_state <= FOURTH_OP;
            when FOURTH_OP =>
                next_state <= FINAL;
            when others =>
                next_state <= FINAL; --loop in FINAL until RESET
        end case;
    end process;

    with present_state select state_out <=
        "000" when RESET,
        "001" when FIRST_OP,
        "010" when SECOND_OP,
        "011" when THIRD_OP,
        "100" when FOURTH_OP,
        "101" when FINAL,
        "111" when others;
    done <= '1' when present_state=FINAL else '0';
end architecture rtl;