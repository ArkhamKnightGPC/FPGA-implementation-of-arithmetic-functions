ghdl -a full_adder.vhd carry_save_adder.vhd combinatorial_counter7_3.vhd tb_combinatorial_counter7_3.vhd
ghdl -e tb_combinatorial_counter7_3
ghdl -r tb_combinatorial_counter7_3 --vcd=comb7_3.vcd