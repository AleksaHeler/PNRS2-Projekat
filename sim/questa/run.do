if [file exists "work"] {vdel -all}
vlib work
vlog -f sim.f

# SV testbench is 'testbench_top'
# UVM testbench is 'testbench'
vopt testbench -o top_optimized  +acc +cover=sbfec+device.


# TEST: test_reset_register_values
vsim top_optimized -coverage +UVM_TESTNAME=test_reset_register_values
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save test_reset_register_values.ucdb


# TEST: io_basic
vsim top_optimized -coverage +UVM_TESTNAME=test_io_basic
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save test_io_basic.ucdb


# TEST: io_random
vsim top_optimized -coverage +UVM_TESTNAME=test_io_random
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save test_io_random.ucdb

vcover merge test_io_random.ucdb test_reset_register_values.ucdb test_io_basic.ucdb -out device_overall_coverage.ucdb
do wave.do


