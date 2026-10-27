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

-- DATE "10/27/2026 17:11:25"

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

ENTITY 	top_simon_bitserial IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	start : IN std_logic;
	busy : OUT std_logic;
	done : OUT std_logic
	);
END top_simon_bitserial;

-- Design Ports Information
-- busy	=>  Location: PIN_T2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- done	=>  Location: PIN_R1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- start	=>  Location: PIN_T3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_T1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF top_simon_bitserial IS
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
SIGNAL \u_simon|round_count[2]~12_combout\ : std_logic;
SIGNAL \start~input_o\ : std_logic;
SIGNAL \busy~output_o\ : std_logic;
SIGNAL \done~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \u_simon|round_count[0]~7\ : std_logic;
SIGNAL \u_simon|round_count[1]~10_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \u_simon|done_reg~4_combout\ : std_logic;
SIGNAL \u_simon|round_count[0]~8_combout\ : std_logic;
SIGNAL \u_simon|round_count[0]~6_combout\ : std_logic;
SIGNAL \u_simon|Equal0~0_combout\ : std_logic;
SIGNAL \u_simon|round_count[0]~9_combout\ : std_logic;
SIGNAL \u_simon|round_count[1]~11\ : std_logic;
SIGNAL \u_simon|round_count[2]~13\ : std_logic;
SIGNAL \u_simon|round_count[3]~14_combout\ : std_logic;
SIGNAL \u_simon|round_count[3]~15\ : std_logic;
SIGNAL \u_simon|round_count[4]~16_combout\ : std_logic;
SIGNAL \u_simon|round_count[4]~17\ : std_logic;
SIGNAL \u_simon|round_count[5]~18_combout\ : std_logic;
SIGNAL \u_simon|Equal0~1_combout\ : std_logic;
SIGNAL \u_simon|active~0_combout\ : std_logic;
SIGNAL \u_simon|active~1_combout\ : std_logic;
SIGNAL \u_simon|active~q\ : std_logic;
SIGNAL \u_simon|done_reg~5_combout\ : std_logic;
SIGNAL \u_simon|done_reg~q\ : std_logic;
SIGNAL \u_simon|round_count\ : std_logic_vector(5 DOWNTO 0);

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

-- Location: FF_X1_Y7_N11
\u_simon|round_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|round_count[2]~12_combout\,
	sclr => \u_simon|done_reg~4_combout\,
	ena => \u_simon|round_count[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|round_count\(2));

-- Location: LCCOMB_X1_Y7_N10
\u_simon|round_count[2]~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[2]~12_combout\ = (\u_simon|round_count\(2) & (\u_simon|round_count[1]~11\ $ (GND))) # (!\u_simon|round_count\(2) & (!\u_simon|round_count[1]~11\ & VCC))
-- \u_simon|round_count[2]~13\ = CARRY((\u_simon|round_count\(2) & !\u_simon|round_count[1]~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_simon|round_count\(2),
	datad => VCC,
	cin => \u_simon|round_count[1]~11\,
	combout => \u_simon|round_count[2]~12_combout\,
	cout => \u_simon|round_count[2]~13\);

-- Location: IOIBUF_X0_Y6_N22
\start~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_start,
	o => \start~input_o\);

-- Location: IOOBUF_X0_Y7_N9
\busy~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \u_simon|active~q\,
	devoe => ww_devoe,
	o => \busy~output_o\);

-- Location: IOOBUF_X0_Y7_N2
\done~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \u_simon|done_reg~q\,
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

-- Location: LCCOMB_X1_Y7_N6
\u_simon|round_count[0]~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[0]~6_combout\ = \u_simon|round_count\(0) $ (VCC)
-- \u_simon|round_count[0]~7\ = CARRY(\u_simon|round_count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_simon|round_count\(0),
	datad => VCC,
	combout => \u_simon|round_count[0]~6_combout\,
	cout => \u_simon|round_count[0]~7\);

-- Location: LCCOMB_X1_Y7_N8
\u_simon|round_count[1]~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[1]~10_combout\ = (\u_simon|round_count\(1) & (!\u_simon|round_count[0]~7\)) # (!\u_simon|round_count\(1) & ((\u_simon|round_count[0]~7\) # (GND)))
-- \u_simon|round_count[1]~11\ = CARRY((!\u_simon|round_count[0]~7\) # (!\u_simon|round_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_simon|round_count\(1),
	datad => VCC,
	cin => \u_simon|round_count[0]~7\,
	combout => \u_simon|round_count[1]~10_combout\,
	cout => \u_simon|round_count[1]~11\);

-- Location: IOIBUF_X0_Y6_N15
\reset~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: LCCOMB_X1_Y7_N30
\u_simon|done_reg~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|done_reg~4_combout\ = (\reset~input_o\) # (!\u_simon|active~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	datad => \u_simon|active~q\,
	combout => \u_simon|done_reg~4_combout\);

-- Location: LCCOMB_X1_Y7_N20
\u_simon|round_count[0]~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[0]~8_combout\ = (!\start~input_o\ & (!\reset~input_o\ & !\u_simon|active~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datac => \reset~input_o\,
	datad => \u_simon|active~q\,
	combout => \u_simon|round_count[0]~8_combout\);

-- Location: FF_X1_Y7_N7
\u_simon|round_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|round_count[0]~6_combout\,
	sclr => \u_simon|done_reg~4_combout\,
	ena => \u_simon|round_count[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|round_count\(0));

-- Location: LCCOMB_X1_Y7_N4
\u_simon|Equal0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|Equal0~0_combout\ = (!\u_simon|round_count\(2) & (\u_simon|round_count\(1) & (\u_simon|round_count\(3) & \u_simon|round_count\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_simon|round_count\(2),
	datab => \u_simon|round_count\(1),
	datac => \u_simon|round_count\(3),
	datad => \u_simon|round_count\(0),
	combout => \u_simon|Equal0~0_combout\);

-- Location: LCCOMB_X1_Y7_N22
\u_simon|round_count[0]~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[0]~9_combout\ = (!\u_simon|round_count[0]~8_combout\ & (((\u_simon|done_reg~4_combout\) # (!\u_simon|Equal0~0_combout\)) # (!\u_simon|Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_simon|Equal0~1_combout\,
	datab => \u_simon|round_count[0]~8_combout\,
	datac => \u_simon|done_reg~4_combout\,
	datad => \u_simon|Equal0~0_combout\,
	combout => \u_simon|round_count[0]~9_combout\);

-- Location: FF_X1_Y7_N9
\u_simon|round_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|round_count[1]~10_combout\,
	sclr => \u_simon|done_reg~4_combout\,
	ena => \u_simon|round_count[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|round_count\(1));

-- Location: LCCOMB_X1_Y7_N12
\u_simon|round_count[3]~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[3]~14_combout\ = (\u_simon|round_count\(3) & (!\u_simon|round_count[2]~13\)) # (!\u_simon|round_count\(3) & ((\u_simon|round_count[2]~13\) # (GND)))
-- \u_simon|round_count[3]~15\ = CARRY((!\u_simon|round_count[2]~13\) # (!\u_simon|round_count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_simon|round_count\(3),
	datad => VCC,
	cin => \u_simon|round_count[2]~13\,
	combout => \u_simon|round_count[3]~14_combout\,
	cout => \u_simon|round_count[3]~15\);

-- Location: FF_X1_Y7_N13
\u_simon|round_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|round_count[3]~14_combout\,
	sclr => \u_simon|done_reg~4_combout\,
	ena => \u_simon|round_count[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|round_count\(3));

-- Location: LCCOMB_X1_Y7_N14
\u_simon|round_count[4]~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[4]~16_combout\ = (\u_simon|round_count\(4) & (\u_simon|round_count[3]~15\ $ (GND))) # (!\u_simon|round_count\(4) & (!\u_simon|round_count[3]~15\ & VCC))
-- \u_simon|round_count[4]~17\ = CARRY((\u_simon|round_count\(4) & !\u_simon|round_count[3]~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_simon|round_count\(4),
	datad => VCC,
	cin => \u_simon|round_count[3]~15\,
	combout => \u_simon|round_count[4]~16_combout\,
	cout => \u_simon|round_count[4]~17\);

-- Location: FF_X1_Y7_N15
\u_simon|round_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|round_count[4]~16_combout\,
	sclr => \u_simon|done_reg~4_combout\,
	ena => \u_simon|round_count[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|round_count\(4));

-- Location: LCCOMB_X1_Y7_N16
\u_simon|round_count[5]~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|round_count[5]~18_combout\ = \u_simon|round_count[4]~17\ $ (\u_simon|round_count\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \u_simon|round_count\(5),
	cin => \u_simon|round_count[4]~17\,
	combout => \u_simon|round_count[5]~18_combout\);

-- Location: FF_X1_Y7_N17
\u_simon|round_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|round_count[5]~18_combout\,
	sclr => \u_simon|done_reg~4_combout\,
	ena => \u_simon|round_count[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|round_count\(5));

-- Location: LCCOMB_X1_Y7_N26
\u_simon|Equal0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|Equal0~1_combout\ = (!\u_simon|round_count\(4) & \u_simon|round_count\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_simon|round_count\(4),
	datad => \u_simon|round_count\(5),
	combout => \u_simon|Equal0~1_combout\);

-- Location: LCCOMB_X1_Y7_N24
\u_simon|active~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|active~0_combout\ = (\start~input_o\ & (!\reset~input_o\ & !\u_simon|active~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \reset~input_o\,
	datad => \u_simon|active~q\,
	combout => \u_simon|active~0_combout\);

-- Location: LCCOMB_X1_Y7_N28
\u_simon|active~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|active~1_combout\ = (\u_simon|active~0_combout\) # ((!\u_simon|done_reg~4_combout\ & ((!\u_simon|Equal0~0_combout\) # (!\u_simon|Equal0~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000111110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_simon|done_reg~4_combout\,
	datab => \u_simon|Equal0~1_combout\,
	datac => \u_simon|active~0_combout\,
	datad => \u_simon|Equal0~0_combout\,
	combout => \u_simon|active~1_combout\);

-- Location: FF_X1_Y7_N29
\u_simon|active\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|active~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|active~q\);

-- Location: LCCOMB_X1_Y7_N2
\u_simon|done_reg~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_simon|done_reg~5_combout\ = (\u_simon|active~q\ & (!\reset~input_o\ & (\u_simon|Equal0~1_combout\ & \u_simon|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_simon|active~q\,
	datab => \reset~input_o\,
	datac => \u_simon|Equal0~1_combout\,
	datad => \u_simon|Equal0~0_combout\,
	combout => \u_simon|done_reg~5_combout\);

-- Location: FF_X1_Y7_N3
\u_simon|done_reg\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_simon|done_reg~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_simon|done_reg~q\);

ww_busy <= \busy~output_o\;

ww_done <= \done~output_o\;
END structure;


