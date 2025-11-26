library IEEE;
use IEEE.std_logic_1164.all;
entity ex2 is
    port(
        a:      in  std_ulogic;
        b:      in  std_ulogic;
        b_in:   in  std_ulogic;
        d:      out std_ulogic;
        b_out:  out std_ulogic
    );
end entity ex2;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity lut3 is
    generic(
        truth_vector: std_ulogic_vector(0 to 7)
    );
    port(
        a: in  std_ulogic_vector(2 downto 0);
        b: out std_ulogic
    );
end entity lut3;

architecture arch_lut3 of lut3 is
begin
    b <= truth_vector(to_integer(unsigned(a)));
end architecture arch_lut3;

architecture boolean_equations of ex2 is
begin
    d <= a xor b xor b_in;
    b_out <= ((not a) and (b or b_in)) or (a and b and b_in);
end architecture boolean_equations;

architecture truth_table of ex2 is
    signal x: std_ulogic_vector(2 downto 0);
begin
    x <= a&b&b_in;
    with x select d <=
        '0' when "000",
        '1' when "001",
        '1' when "010",
        '0' when "011",
        '1' when "100",
        '0' when "101",
        '0' when "110",
        '1' when others;
    with x select b_out <=
        '0' when "000",
        '1' when "001",
        '1' when "010",
        '1' when "011",
        '0' when "100",
        '0' when "101",
        '0' when "110",
        '1' when others;
end architecture truth_table;

architecture lut of ex2 is
    component lut3 is
        generic(
            truth_vector: std_ulogic_vector(0 to 7)
        );
        port(
            a: in  std_ulogic_vector(2 downto 0);
            b: out std_ulogic
        );
    end component;

    signal inp: std_ulogic_vector(2 downto 0);
begin
    inp <= a&b&b_in;
    lut_d: lut3
        generic map(truth_vector => "01101001")
        port map(a=>inp, b=>d);
    lut_b_out: lut3
        generic map(truth_vector => "01110001")
        port map(a=>inp, b=>b_out);
end architecture lut;
