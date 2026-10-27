transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura parcialmente desenrolada/top_simon_unrolled.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura parcialmente desenrolada/simon_unrolled.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura parcialmente desenrolada/simon_round.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura parcialmente desenrolada/simon_key_schedule.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquitetura parcialmente desenrolada/simon_4rounds.vhd}

