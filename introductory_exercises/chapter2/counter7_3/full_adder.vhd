library ieee;
use ieee.std_logic_1164.all;
entity full_adder is
    port(
        a:    in  std_ulogic;
        b:    in  std_ulogic;
        cin:  in  std_ulogic;
        s:    out std_ulogic;
        cout: out std_ulogic
    );
end entity full_adder;

architecture rtl of full_adder is
begin
    s <= a xor b xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);
end architecture rtl;