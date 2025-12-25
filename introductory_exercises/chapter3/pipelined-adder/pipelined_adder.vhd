library ieee;
use ieee.std_logic_1164.all;
entity pipelined_adder is
    port(
        clk:  in  std_ulogic;
        cin:  in  std_ulogic;
        a:    in  std_ulogic_vector(127 downto 0);
        b:    in  std_ulogic_vector(127 downto 0);
        cout: out std_ulogic;
        s:    out std_ulogic_vector(127 downto 0)
    );
end entity pipelined_adder;

architecture rtl of pipelined_adder is
    signal cout_stage1, cout_stage2, cout_stage3, cout_stage4: std_ulogic;
    signal s_stage1, s_stage2, s_stage3, s_stage4: std_ulogic_vector(31 downto 0);

    constant FFs_stage1: natural := 225;
    signal d_reg1, q_reg1: std_ulogic_vector(FFs_stage1-1 downto 0);
    constant FFs_stage2: natural := 193;
    signal d_reg2, q_reg2: std_ulogic_vector(FFs_stage2-1 downto 0);
    constant FFs_stage3: natural := 161;
    signal d_reg3, q_reg3: std_ulogic_vector(FFs_stage3-1 downto 0);
begin
    stage1: entity work.adder
        port map(
            cin => cin,
            a => a(31 downto 0),
            b => b(31 downto 0),
            cout => cout_stage1,
            s => s_stage1
        );
    d_reg1 <= s_stage1 & cout_stage1 & a(127 downto 32) & b(127 downto 32);
    reg1: entity work.reg
        generic map(
            N => FFs_stage1
        )
        port map(
            clk => clk,
            d => d_reg1,
            q => q_reg1
        );
    stage2: entity work.adder
        port map(
            cin => q_reg1(192),
            a => q_reg1(127 downto 96), -- a(63 downto 32)
            b => q_reg1(31 downto 0), -- b(63 downto 32)
            cout => cout_stage2,
            s => s_stage2
        );
    d_reg2 <= s_stage2 & q_reg1(224 downto 193) & cout_stage2 & q_reg1(191 downto 128) & q_reg1(95 downto 32);
    reg2: entity work.reg
        generic map(
            N => FFs_stage2
        )
        port map(
            clk => clk,
            d => d_reg2,
            q => q_reg2
        );
    stage3: entity work.adder
        port map(
            cin => q_reg2(128),
            a => q_reg2(95 downto 64), -- a(95 downto 64)
            b => q_reg2(31 downto 0), -- b(95 downto 64)
            cout => cout_stage3,
            s => s_stage3
        );
    d_reg3 <= s_stage3 & q_reg2(192 downto 129) & cout_stage3 & q_reg2(127 downto 96) & q_reg2(63 downto 32);
    reg3: entity work.reg
        generic map(
            N => FFs_stage3
        )
        port map(
            clk => clk,
            d => d_reg3,
            q => q_reg3
        );
    stage4: entity work.adder
        port map(
            cin => q_reg3(64),
            a => q_reg3(63 downto 32), -- a(127 downto 96)
            b => q_reg3(31 downto 0), -- b(127 downto 96)
            cout => cout_stage4,
            s => s_stage4
        );
    cout <= cout_stage4;
    s <= s_stage4 & q_reg3(160 downto 65);
end architecture rtl;