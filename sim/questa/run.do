if [file exists "work"] {vdel -all}
vlib work
vlog -f sim.f
vopt testbench_top -o top_optimized  +acc +cover=sbfec+device.
vsim top_optimized -coverage +UVM_TESTNAME=device_model_base_test

do wave.do

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save device_model_base_test.ucdb

