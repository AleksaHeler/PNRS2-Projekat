onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_top/dut/PRESETn
add wave -noupdate /testbench_top/dut/PCLK
add wave -noupdate /testbench_top/dut/PSEL
add wave -noupdate /testbench_top/dut/PENABLE
add wave -noupdate /testbench_top/dut/PADDR
add wave -noupdate /testbench_top/dut/PWRITE
add wave -noupdate /testbench_top/dut/PSTRB
add wave -noupdate /testbench_top/dut/PWDATA
add wave -noupdate /testbench_top/dut/PRDATA
add wave -noupdate /testbench_top/dut/PREADY
add wave -noupdate /testbench_top/dut/PSLVERR
add wave -noupdate /testbench_top/dut/irq_o
add wave -noupdate /testbench_top/dut/gpio_i
add wave -noupdate /testbench_top/dut/gpio_o
add wave -noupdate /testbench_top/dut/gpio_oe
add wave -noupdate /testbench_top/dut/mode_reg
add wave -noupdate /testbench_top/dut/dir_reg
add wave -noupdate /testbench_top/dut/out_reg
add wave -noupdate /testbench_top/dut/in_reg
add wave -noupdate /testbench_top/dut/tr_type_reg
add wave -noupdate /testbench_top/dut/tr_lvl0_reg
add wave -noupdate /testbench_top/dut/tr_lvl1_reg
add wave -noupdate /testbench_top/dut/tr_stat_reg
add wave -noupdate /testbench_top/dut/irq_ena_reg
add wave -noupdate /testbench_top/dut/tr_in_dly_reg
add wave -noupdate /testbench_top/dut/tr_rising_edge_reg
add wave -noupdate /testbench_top/dut/tr_falling_edge_reg
add wave -noupdate /testbench_top/dut/tr_status
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 241
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {5462 ns}
