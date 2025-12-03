set -e
ghdl --clean
ghdl -a reg.vhd
ghdl -a full_adder.vhd
ghdl -a carry_save_adder.vhd
ghdl -a counter7_3_control_unit.vhd
ghdl -a counter7_3_datapath.vhd
ghdl -a sequential_counter7_3.vhd
ghdl -a tb_sequential_counter7_3.vhd
echo "ANALYSIS DONE!"
ghdl -e tb_sequential_counter7_3
echo "ELABORATION DONE!"
ghdl -r tb_sequential_counter7_3 --vcd=seq7_3.vcd