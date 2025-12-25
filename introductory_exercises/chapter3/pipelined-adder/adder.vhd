library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity adder is
    port(
        cin:  in  std_ulogic;
        a:    in  std_ulogic_vector(31 downto 0);
        b:    in  std_ulogic_vector(31 downto 0);
        cout: out std_ulogic;
        s:    out std_ulogic_vector(31 downto 0)
    );
end entity adder;

architecture behavioral of adder is
    signal aux: std_ulogic_vector(32 downto 0);
    constant zeros: std_ulogic_vector(31 downto 0) := (others => '0');
begin
    aux <= std_ulogic_vector(
              unsigned('0' & a) +
              unsigned('0' & b) +
              unsigned(zeros & cin)
           );
    s    <= aux(31 downto 0);
    cout <= aux(32);
end architecture behavioral;