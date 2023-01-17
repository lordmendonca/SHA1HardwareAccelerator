transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Studies/MS/workspace/Sem-1/FPGA/SHA-1_Project {D:/Studies/MS/workspace/Sem-1/FPGA/SHA-1_Project/sha1_engine.sv}
vlib SHA1_Base
vmap SHA1_Base SHA1_Base

vlog -sv -work work +incdir+D:/Studies/MS/workspace/Sem-1/FPGA/SHA-1_Project {D:/Studies/MS/workspace/Sem-1/FPGA/SHA-1_Project/sha1_engine_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -L SHA1_Base -voptargs="+acc"  sha1_engine_tb

add wave *
view structure
view signals
run -all
