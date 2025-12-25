library ieee;
use ieee.std_logic_1164.all;
entity counter7_3_datapath is
    generic(
        N: natural := 32
    );
    port(
        clk:       in  std_ulogic;
        fsm_state: in  std_ulogic_vector(2 downto 0);
        x1:        in  std_ulogic_vector(N-1 downto 0);
        x2:        in  std_ulogic_vector(N-1 downto 0);
        x3:        in  std_ulogic_vector(N-1 downto 0);
        x4:        in  std_ulogic_vector(N-1 downto 0);
        x5:        in  std_ulogic_vector(N-1 downto 0);
        x6:        in  std_ulogic_vector(N-1 downto 0);
        x7:        in  std_ulogic_vector(N-1 downto 0);
        y1:        out std_ulogic_vector(N-1 downto 0);
        y2:        out std_ulogic_vector(N-1 downto 0);
        y3:        out std_ulogic_vector(N-1 downto 0)
    );
end entity counter7_3_datapath;

architecture rtl of counter7_3_datapath is
    constant zero_vec: std_ulogic_vector(N-1 downto 0) := (others=>'0');
    signal x1_fa,x2_fa,x3_fa,y1_fa,y2_fa: std_ulogic_vector(N-1 downto 0);
    signal a1_d,a1_q,a2_d,a2_q: std_ulogic_vector(N-1 downto 0);
    signal b1_d,b1_q,b2_d,b2_q: std_ulogic_vector(N-1 downto 0);
    signal c1_d,c1_q,c2_d,c2_q: std_ulogic_vector(N-1 downto 0);
    signal d1_d,d1_q,d2_d,d2_q: std_ulogic_vector(N-1 downto 0);
begin
    -- FSM state determines CSA inputs and which registers receive CSA outputs
    fa: entity work.carry_save_adder
        generic map(N=>N)
        port map(
            x1 => x1_fa,
            x2 => x2_fa,
            x3 => x3_fa,
            y1 => y1_fa,
            y2 => y2_fa
        );
    a1_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => a1_d,
            q => a1_q
        );
    a2_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => a2_d,
            q => a2_q
        );
    b1_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => b1_d,
            q => b1_q
        );
    b2_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => b2_d,
            q => b2_q
        );
    c1_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => c1_d,
            q => c1_q
        );
    c2_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => c2_d,
            q => c2_q
        );
    d1_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => d1_d,
            q => d1_q
        );
    d2_reg: entity work.reg
        generic map(N=>N)
        port map(
            clk => clk,
            d => d2_d,
            q => d2_q
        );
    with fsm_state select x1_fa <=
        zero_vec when "000", --RESET
        x1       when "001", --FIRST_OP
        x4       when "010", --SECOND_OP
        a1_q     when "011", --THIRD_OP
        a2_q     when "100", --FOURTH_OP
        zero_vec when others;
    with fsm_state select x2_fa <=
        zero_vec when "000", --RESET
        x2       when "001", --FIRST_OP
        x5       when "010", --SECOND_OP
        b1_q     when "011", --THIRD_OP
        b2_q     when "100", --FOURTH_OP
        zero_vec when others;
    with fsm_state select x3_fa <=
        zero_vec when "000", --RESET
        x3       when "001", --FIRST_OP
        x6       when "010", --SECOND_OP
        x7       when "011", --THIRD_OP
        c2_q     when "100", --FOURTH_OP
        zero_vec when others;
    y1 <= c1_q;
    y2 <= d1_q;
    y3 <= d2_q;

    a1_d <= y1_fa when fsm_state="001" else zero_vec; --FIRST_OP
    a2_d <= y2_fa when fsm_state="001" else zero_vec;
    b1_d <= y1_fa when fsm_state="010" else zero_vec; --SECOND_OP
    b2_d <= y2_fa when fsm_state="010" else zero_vec;
    c1_d <= y1_fa when fsm_state="011" else zero_vec; --THIRD_OP
    c2_d <= y2_fa when fsm_state="011" else zero_vec;
    d1_d <= y1_fa when fsm_state="100" else zero_vec; --FOURTH_OP
    d2_d <= y2_fa when fsm_state="100" else zero_vec;
end architecture rtl;