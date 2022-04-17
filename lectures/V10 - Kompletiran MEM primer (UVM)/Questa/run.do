if [file exists "work"] {vdel -all}
vlib work
vlog -f sim.f
vopt tbench_top -o top_optimized  +acc +cover=sbfec+device.
vsim top_optimized -coverage +UVM_TESTNAME=device_model_base_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save device_model_base_test.ucdb


vsim top_optimized -coverage +UVM_TESTNAME=device_wr_rd_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save device_wr_rd_test.ucdb

vsim top_optimized -coverage +UVM_TESTNAME=device_all_wr_rd_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save device_all_wr_rd_test.ucdb

vsim top_optimized -coverage +UVM_TESTNAME=deterministic_all_wr_rd_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save deterministic_all_wr_rd_test.ucdb


vcover merge  device_model_base_test.ucdb device_wr_rd_test.ucdb device_all_wr_rd_test.ucdb deterministic_all_wr_rd_test.ucdb -out device_overall_coverage.ucdb
vcover report device_overall_coverage.ucdb -cvg -details
quit

