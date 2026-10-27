transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Bitserial/simon_round.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Bitserial/simon_key_schedule.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Bitserial/simon_bitserial.vhd}
vcom -93 -work work {F:/av1/Projeto-PDII/Arquiteturas/Arquitetura Bitserial/top_simon_bitserial.vhd}

