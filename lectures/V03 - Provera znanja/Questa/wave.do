onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /kafa_tb/uut/clk
add wave -noupdate /kafa_tb/uut/reset_n
add wave -noupdate /kafa_tb/uut/coin_avail
add wave -noupdate /kafa_tb/uut/water_avail
add wave -noupdate /kafa_tb/uut/coffee_powder_avail
add wave -noupdate /kafa_tb/uut/plastic_glass_avail
add wave -noupdate /kafa_tb/uut/plastic_glass
add wave -noupdate /kafa_tb/uut/coffee_powder
add wave -noupdate /kafa_tb/uut/hot_water
add wave -noupdate /kafa_tb/uut/unlock
add wave -noupdate /kafa_tb/uut/coin_return
add wave -noupdate /kafa_tb/uut/my_timer
add wave -noupdate /kafa_tb/uut/my_timer_next
add wave -noupdate /kafa_tb/uut/state
add wave -noupdate /kafa_tb/uut/has_ingredients
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3292270190476 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4226850115514 ps}
