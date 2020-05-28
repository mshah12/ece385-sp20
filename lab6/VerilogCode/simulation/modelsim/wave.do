onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_week2/S
add wave -noupdate /testbench_week2/Clk
add wave -noupdate /testbench_week2/Reset
add wave -noupdate /testbench_week2/Run
add wave -noupdate /testbench_week2/Continue
add wave -noupdate /testbench_week2/LED
add wave -noupdate /testbench_week2/HEX0
add wave -noupdate /testbench_week2/HEX1
add wave -noupdate /testbench_week2/HEX2
add wave -noupdate /testbench_week2/HEX3
add wave -noupdate /testbench_week2/HEX4
add wave -noupdate /testbench_week2/HEX5
add wave -noupdate /testbench_week2/HEX6
add wave -noupdate /testbench_week2/HEX7
add wave -noupdate /testbench_week2/CE
add wave -noupdate /testbench_week2/UB
add wave -noupdate /testbench_week2/LB
add wave -noupdate /testbench_week2/OE
add wave -noupdate /testbench_week2/WE
add wave -noupdate -radix hexadecimal /testbench_week2/ADDR
add wave -noupdate /testbench_week2/Data
add wave -noupdate /testbench_week2/test/my_slc/ben_reg/Data_Out
add wave -noupdate {/testbench_week2/test/my_slc/reg_file/regs[0]}
add wave -noupdate {/testbench_week2/test/my_slc/reg_file/regs[1]}
add wave -noupdate {/testbench_week2/test/my_slc/reg_file/regs[2]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {367748 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {1050 ns}
