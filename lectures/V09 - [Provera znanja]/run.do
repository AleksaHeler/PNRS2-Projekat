if [file exists "work"] {vdel -all}
vlib work

vlog my_package.sv
vlog design.sv
vlog driver.sv
vlog generator.sv
vlog interface.sv
vlog environment.sv
vlog default_rd_test.sv
vlog random_test.sv
vlog wr_rd_test.sv
vlog testbench.sv

vsim tbench_top
do wave.do
run -all