ghdl -a full_adder.vhd carry_save_adder.vhd tb_carry_save_adder.vhd
ghdl -e tb_carry_save_adder
ghdl -r tb_carry_save_adder --vcd=csa.vcd