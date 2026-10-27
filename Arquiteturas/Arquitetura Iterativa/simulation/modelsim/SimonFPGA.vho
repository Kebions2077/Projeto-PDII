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

-- DATE "10/27/2026 13:25:55"

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

ENTITY 	top_simon IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	start : IN std_logic;
	busy : OUT std_logic;
	done : OUT std_logic
	);
END top_simon;

-- Design Ports Information
-- busy	=>  Location: PIN_U11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- done	=>  Location: PIN_V11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- start	=>  Location: PIN_V12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_F1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF top_simon IS
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
SIGNAL \SIMON_CORE|key_start~q\ : std_logic;
SIGNAL \SIMON_CORE|key_start~feeder_combout\ : std_logic;
SIGNAL \busy~output_o\ : std_logic;
SIGNAL \done~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[0]~6_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|Equal0~0_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[0]~7\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[1]~9_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[1]~10\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[2]~11_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[2]~12\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[3]~13_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[3]~14\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[4]~15_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[4]~16\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador[5]~17_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|Equal0~1_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|ativo~0_combout\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|ativo~q\ : std_logic;
SIGNAL \SIMON_CORE|KEY_SCHEDULE|round_valid~q\ : std_logic;
SIGNAL \start~input_o\ : std_logic;
SIGNAL \SIMON_CORE|Selector71~1_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[0]~8_combout\ : std_logic;
SIGNAL \SIMON_CORE|Selector73~0_combout\ : std_logic;
SIGNAL \SIMON_CORE|state.RUN~q\ : std_logic;
SIGNAL \SIMON_CORE|contador[5]~6_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[5]~10_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[5]~11_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[0]~9\ : std_logic;
SIGNAL \SIMON_CORE|contador[1]~12_combout\ : std_logic;
SIGNAL \~GND~combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[1]~13\ : std_logic;
SIGNAL \SIMON_CORE|contador[2]~14_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[2]~15\ : std_logic;
SIGNAL \SIMON_CORE|contador[3]~16_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[3]~17\ : std_logic;
SIGNAL \SIMON_CORE|contador[4]~18_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[4]~19\ : std_logic;
SIGNAL \SIMON_CORE|contador[5]~20_combout\ : std_logic;
SIGNAL \SIMON_CORE|contador[5]~7_combout\ : std_logic;
SIGNAL \SIMON_CORE|Selector0~0_combout\ : std_logic;
SIGNAL \SIMON_CORE|Selector72~2_combout\ : std_logic;
SIGNAL \SIMON_CORE|state.WAIT_KEY~q\ : std_logic;
SIGNAL \SIMON_CORE|Selector71~0_combout\ : std_logic;
SIGNAL \SIMON_CORE|state.IDLE~2_combout\ : std_logic;
SIGNAL \SIMON_CORE|state.IDLE~q\ : std_logic;
SIGNAL \SIMON_CORE|Selector0~1_combout\ : std_logic;
SIGNAL \SIMON_CORE|ocupado~q\ : std_logic;
SIGNAL \SIMON_CORE|terminou~q\ : std_logic;
SIGNAL \SIMON_CORE|contador\ : std_logic_vector(5 DOWNTO 0);
SIGNAL \SIMON_CORE|KEY_SCHEDULE|contador\ : std_logic_vector(5 DOWNTO 0);
SIGNAL \ALT_INV_reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \SIMON_CORE|ALT_INV_state.RUN~q\ : std_logic;

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
\SIMON_CORE|ALT_INV_state.RUN~q\ <= NOT \SIMON_CORE|state.RUN~q\;

-- Location: FF_X28_Y1_N27
\SIMON_CORE|key_start\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|key_start~feeder_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|key_start~q\);

-- Location: LCCOMB_X28_Y1_N26
\SIMON_CORE|key_start~feeder\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|key_start~feeder_combout\ = \SIMON_CORE|Selector71~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \SIMON_CORE|Selector71~1_combout\,
	combout => \SIMON_CORE|key_start~feeder_combout\);

-- Location: IOOBUF_X29_Y0_N23
\busy~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMON_CORE|ocupado~q\,
	devoe => ww_devoe,
	o => \busy~output_o\);

-- Location: IOOBUF_X29_Y0_N16
\done~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMON_CORE|terminou~q\,
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

-- Location: LCCOMB_X28_Y1_N14
\SIMON_CORE|KEY_SCHEDULE|contador[0]~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|contador[0]~6_combout\ = \SIMON_CORE|KEY_SCHEDULE|contador\(0) $ (VCC)
-- \SIMON_CORE|KEY_SCHEDULE|contador[0]~7\ = CARRY(\SIMON_CORE|KEY_SCHEDULE|contador\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|KEY_SCHEDULE|contador\(0),
	datad => VCC,
	combout => \SIMON_CORE|KEY_SCHEDULE|contador[0]~6_combout\,
	cout => \SIMON_CORE|KEY_SCHEDULE|contador[0]~7\);

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

-- Location: LCCOMB_X28_Y1_N12
\SIMON_CORE|KEY_SCHEDULE|process_0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\ = (\SIMON_CORE|key_start~q\ & !\SIMON_CORE|KEY_SCHEDULE|ativo~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|key_start~q\,
	datad => \SIMON_CORE|KEY_SCHEDULE|ativo~q\,
	combout => \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\);

-- Location: LCCOMB_X28_Y1_N8
\SIMON_CORE|KEY_SCHEDULE|Equal0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|Equal0~0_combout\ = (\SIMON_CORE|KEY_SCHEDULE|contador\(1) & (!\SIMON_CORE|KEY_SCHEDULE|contador\(2) & (\SIMON_CORE|KEY_SCHEDULE|contador\(0) & \SIMON_CORE|KEY_SCHEDULE|contador\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|KEY_SCHEDULE|contador\(1),
	datab => \SIMON_CORE|KEY_SCHEDULE|contador\(2),
	datac => \SIMON_CORE|KEY_SCHEDULE|contador\(0),
	datad => \SIMON_CORE|KEY_SCHEDULE|contador\(3),
	combout => \SIMON_CORE|KEY_SCHEDULE|Equal0~0_combout\);

-- Location: LCCOMB_X28_Y1_N30
\SIMON_CORE|KEY_SCHEDULE|contador[5]~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\ = (\SIMON_CORE|KEY_SCHEDULE|ativo~q\ & (((!\SIMON_CORE|KEY_SCHEDULE|Equal0~1_combout\) # (!\SIMON_CORE|KEY_SCHEDULE|Equal0~0_combout\)))) # (!\SIMON_CORE|KEY_SCHEDULE|ativo~q\ & (\SIMON_CORE|key_start~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|key_start~q\,
	datab => \SIMON_CORE|KEY_SCHEDULE|ativo~q\,
	datac => \SIMON_CORE|KEY_SCHEDULE|Equal0~0_combout\,
	datad => \SIMON_CORE|KEY_SCHEDULE|Equal0~1_combout\,
	combout => \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\);

-- Location: FF_X28_Y1_N15
\SIMON_CORE|KEY_SCHEDULE|contador[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|KEY_SCHEDULE|contador[0]~6_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sclr => \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\,
	ena => \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|contador\(0));

-- Location: LCCOMB_X28_Y1_N16
\SIMON_CORE|KEY_SCHEDULE|contador[1]~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|contador[1]~9_combout\ = (\SIMON_CORE|KEY_SCHEDULE|contador\(1) & (!\SIMON_CORE|KEY_SCHEDULE|contador[0]~7\)) # (!\SIMON_CORE|KEY_SCHEDULE|contador\(1) & ((\SIMON_CORE|KEY_SCHEDULE|contador[0]~7\) # (GND)))
-- \SIMON_CORE|KEY_SCHEDULE|contador[1]~10\ = CARRY((!\SIMON_CORE|KEY_SCHEDULE|contador[0]~7\) # (!\SIMON_CORE|KEY_SCHEDULE|contador\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|KEY_SCHEDULE|contador\(1),
	datad => VCC,
	cin => \SIMON_CORE|KEY_SCHEDULE|contador[0]~7\,
	combout => \SIMON_CORE|KEY_SCHEDULE|contador[1]~9_combout\,
	cout => \SIMON_CORE|KEY_SCHEDULE|contador[1]~10\);

-- Location: FF_X28_Y1_N17
\SIMON_CORE|KEY_SCHEDULE|contador[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|KEY_SCHEDULE|contador[1]~9_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sclr => \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\,
	ena => \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|contador\(1));

-- Location: LCCOMB_X28_Y1_N18
\SIMON_CORE|KEY_SCHEDULE|contador[2]~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|contador[2]~11_combout\ = (\SIMON_CORE|KEY_SCHEDULE|contador\(2) & (\SIMON_CORE|KEY_SCHEDULE|contador[1]~10\ $ (GND))) # (!\SIMON_CORE|KEY_SCHEDULE|contador\(2) & (!\SIMON_CORE|KEY_SCHEDULE|contador[1]~10\ & VCC))
-- \SIMON_CORE|KEY_SCHEDULE|contador[2]~12\ = CARRY((\SIMON_CORE|KEY_SCHEDULE|contador\(2) & !\SIMON_CORE|KEY_SCHEDULE|contador[1]~10\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|KEY_SCHEDULE|contador\(2),
	datad => VCC,
	cin => \SIMON_CORE|KEY_SCHEDULE|contador[1]~10\,
	combout => \SIMON_CORE|KEY_SCHEDULE|contador[2]~11_combout\,
	cout => \SIMON_CORE|KEY_SCHEDULE|contador[2]~12\);

-- Location: FF_X28_Y1_N19
\SIMON_CORE|KEY_SCHEDULE|contador[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|KEY_SCHEDULE|contador[2]~11_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sclr => \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\,
	ena => \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|contador\(2));

-- Location: LCCOMB_X28_Y1_N20
\SIMON_CORE|KEY_SCHEDULE|contador[3]~13\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|contador[3]~13_combout\ = (\SIMON_CORE|KEY_SCHEDULE|contador\(3) & (!\SIMON_CORE|KEY_SCHEDULE|contador[2]~12\)) # (!\SIMON_CORE|KEY_SCHEDULE|contador\(3) & ((\SIMON_CORE|KEY_SCHEDULE|contador[2]~12\) # (GND)))
-- \SIMON_CORE|KEY_SCHEDULE|contador[3]~14\ = CARRY((!\SIMON_CORE|KEY_SCHEDULE|contador[2]~12\) # (!\SIMON_CORE|KEY_SCHEDULE|contador\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|KEY_SCHEDULE|contador\(3),
	datad => VCC,
	cin => \SIMON_CORE|KEY_SCHEDULE|contador[2]~12\,
	combout => \SIMON_CORE|KEY_SCHEDULE|contador[3]~13_combout\,
	cout => \SIMON_CORE|KEY_SCHEDULE|contador[3]~14\);

-- Location: FF_X28_Y1_N21
\SIMON_CORE|KEY_SCHEDULE|contador[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|KEY_SCHEDULE|contador[3]~13_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sclr => \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\,
	ena => \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|contador\(3));

-- Location: LCCOMB_X28_Y1_N22
\SIMON_CORE|KEY_SCHEDULE|contador[4]~15\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|contador[4]~15_combout\ = (\SIMON_CORE|KEY_SCHEDULE|contador\(4) & (\SIMON_CORE|KEY_SCHEDULE|contador[3]~14\ $ (GND))) # (!\SIMON_CORE|KEY_SCHEDULE|contador\(4) & (!\SIMON_CORE|KEY_SCHEDULE|contador[3]~14\ & VCC))
-- \SIMON_CORE|KEY_SCHEDULE|contador[4]~16\ = CARRY((\SIMON_CORE|KEY_SCHEDULE|contador\(4) & !\SIMON_CORE|KEY_SCHEDULE|contador[3]~14\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|KEY_SCHEDULE|contador\(4),
	datad => VCC,
	cin => \SIMON_CORE|KEY_SCHEDULE|contador[3]~14\,
	combout => \SIMON_CORE|KEY_SCHEDULE|contador[4]~15_combout\,
	cout => \SIMON_CORE|KEY_SCHEDULE|contador[4]~16\);

-- Location: FF_X28_Y1_N23
\SIMON_CORE|KEY_SCHEDULE|contador[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|KEY_SCHEDULE|contador[4]~15_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sclr => \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\,
	ena => \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|contador\(4));

-- Location: LCCOMB_X28_Y1_N24
\SIMON_CORE|KEY_SCHEDULE|contador[5]~17\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|contador[5]~17_combout\ = \SIMON_CORE|KEY_SCHEDULE|contador[4]~16\ $ (\SIMON_CORE|KEY_SCHEDULE|contador\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \SIMON_CORE|KEY_SCHEDULE|contador\(5),
	cin => \SIMON_CORE|KEY_SCHEDULE|contador[4]~16\,
	combout => \SIMON_CORE|KEY_SCHEDULE|contador[5]~17_combout\);

-- Location: FF_X28_Y1_N25
\SIMON_CORE|KEY_SCHEDULE|contador[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|KEY_SCHEDULE|contador[5]~17_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sclr => \SIMON_CORE|KEY_SCHEDULE|process_0~0_combout\,
	ena => \SIMON_CORE|KEY_SCHEDULE|contador[5]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|contador\(5));

-- Location: LCCOMB_X28_Y1_N10
\SIMON_CORE|KEY_SCHEDULE|Equal0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|Equal0~1_combout\ = (!\SIMON_CORE|KEY_SCHEDULE|contador\(4) & \SIMON_CORE|KEY_SCHEDULE|contador\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \SIMON_CORE|KEY_SCHEDULE|contador\(4),
	datad => \SIMON_CORE|KEY_SCHEDULE|contador\(5),
	combout => \SIMON_CORE|KEY_SCHEDULE|Equal0~1_combout\);

-- Location: LCCOMB_X28_Y1_N28
\SIMON_CORE|KEY_SCHEDULE|ativo~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|KEY_SCHEDULE|ativo~0_combout\ = (\SIMON_CORE|KEY_SCHEDULE|ativo~q\ & (((!\SIMON_CORE|KEY_SCHEDULE|Equal0~0_combout\) # (!\SIMON_CORE|KEY_SCHEDULE|Equal0~1_combout\)))) # (!\SIMON_CORE|KEY_SCHEDULE|ativo~q\ & (\SIMON_CORE|key_start~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|key_start~q\,
	datab => \SIMON_CORE|KEY_SCHEDULE|Equal0~1_combout\,
	datac => \SIMON_CORE|KEY_SCHEDULE|ativo~q\,
	datad => \SIMON_CORE|KEY_SCHEDULE|Equal0~0_combout\,
	combout => \SIMON_CORE|KEY_SCHEDULE|ativo~0_combout\);

-- Location: FF_X28_Y1_N29
\SIMON_CORE|KEY_SCHEDULE|ativo\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|KEY_SCHEDULE|ativo~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|ativo~q\);

-- Location: FF_X29_Y1_N13
\SIMON_CORE|KEY_SCHEDULE|round_valid\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \SIMON_CORE|KEY_SCHEDULE|ativo~q\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|KEY_SCHEDULE|round_valid~q\);

-- Location: IOIBUF_X29_Y0_N1
\start~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_start,
	o => \start~input_o\);

-- Location: LCCOMB_X29_Y1_N24
\SIMON_CORE|Selector71~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|Selector71~1_combout\ = (\start~input_o\ & !\SIMON_CORE|state.IDLE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \start~input_o\,
	datad => \SIMON_CORE|state.IDLE~q\,
	combout => \SIMON_CORE|Selector71~1_combout\);

-- Location: LCCOMB_X30_Y1_N14
\SIMON_CORE|contador[0]~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[0]~8_combout\ = \SIMON_CORE|contador\(0) $ (VCC)
-- \SIMON_CORE|contador[0]~9\ = CARRY(\SIMON_CORE|contador\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|contador\(0),
	datad => VCC,
	combout => \SIMON_CORE|contador[0]~8_combout\,
	cout => \SIMON_CORE|contador[0]~9\);

-- Location: LCCOMB_X29_Y1_N30
\SIMON_CORE|Selector73~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|Selector73~0_combout\ = (\SIMON_CORE|Selector71~1_combout\ & (\SIMON_CORE|state.RUN~q\ & (\SIMON_CORE|Selector71~0_combout\ $ (\SIMON_CORE|Selector0~0_combout\)))) # (!\SIMON_CORE|Selector71~1_combout\ & ((\SIMON_CORE|Selector71~0_combout\ & 
-- ((\SIMON_CORE|state.RUN~q\) # (!\SIMON_CORE|Selector0~0_combout\))) # (!\SIMON_CORE|Selector71~0_combout\ & (\SIMON_CORE|state.RUN~q\ & !\SIMON_CORE|Selector0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000011010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|Selector71~1_combout\,
	datab => \SIMON_CORE|Selector71~0_combout\,
	datac => \SIMON_CORE|state.RUN~q\,
	datad => \SIMON_CORE|Selector0~0_combout\,
	combout => \SIMON_CORE|Selector73~0_combout\);

-- Location: FF_X29_Y1_N31
\SIMON_CORE|state.RUN\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|Selector73~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|state.RUN~q\);

-- Location: LCCOMB_X30_Y1_N4
\SIMON_CORE|contador[5]~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[5]~6_combout\ = (!\SIMON_CORE|contador\(2) & (\SIMON_CORE|contador\(1) & (\SIMON_CORE|contador\(0) & \SIMON_CORE|state.RUN~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|contador\(2),
	datab => \SIMON_CORE|contador\(1),
	datac => \SIMON_CORE|contador\(0),
	datad => \SIMON_CORE|state.RUN~q\,
	combout => \SIMON_CORE|contador[5]~6_combout\);

-- Location: LCCOMB_X29_Y1_N14
\SIMON_CORE|contador[5]~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[5]~10_combout\ = (\SIMON_CORE|state.WAIT_KEY~q\ & (((!\SIMON_CORE|KEY_SCHEDULE|round_valid~q\)))) # (!\SIMON_CORE|state.WAIT_KEY~q\ & ((\SIMON_CORE|state.RUN~q\ & ((!\SIMON_CORE|KEY_SCHEDULE|round_valid~q\))) # 
-- (!\SIMON_CORE|state.RUN~q\ & (!\start~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000111111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|state.WAIT_KEY~q\,
	datab => \start~input_o\,
	datac => \SIMON_CORE|state.RUN~q\,
	datad => \SIMON_CORE|KEY_SCHEDULE|round_valid~q\,
	combout => \SIMON_CORE|contador[5]~10_combout\);

-- Location: LCCOMB_X30_Y1_N12
\SIMON_CORE|contador[5]~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[5]~11_combout\ = (!\SIMON_CORE|contador[5]~10_combout\ & ((!\SIMON_CORE|contador[5]~6_combout\) # (!\SIMON_CORE|contador[5]~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|contador[5]~7_combout\,
	datac => \SIMON_CORE|contador[5]~6_combout\,
	datad => \SIMON_CORE|contador[5]~10_combout\,
	combout => \SIMON_CORE|contador[5]~11_combout\);

-- Location: FF_X30_Y1_N15
\SIMON_CORE|contador[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|contador[0]~8_combout\,
	asdata => \SIMON_CORE|state.WAIT_KEY~q\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \SIMON_CORE|ALT_INV_state.RUN~q\,
	ena => \SIMON_CORE|contador[5]~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|contador\(0));

-- Location: LCCOMB_X30_Y1_N16
\SIMON_CORE|contador[1]~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[1]~12_combout\ = (\SIMON_CORE|contador\(1) & (!\SIMON_CORE|contador[0]~9\)) # (!\SIMON_CORE|contador\(1) & ((\SIMON_CORE|contador[0]~9\) # (GND)))
-- \SIMON_CORE|contador[1]~13\ = CARRY((!\SIMON_CORE|contador[0]~9\) # (!\SIMON_CORE|contador\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|contador\(1),
	datad => VCC,
	cin => \SIMON_CORE|contador[0]~9\,
	combout => \SIMON_CORE|contador[1]~12_combout\,
	cout => \SIMON_CORE|contador[1]~13\);

-- Location: LCCOMB_X30_Y1_N10
\~GND\ : cycloneiii_lcell_comb
-- Equation(s):
-- \~GND~combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~GND~combout\);

-- Location: FF_X30_Y1_N17
\SIMON_CORE|contador[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|contador[1]~12_combout\,
	asdata => \~GND~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \SIMON_CORE|ALT_INV_state.RUN~q\,
	ena => \SIMON_CORE|contador[5]~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|contador\(1));

-- Location: LCCOMB_X30_Y1_N18
\SIMON_CORE|contador[2]~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[2]~14_combout\ = (\SIMON_CORE|contador\(2) & (\SIMON_CORE|contador[1]~13\ $ (GND))) # (!\SIMON_CORE|contador\(2) & (!\SIMON_CORE|contador[1]~13\ & VCC))
-- \SIMON_CORE|contador[2]~15\ = CARRY((\SIMON_CORE|contador\(2) & !\SIMON_CORE|contador[1]~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|contador\(2),
	datad => VCC,
	cin => \SIMON_CORE|contador[1]~13\,
	combout => \SIMON_CORE|contador[2]~14_combout\,
	cout => \SIMON_CORE|contador[2]~15\);

-- Location: FF_X30_Y1_N19
\SIMON_CORE|contador[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|contador[2]~14_combout\,
	asdata => \~GND~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \SIMON_CORE|ALT_INV_state.RUN~q\,
	ena => \SIMON_CORE|contador[5]~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|contador\(2));

-- Location: LCCOMB_X30_Y1_N20
\SIMON_CORE|contador[3]~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[3]~16_combout\ = (\SIMON_CORE|contador\(3) & (!\SIMON_CORE|contador[2]~15\)) # (!\SIMON_CORE|contador\(3) & ((\SIMON_CORE|contador[2]~15\) # (GND)))
-- \SIMON_CORE|contador[3]~17\ = CARRY((!\SIMON_CORE|contador[2]~15\) # (!\SIMON_CORE|contador\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|contador\(3),
	datad => VCC,
	cin => \SIMON_CORE|contador[2]~15\,
	combout => \SIMON_CORE|contador[3]~16_combout\,
	cout => \SIMON_CORE|contador[3]~17\);

-- Location: FF_X30_Y1_N21
\SIMON_CORE|contador[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|contador[3]~16_combout\,
	asdata => \~GND~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \SIMON_CORE|ALT_INV_state.RUN~q\,
	ena => \SIMON_CORE|contador[5]~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|contador\(3));

-- Location: LCCOMB_X30_Y1_N22
\SIMON_CORE|contador[4]~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[4]~18_combout\ = (\SIMON_CORE|contador\(4) & (\SIMON_CORE|contador[3]~17\ $ (GND))) # (!\SIMON_CORE|contador\(4) & (!\SIMON_CORE|contador[3]~17\ & VCC))
-- \SIMON_CORE|contador[4]~19\ = CARRY((\SIMON_CORE|contador\(4) & !\SIMON_CORE|contador[3]~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|contador\(4),
	datad => VCC,
	cin => \SIMON_CORE|contador[3]~17\,
	combout => \SIMON_CORE|contador[4]~18_combout\,
	cout => \SIMON_CORE|contador[4]~19\);

-- Location: FF_X30_Y1_N23
\SIMON_CORE|contador[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|contador[4]~18_combout\,
	asdata => \~GND~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \SIMON_CORE|ALT_INV_state.RUN~q\,
	ena => \SIMON_CORE|contador[5]~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|contador\(4));

-- Location: LCCOMB_X30_Y1_N24
\SIMON_CORE|contador[5]~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[5]~20_combout\ = \SIMON_CORE|contador[4]~19\ $ (\SIMON_CORE|contador\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \SIMON_CORE|contador\(5),
	cin => \SIMON_CORE|contador[4]~19\,
	combout => \SIMON_CORE|contador[5]~20_combout\);

-- Location: FF_X30_Y1_N25
\SIMON_CORE|contador[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|contador[5]~20_combout\,
	asdata => \~GND~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \SIMON_CORE|ALT_INV_state.RUN~q\,
	ena => \SIMON_CORE|contador[5]~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|contador\(5));

-- Location: LCCOMB_X30_Y1_N30
\SIMON_CORE|contador[5]~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|contador[5]~7_combout\ = (\SIMON_CORE|contador\(5) & (!\SIMON_CORE|contador\(4) & \SIMON_CORE|contador\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|contador\(5),
	datac => \SIMON_CORE|contador\(4),
	datad => \SIMON_CORE|contador\(3),
	combout => \SIMON_CORE|contador[5]~7_combout\);

-- Location: LCCOMB_X29_Y1_N10
\SIMON_CORE|Selector0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|Selector0~0_combout\ = (\SIMON_CORE|KEY_SCHEDULE|round_valid~q\ & (\SIMON_CORE|contador[5]~7_combout\ & \SIMON_CORE|contador[5]~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|KEY_SCHEDULE|round_valid~q\,
	datac => \SIMON_CORE|contador[5]~7_combout\,
	datad => \SIMON_CORE|contador[5]~6_combout\,
	combout => \SIMON_CORE|Selector0~0_combout\);

-- Location: LCCOMB_X29_Y1_N26
\SIMON_CORE|Selector72~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|Selector72~2_combout\ = (\SIMON_CORE|Selector71~1_combout\ & (((!\SIMON_CORE|KEY_SCHEDULE|round_valid~q\ & \SIMON_CORE|state.WAIT_KEY~q\)) # (!\SIMON_CORE|Selector0~0_combout\))) # (!\SIMON_CORE|Selector71~1_combout\ & 
-- (\SIMON_CORE|state.WAIT_KEY~q\ & (\SIMON_CORE|KEY_SCHEDULE|round_valid~q\ $ (!\SIMON_CORE|Selector0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SIMON_CORE|KEY_SCHEDULE|round_valid~q\,
	datab => \SIMON_CORE|Selector71~1_combout\,
	datac => \SIMON_CORE|state.WAIT_KEY~q\,
	datad => \SIMON_CORE|Selector0~0_combout\,
	combout => \SIMON_CORE|Selector72~2_combout\);

-- Location: FF_X29_Y1_N27
\SIMON_CORE|state.WAIT_KEY\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|Selector72~2_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|state.WAIT_KEY~q\);

-- Location: LCCOMB_X29_Y1_N12
\SIMON_CORE|Selector71~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|Selector71~0_combout\ = (\SIMON_CORE|KEY_SCHEDULE|round_valid~q\ & \SIMON_CORE|state.WAIT_KEY~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \SIMON_CORE|KEY_SCHEDULE|round_valid~q\,
	datad => \SIMON_CORE|state.WAIT_KEY~q\,
	combout => \SIMON_CORE|Selector71~0_combout\);

-- Location: LCCOMB_X29_Y1_N20
\SIMON_CORE|state.IDLE~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|state.IDLE~2_combout\ = (\SIMON_CORE|state.IDLE~q\ & (((\SIMON_CORE|Selector71~0_combout\) # (!\SIMON_CORE|Selector0~0_combout\)))) # (!\SIMON_CORE|state.IDLE~q\ & (!\SIMON_CORE|Selector0~0_combout\ & (\start~input_o\ $ 
-- (\SIMON_CORE|Selector71~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011110110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \SIMON_CORE|Selector71~0_combout\,
	datac => \SIMON_CORE|state.IDLE~q\,
	datad => \SIMON_CORE|Selector0~0_combout\,
	combout => \SIMON_CORE|state.IDLE~2_combout\);

-- Location: FF_X29_Y1_N21
\SIMON_CORE|state.IDLE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|state.IDLE~2_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|state.IDLE~q\);

-- Location: LCCOMB_X29_Y1_N28
\SIMON_CORE|Selector0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \SIMON_CORE|Selector0~1_combout\ = (!\SIMON_CORE|Selector0~0_combout\ & ((\SIMON_CORE|state.IDLE~q\) # (\start~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SIMON_CORE|state.IDLE~q\,
	datac => \start~input_o\,
	datad => \SIMON_CORE|Selector0~0_combout\,
	combout => \SIMON_CORE|Selector0~1_combout\);

-- Location: FF_X29_Y1_N29
\SIMON_CORE|ocupado\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|Selector0~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|ocupado~q\);

-- Location: FF_X29_Y1_N11
\SIMON_CORE|terminou\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \SIMON_CORE|Selector0~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMON_CORE|terminou~q\);

ww_busy <= \busy~output_o\;

ww_done <= \done~output_o\;
END structure;


