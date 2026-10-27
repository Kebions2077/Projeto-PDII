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

-- DATE "10/27/2026 16:06:48"

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

ENTITY 	top_simon_pipeline IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	start : IN std_logic;
	done : OUT std_logic
	);
END top_simon_pipeline;

-- Design Ports Information
-- done	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_M1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- start	=>  Location: PIN_M2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF top_simon_pipeline IS
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
SIGNAL ww_done : std_logic;
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \done~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \start~input_o\ : std_logic;
SIGNAL \u_pipeline|valid1~0_combout\ : std_logic;
SIGNAL \u_pipeline|valid1~q\ : std_logic;
SIGNAL \u_pipeline|valid2~0_combout\ : std_logic;
SIGNAL \u_pipeline|valid2~q\ : std_logic;
SIGNAL \u_pipeline|valid3~0_combout\ : std_logic;
SIGNAL \u_pipeline|valid3~q\ : std_logic;
SIGNAL \u_pipeline|valid4~0_combout\ : std_logic;
SIGNAL \u_pipeline|valid4~q\ : std_logic;

BEGIN

ww_clk <= clk;
ww_reset <= reset;
ww_start <= start;
done <= ww_done;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

-- Location: IOOBUF_X0_Y12_N2
\done~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \u_pipeline|valid4~q\,
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

-- Location: IOIBUF_X0_Y11_N8
\reset~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: IOIBUF_X0_Y11_N1
\start~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_start,
	o => \start~input_o\);

-- Location: LCCOMB_X1_Y11_N2
\u_pipeline|valid1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_pipeline|valid1~0_combout\ = (!\reset~input_o\ & \start~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reset~input_o\,
	datac => \start~input_o\,
	combout => \u_pipeline|valid1~0_combout\);

-- Location: FF_X1_Y11_N3
\u_pipeline|valid1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_pipeline|valid1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_pipeline|valid1~q\);

-- Location: LCCOMB_X1_Y11_N24
\u_pipeline|valid2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_pipeline|valid2~0_combout\ = (!\reset~input_o\ & \u_pipeline|valid1~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	datad => \u_pipeline|valid1~q\,
	combout => \u_pipeline|valid2~0_combout\);

-- Location: FF_X1_Y11_N25
\u_pipeline|valid2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_pipeline|valid2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_pipeline|valid2~q\);

-- Location: LCCOMB_X1_Y11_N10
\u_pipeline|valid3~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_pipeline|valid3~0_combout\ = (!\reset~input_o\ & \u_pipeline|valid2~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	datad => \u_pipeline|valid2~q\,
	combout => \u_pipeline|valid3~0_combout\);

-- Location: FF_X1_Y11_N11
\u_pipeline|valid3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_pipeline|valid3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_pipeline|valid3~q\);

-- Location: LCCOMB_X1_Y11_N0
\u_pipeline|valid4~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \u_pipeline|valid4~0_combout\ = (!\reset~input_o\ & \u_pipeline|valid3~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	datad => \u_pipeline|valid3~q\,
	combout => \u_pipeline|valid4~0_combout\);

-- Location: FF_X1_Y11_N1
\u_pipeline|valid4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \u_pipeline|valid4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_pipeline|valid4~q\);

ww_done <= \done~output_o\;
END structure;


