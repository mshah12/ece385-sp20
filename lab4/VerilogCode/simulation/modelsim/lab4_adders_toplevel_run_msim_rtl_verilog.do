transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Ishaan/Desktop/16-bit\ adders-20200209T231142Z-001/16-bit\ adders {D:/Ishaan/Desktop/16-bit adders-20200209T231142Z-001/16-bit adders/carry_select_adder.sv}
vlog -sv -work work +incdir+D:/Ishaan/Desktop/16-bit\ adders-20200209T231142Z-001/16-bit\ adders {D:/Ishaan/Desktop/16-bit adders-20200209T231142Z-001/16-bit adders/full_adder.sv}
vlog -sv -work work +incdir+D:/Ishaan/Desktop/16-bit\ adders-20200209T231142Z-001/16-bit\ adders {D:/Ishaan/Desktop/16-bit adders-20200209T231142Z-001/16-bit adders/adder2.sv}
vlog -sv -work work +incdir+D:/Ishaan/Desktop/16-bit\ adders-20200209T231142Z-001/16-bit\ adders {D:/Ishaan/Desktop/16-bit adders-20200209T231142Z-001/16-bit adders/CSA_Middle_Module.sv}
vlog -sv -work work +incdir+D:/Ishaan/Desktop/16-bit\ adders-20200209T231142Z-001/16-bit\ adders {D:/Ishaan/Desktop/16-bit adders-20200209T231142Z-001/16-bit adders/four_bit_ripple_adder.sv}
vlog -sv -work work +incdir+D:/Ishaan/Desktop/16-bit\ adders-20200209T231142Z-001/16-bit\ adders {D:/Ishaan/Desktop/16-bit adders-20200209T231142Z-001/16-bit adders/two_bit_mux.sv}

vlog -sv -work work +incdir+D:/Ishaan/Desktop/16-bit\ adders-20200209T231142Z-001/16-bit\ adders {D:/Ishaan/Desktop/16-bit adders-20200209T231142Z-001/16-bit adders/csa_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  csa_testbench

add wave *
view structure
view signals
run 100 ns
