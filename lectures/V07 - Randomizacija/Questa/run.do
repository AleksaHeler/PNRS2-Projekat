if [file exists "work"] {vdel -all}
vlib work
vlog randomizacija_10.sv
vsim -coverage rand_tb -voptargs="+cover=bcestf"
run -all