create_clock -name clk -period 5.000 [get_ports clk]
derive_clock_uncertainty
set_false_path -from [get_ports {reset start}]
set_false_path -to [get_ports {busy done}]