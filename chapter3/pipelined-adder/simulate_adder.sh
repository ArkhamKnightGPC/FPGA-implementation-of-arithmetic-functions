ghdl -a adder.vhd tb_adder.vhd
ghdl -e tb_adder
ghdl -r tb_adder --vcd=adder.vcd