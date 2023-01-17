
package state_machine_definitions;
	// State Machine states
	enum logic [1:0]
	{
		_RESET 	= 2'b00,
		_IDLE 	= 2'b01,
		_PROC 	= 2'b10,
		_DONE 	= 2'b11
	} state;
	// SHA-1 block states for 80 rounds calculations
	enum logic [1:0]
	{
		ITERATION_BLOCK1 = 2'b00,
		ITERATION_BLOCK2 = 2'b01,
		ITERATION_BLOCK3 = 2'b10,
		ITERATION_BLOCK4 = 2'b11
	} block_ctrl;

endpackage 

module sha1_engine
(
	input logic clk,
	input logic reset_n,
	input logic write,
	input logic read,
	input logic [5:0] address,
	input logic [31:0] writedata,
	output logic [31:0] readdata
);
	// Custom register build for SHA-1 engine
	logic [31:0] control_register;
	logic [31:0] status_register;
	logic [31:0] hash_registers [4:0];
	logic [31:0] data_registers [15:0];
	
	// Import package definition
	import state_machine_definitions::*;
	
	// Circular shift-N function
	function logic [31:0] circular_shift(input logic [31:0] word, input logic [31:0] shiftby);	
		logic [31:0] temp_word;
		temp_word = word;
		circular_shift = (word << shiftby) | (temp_word >> (32'd32 - shiftby));	
	endfunction
	
	// State machine memory registers
	logic [31:0] memory_in [4:0];
	logic [31:0] memory_out [4:0];
	
	// State machine calculation registers
	logic [31:0] iteration_calc;
	logic [31:0] k_constant;
	logic [31:0] c_intermediate;
	logic [31:0] a_intermediate;
	logic [31:0] c_shift;
	
	// message digest register for SHA-1 final stage computation
	logic [31:0] message_digest [4:0];
	
	//80-words  registers
	logic [31:0] W [79:0];
	
	// 80-words expansion claculation registers
	logic [31:0] iteration_loops;
	logic [31:0] w_temp;
	logic [31:0] w_new;
	
	// Start SHA-1 Engine pulse
	logic start_pulse;
	
	// End of SHA-1 state machine
	logic done;	
	
	// Start processing/calculation of hash
	logic start_calc;
	
	// State machine loop control
	localparam LOOP_ITERATIONS = 80;
	localparam ITERATIONS = LOOP_ITERATIONS - 1;
	localparam BITWIDTH = $clog2(ITERATIONS);
	logic [BITWIDTH-1:0] state_counter;
	
	always_ff@(posedge clk)
	begin
		if(reset_n == 1'b0)
		begin
			for(int i = 0; i < 16; i = i + 1)
				data_registers[i] <= 32'd0;
			for(int j = 0; j < 5; j = j + 1)
				hash_registers[j] <= 32'd0;
		end
		else 
		begin
			// Write from custom build registers
			if(write)
			begin
			case(address)
			0: control_register <= writedata;
			1: status_register <= writedata;
			2: hash_registers[0] <= writedata;
			3: hash_registers[1] <= writedata;
			4: hash_registers[2] <= writedata;
			5: hash_registers[3] <= writedata;
			6: hash_registers[4] <= writedata;
			7: data_registers[0] <= writedata;
			8: data_registers[1] <= writedata;
			9: data_registers[2] <= writedata;
			10: data_registers[3] <= writedata;
			11: data_registers[4] <= writedata;
			12: data_registers[5] <= writedata;
			13: data_registers[6] <= writedata;
			14: data_registers[7] <= writedata;
			15: data_registers[8] <= writedata;
			16: data_registers[9] <= writedata;
			17: data_registers[10] <= writedata;
			18: data_registers[11] <= writedata;
			19: data_registers[12] <= writedata;
			20: data_registers[13] <= writedata;
			21: data_registers[14] <= writedata;
			22: data_registers[15] <= writedata;
			endcase
			end
			// Status update to SHA-1 computation done.
			// Control register reset bit 0.
			if(state_counter == ITERATIONS)
			begin
				status_register <= 1'b1;
				//hash_registers <= message_digest;
				control_register <= {control_register[31:1], 1'b0};
			end	
			// Hash update into custom build registers
			// after SHA-1 machine triggers a done.
			if(done)
			begin
				hash_registers <= message_digest;
			end
		end
	end
	// bit [0] indicates start of SHA-1 computation when set.
	assign start_pulse = control_register[0];
	// 80-words expansion
	assign w_temp = (iteration_loops < 32'd80)? W[iteration_loops-3] ^ W[iteration_loops-8] ^ W[iteration_loops-14] ^ W[iteration_loops-16] : 'd0;
	assign w_new = (iteration_loops < 32'd80)? circular_shift(w_temp, 32'd1) : 'd0;	
	
	// SHA-1 state machine
	always_ff@(posedge clk)
		if(1'b0 == reset_n)
		begin
			state_counter <=  'd0;
			start_calc <= 1'b0;
			state <= _RESET;
		end
		else
		begin
			case(state)
			_RESET 	: 
						begin
						state_counter <= 'd0;
						start_calc <= 1'b0;						
						state <= _IDLE;
						end
			_IDLE	: 	
						begin
						state_counter <= 'd0;
						iteration_loops <= 32'd16;
						
						// loading first 16-words
						W[0] <= data_registers[0];
						W[1] <= data_registers[1];
						W[2] <= data_registers[2];
						W[3] <= data_registers[3];
						W[4] <= data_registers[4];
						W[5] <= data_registers[5];
						W[6] <= data_registers[6];
						W[7] <= data_registers[7];
						W[8] <= data_registers[8];
						W[9] <= data_registers[9];
						W[10] <= data_registers[10];
						W[11] <= data_registers[11];
						W[12] <= data_registers[12];
						W[13] <= data_registers[13];
						W[14] <= data_registers[14];
						W[15] <= data_registers[15];
						
						memory_in <= hash_registers;
												
						if(start_pulse)
							state <= _PROC;
							block_ctrl <= ITERATION_BLOCK1;
							start_calc <= 1'b1;
						end
			_PROC	:	
						begin
						
						memory_in <= memory_out;
						
						// SHA-1 compuatation block control
						if(state_counter < 'd19)
							block_ctrl <= ITERATION_BLOCK1;
						else if(state_counter >= 'd19 && state_counter < 'd39)
							block_ctrl <= ITERATION_BLOCK2;
						else if(state_counter >= 'd39 && state_counter < 'd59)
							block_ctrl <= ITERATION_BLOCK3;
						else if(state_counter >= 'd59 && state_counter < 'd79)
							block_ctrl <= ITERATION_BLOCK4;					
						
						// 80-words expansion control
						if(iteration_loops < 32'd80)
						begin
							W[iteration_loops] <= w_new;
						end
						
						// 80 rounds compuatation control
						if(state_counter == ITERATIONS)
							begin
								state_counter <= 'd0;
								start_calc <= 1'b0;
								state <= _DONE;
							end
						else
							begin
								state_counter <= state_counter + 1'b1;
								iteration_loops <= iteration_loops + 1;
								state <= _PROC;
							end
						end
	
			_DONE	:	
						begin
						state_counter <= 'd0;
						state <= _IDLE;
						end
			default	:	
						begin
						state_counter <= 'd0;
						state <= _RESET;
						end
			endcase
		end
	
	// Detecting end of a round of state machine
	assign done = (state == _DONE)? 1'b1 : 1'b0;
	
	// 4-blocks of SHA-1 calculation
	always_comb
		case(block_ctrl)
			2'b00: 	iteration_calc = (memory_in[1] & memory_in[2]) ^ ((~(memory_in[1])) & memory_in[3]);
			2'b01: 	iteration_calc = (memory_in[1] ^ memory_in[2]) ^ memory_in[3];
			2'b10: 	iteration_calc = (memory_in[1] & memory_in[2]) ^ (memory_in[1] & memory_in[3]) ^ (memory_in[2] & memory_in[3]);
			2'b11: 	iteration_calc = (memory_in[1] ^ memory_in[2]) ^ memory_in[3];
			default:
					iteration_calc = 32'h00000000;
		endcase
	
	// Selection of K constant for each block of SHA-1 calculation
	always_comb 
	begin
			case(block_ctrl)
				2'b00: k_constant = 32'h5A827999;
				2'b01: k_constant = 32'h6ED9EBA1;
				2'b10: k_constant = 32'h8F1BBCDC;
				2'b11: k_constant = 32'hCA62C1D6;
			default:
				k_constant = 32'h00000000;
		endcase
	end
	
	// Assignments and calculations at any block of SHA1 Engine
	assign c_shift = (start_calc)? circular_shift(memory_in[0],32'd5) : 32'd0;
	assign c_intermediate = (start_calc)? circular_shift(memory_in[1], 32'd30) : 32'd0;
	assign a_intermediate = (start_calc)? memory_in[4] + iteration_calc + circular_shift(memory_in[0],32'd5) + W[state_counter] + k_constant : 32'd0;
	// intermediate hash at each round of 80-rounds of SHA-1 Engine
	assign memory_out[4] = 	(start_calc)? memory_in[3] : 
									//(done == 1'b1)? memory_out[4] :
									(state == _IDLE)? hash_registers[4]  : 32'd0;
									
	assign memory_out[3] = 	(start_calc)? memory_in[2] : 
									//(done == 1'b1)? memory_out[3] :
									(state == _IDLE)? hash_registers[3] 	: 32'd0;
									
	assign memory_out[2] = 	(start_calc)?  (c_intermediate) : 
									//(done == 1'b1)? memory_out[2] :
									(state == _IDLE)? hash_registers[2] : 32'd0;
									
	assign memory_out[1] = 	(start_calc)? memory_in[0] : 
									//(done == 1'b1)? memory_out[1] :
									(state == _IDLE)? hash_registers[1] 	: 32'd0;									
									
	assign memory_out[0] = 	(start_calc)? (a_intermediate)  : 
									//(done == 1'b1)? memory_out[0] :
									(state == _IDLE)? hash_registers[0] : 32'd0;
	
	// Final hash calculation
	always_ff@(posedge clk)
	begin
	if(state_counter == ITERATIONS)
	begin 
		message_digest[0] <= memory_out[0] + hash_registers[0];
		message_digest[1] <= memory_out[1] + hash_registers[1];
		message_digest[2] <= memory_out[2] + hash_registers[2];
		message_digest[3] <= memory_out[3] + hash_registers[3];
		message_digest[4] <= memory_out[4] + hash_registers[4];
	end
	else if(done)
	begin 
		message_digest[0] <= message_digest[0];
		message_digest[1] <= message_digest[1];
		message_digest[2] <= message_digest[2];
		message_digest[3] <= message_digest[3];
		message_digest[4] <= message_digest[4];
	end
	end

	// Reading into the custom build register set of SHA-1 Engine
	always_comb
		begin
			case({read, address[2:0]})
				4'b1000: readdata = control_register;
				4'b1001: readdata = status_register;
				4'b1010: readdata = message_digest[0];
				4'b1011: readdata = message_digest[1];
				4'b1100: readdata = message_digest[2];
				4'b1101: readdata = message_digest[3];
				4'b1110: readdata = message_digest[4];
			default: readdata = 32'd0;
			endcase
		end
	
endmodule

