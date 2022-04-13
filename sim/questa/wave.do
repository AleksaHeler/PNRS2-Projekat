onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/device_interface/PCLK
add wave -noupdate /testbench/device_interface/PRESETn
add wave -noupdate /testbench/device_interface/PSEL
add wave -noupdate /testbench/device_interface/PENABLE
add wave -noupdate /testbench/device_interface/PADDR
add wave -noupdate /testbench/device_interface/PWDATA
add wave -noupdate /testbench/device_interface/PRDATA
add wave -noupdate /testbench/device_interface/PWRITE
add wave -noupdate /testbench/device_interface/gpio_o
add wave -noupdate /testbench/device_interface/gpio_i
add wave -noupdate /testbench/device_interface/gpio_oe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 282
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ns} {919 ns}
