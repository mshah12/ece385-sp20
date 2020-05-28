transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/full_adder.sv}
vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/shift_register.sv}
vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/hex_driver.sv}
vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/d_flip_flop.sv}
vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/nine_bit_adder.sv}
vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/control_unit.sv}
vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/top_level_unit.sv}

vlog -sv -work work +incdir+U:/Desktop/ECE385\ Projects/8bitmultiplier/8bitmultiplier {U:/Desktop/ECE385 Projects/8bitmultiplier/8bitmultiplier/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1600 ns
