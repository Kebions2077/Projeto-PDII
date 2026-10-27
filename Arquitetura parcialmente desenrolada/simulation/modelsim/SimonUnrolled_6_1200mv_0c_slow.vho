-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.0 Build 156 04/24/2013 SJ Web Edition"

-- DATE "10/27/2026 15:20:56"

-- 
-- Device: Altera EP3C25F324C6 Package FBGA324
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	top_simon_unrolled IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	start : IN std_logic;
	busy : OUT std_logic;
	done : OUT std_logic
	);
END top_simon_unrolled;

-- Design Ports Information
-- busy	=>  Location: PIN_B2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- done	=>  Location: PIN_G6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- start	=>  Location: PIN_A1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_F1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF top_simon_unrolled IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_start : std_logic;
SIGNAL ww_busy : std_logic;
SIGNAL ww_done : std_logic;
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \CORE|Add0~0_combout\ : std_logic;
SIGNAL \CORE|group_index[1]~2_combout\ : std_logic;
SIGNAL \start~input_o\ : std_logic;
SIGNAL \busy~output_o\ : std_logic;
SIGNAL \done~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \CORE|group_index[1]~3_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \CORE|group_index[0]~5_combout\ : std_logic;
SIGNAL \CORE|Add0~1_combout\ : std_logic;
SIGNAL \CORE|group_index[3]~0_combout\ : std_logic;
SIGNAL \CORE|group_index[2]~4_combout\ : std_logic;
SIGNAL \CORE|group_index[3]~1_combout\ : std_logic;
SIGNAL \CORE|done~0_combout\ : std_logic;
SIGNAL \CORE|state~0_combout\ : std_logic;
SIGNAL \CORE|state~q\ : std_logic;
SIGNAL \CORE|done~1_combout\ : std_logic;
SIGNAL \CORE|done~q\ : std_logic;
SIGNAL \CORE|group_index\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_reset~inputclkctrl_outclk\ : std_logic;

BEGIN

ww_clk <= clk;
ww_reset <= reset;
ww_start <= start;
busy <= ww_busy;
done <= ww_done;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

\reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \reset~input_o\);
\ALT_INV_reset~inputclkctrl_outclk\ <= NOT \reset~inputclkctrl_outclk\;

-- Location: LCCOMB_X1_Y33_N22
\CORE|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|Add0~0_combout\ = \CORE|group_index\(3) $ (((\CORE|group_index\(2) & (\CORE|group_index\(0) & \CORE|group_index\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CORE|group_index\(3),
	datab => \CORE|group_index\(2),
	datac => \CORE|group_index\(0),
	datad => \CORE|group_index\(1),
	combout => \CORE|Add0~0_combout\);

-- Location: LCCOMB_X1_Y33_N30
\CORE|group_index[1]~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|group_index[1]~2_combout\ = (\CORE|state~q\ & ((!\CORE|group_index\(0)))) # (!\CORE|state~q\ & (!\start~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010111110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datac => \CORE|state~q\,
	datad => \CORE|group_index\(0),
	combout => \CORE|group_index[1]~2_combout\);

-- Location: IOIBUF_X1_Y34_N1
\start~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_start,
	o => \start~input_o\);

-- Location: IOOBUF_X0_Y30_N2
\busy~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CORE|state~q\,
	devoe => ww_devoe,
	o => \busy~output_o\);

-- Location: IOOBUF_X1_Y34_N23
\done~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CORE|done~q\,
	devoe => ww_devoe,
	o => \done~output_o\);

-- Location: IOIBUF_X0_Y16_N1
\clk~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G4
\clk~inputclkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: LCCOMB_X1_Y33_N14
\CORE|group_index[1]~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|group_index[1]~3_combout\ = (\CORE|group_index[1]~2_combout\ & (((\CORE|group_index\(1))))) # (!\CORE|group_index[1]~2_combout\ & (\CORE|state~q\ & (\CORE|group_index\(1) $ (!\CORE|done~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CORE|group_index[1]~2_combout\,
	datab => \CORE|state~q\,
	datac => \CORE|group_index\(1),
	datad => \CORE|done~0_combout\,
	combout => \CORE|group_index[1]~3_combout\);

-- Location: IOIBUF_X0_Y16_N8
\reset~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: CLKCTRL_G2
\reset~inputclkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \reset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \reset~inputclkctrl_outclk\);

-- Location: FF_X1_Y33_N15
\CORE|group_index[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CORE|group_index[1]~3_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CORE|group_index\(1));

-- Location: LCCOMB_X1_Y33_N26
\CORE|group_index[0]~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|group_index[0]~5_combout\ = (\CORE|state~q\ & ((\CORE|group_index\(0) $ (!\CORE|done~0_combout\)))) # (!\CORE|state~q\ & (!\start~input_o\ & (\CORE|group_index\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000000011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \CORE|state~q\,
	datac => \CORE|group_index\(0),
	datad => \CORE|done~0_combout\,
	combout => \CORE|group_index[0]~5_combout\);

-- Location: FF_X1_Y33_N27
\CORE|group_index[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CORE|group_index[0]~5_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CORE|group_index\(0));

-- Location: LCCOMB_X1_Y33_N24
\CORE|Add0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|Add0~1_combout\ = \CORE|group_index\(2) $ (((\CORE|group_index\(1) & \CORE|group_index\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \CORE|group_index\(2),
	datac => \CORE|group_index\(1),
	datad => \CORE|group_index\(0),
	combout => \CORE|Add0~1_combout\);

-- Location: LCCOMB_X1_Y33_N20
\CORE|group_index[3]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|group_index[3]~0_combout\ = (\CORE|state~q\ & ((\CORE|done~0_combout\))) # (!\CORE|state~q\ & (!\start~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datac => \CORE|state~q\,
	datad => \CORE|done~0_combout\,
	combout => \CORE|group_index[3]~0_combout\);

-- Location: LCCOMB_X1_Y33_N0
\CORE|group_index[2]~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|group_index[2]~4_combout\ = (\CORE|group_index[3]~0_combout\ & (((\CORE|group_index\(2))))) # (!\CORE|group_index[3]~0_combout\ & (\CORE|state~q\ & (\CORE|Add0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CORE|state~q\,
	datab => \CORE|Add0~1_combout\,
	datac => \CORE|group_index\(2),
	datad => \CORE|group_index[3]~0_combout\,
	combout => \CORE|group_index[2]~4_combout\);

-- Location: FF_X1_Y33_N1
\CORE|group_index[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CORE|group_index[2]~4_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CORE|group_index\(2));

-- Location: LCCOMB_X1_Y33_N12
\CORE|group_index[3]~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|group_index[3]~1_combout\ = (\CORE|group_index[3]~0_combout\ & (((\CORE|group_index\(3))))) # (!\CORE|group_index[3]~0_combout\ & (\CORE|Add0~0_combout\ & (\CORE|state~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CORE|Add0~0_combout\,
	datab => \CORE|state~q\,
	datac => \CORE|group_index\(3),
	datad => \CORE|group_index[3]~0_combout\,
	combout => \CORE|group_index[3]~1_combout\);

-- Location: FF_X1_Y33_N13
\CORE|group_index[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CORE|group_index[3]~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CORE|group_index\(3));

-- Location: LCCOMB_X1_Y33_N16
\CORE|done~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|done~0_combout\ = (!\CORE|group_index\(0) & (!\CORE|group_index\(2) & (\CORE|group_index\(1) & \CORE|group_index\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CORE|group_index\(0),
	datab => \CORE|group_index\(2),
	datac => \CORE|group_index\(1),
	datad => \CORE|group_index\(3),
	combout => \CORE|done~0_combout\);

-- Location: LCCOMB_X1_Y33_N28
\CORE|state~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|state~0_combout\ = (\CORE|state~q\ & ((!\CORE|done~0_combout\))) # (!\CORE|state~q\ & (\start~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datac => \CORE|state~q\,
	datad => \CORE|done~0_combout\,
	combout => \CORE|state~0_combout\);

-- Location: FF_X1_Y33_N29
\CORE|state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CORE|state~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CORE|state~q\);

-- Location: LCCOMB_X1_Y33_N6
\CORE|done~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \CORE|done~1_combout\ = (\CORE|state~q\ & \CORE|done~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CORE|state~q\,
	datad => \CORE|done~0_combout\,
	combout => \CORE|done~1_combout\);

-- Location: FF_X1_Y33_N7
\CORE|done\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CORE|done~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \CORE|done~q\);

ww_busy <= \busy~output_o\;

ww_done <= \done~output_o\;
END structure;


