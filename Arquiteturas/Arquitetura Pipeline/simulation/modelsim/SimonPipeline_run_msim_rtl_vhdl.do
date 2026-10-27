transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Pipeline/simon_round.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Pipeline/simon_key_schedule.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Pipeline/simon_11rounds.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Pipeline/simon_pipeline.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Pipeline/top_simon_pipeline.vhd}

