module SHA1_Implementation(	
	(* chip_pin = "M8"  *) input logic clk,
	(* chip_pin = "J21"  *) input logic reset_n,
	(* chip_pin = "H22, H21"  *) input logic [1:0] push_button,
	(* chip_pin = "C5, B4, A5, C4, B7, A6, C8, C7"*) output logic [7:0] q
	
	);

	SHA1_Base SHA1_Instance (
				.clk_clk(clk),
				.d_pb_export(push_button),
				.q_leds_export(q),
				.reset_reset_n(reset_n),
				.to_pulse_export()
			);



	
endmodule
