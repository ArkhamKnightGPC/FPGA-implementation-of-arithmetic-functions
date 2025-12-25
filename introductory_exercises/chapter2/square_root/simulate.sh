ghdl -a reg.vhd adder.vhd left_shifter.vhd comparator_gt.vhd square_root_control_unit.vhd square_root_datapath.vhd square_root.vhd tb_square_root.vhd
ghdl -e tb_square_root
ghdl -r tb_square_root --vcd=square_root.vcd