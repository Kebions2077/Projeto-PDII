transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura Iterativa/simon_key_schedule.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura Iterativa/Simon_Round.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura Iterativa/simon_iterative.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura Iterativa/top_simon.vhd}

