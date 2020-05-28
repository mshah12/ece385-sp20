transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/HexDriver.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/tristate.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/test_memory.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/datapath.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/register.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/memory_contents.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/ISDU.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/slc3.sv}
vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/lab6_toplevel.sv}

vlog -sv -work work +incdir+C:/Week2_LAB6/Lab6_LC3 {C:/Week2_LAB6/Lab6_LC3/testbench_week2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_week2

add wave *
view structure
view signals
run 1000 ns
