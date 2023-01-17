
module SHA1_Base (
	clk_clk,
	d_pb_export,
	q_leds_export,
	reset_reset_n,
	to_pulse_export);	

	input		clk_clk;
	input	[1:0]	d_pb_export;
	output	[7:0]	q_leds_export;
	input		reset_reset_n;
	output		to_pulse_export;
endmodule
