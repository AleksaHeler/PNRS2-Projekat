onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbench_top/intf/clk
add wave -noupdate /tbench_top/intf/reset
add wave -noupdate /tbench_top/intf/address
add wave -noupdate /tbench_top/intf/write_dual_en
add wave -noupdate /tbench_top/intf/write_en
add wave -noupdate /tbench_top/intf/read_dual_en
add wave -noupdate /tbench_top/intf/read_en
add wave -noupdate /tbench_top/intf/data_wr
add wave -noupdate /tbench_top/intf/data_rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {1657 ns}
