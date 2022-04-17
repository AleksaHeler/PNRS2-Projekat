if [file exists "work"] {vdel -all}
vlib work
vlog default_rd_test.sv
vlog design.sv
vlog driver.sv
vlog environment.sv
vlog generator.sv
vlog interface.sv
vlog random_test.sv
vlog testbench.sv
vlog transaction.sv
vlog wr_rd_test.sv

vsim -novopt testbench 
-voptargs=+acc=npr

do wave.do
run -all