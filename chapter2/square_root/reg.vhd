library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity reg is
    generic(
        N:        natural := 32;
        init_val: natural := 0
    );
    port(
        clk:  in std_ulogic;
        ce:   in std_ulogic;
        load: in std_ulogic;
        d:    in std_ulogic_vector(N-1 downto 0);
        q:    out std_ulogic_vector(N-1 downto 0)
    );
end entity reg;
architecture rtl of reg is
    signal q_reg : std_ulogic_vector(N-1 downto 0) := std_ulogic_vector(to_unsigned(init_val, N));
begin
    process(clk)
    begin
        if clk'event and clk='1' then
            if load='1' then
                q_reg <= std_ulogic_vector(to_unsigned(init_val, N));
            elsif ce='1' then
                q_reg <= d;
            end if;
        end if;
    end process;
    q <= q_reg;
end architecture rtl;
