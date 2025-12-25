ghdl -a --std=08 reg.vhd adder.vhd pipelined_adder.vhd tb_pipelined_adder.vhd
ghdl -e --std=08 tb_pipelined_adder
ghdl -r --std=08 tb_pipelined_adder --vcd=pipelined_adder.vcd