// SHA1_Base.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module SHA1_Base (
		input  wire       clk_clk,         //      clk.clk
		input  wire [1:0] d_pb_export,     //     d_pb.export
		output wire [7:0] q_leds_export,   //   q_leds.export
		input  wire       reset_reset_n,   //    reset.reset_n
		output wire       to_pulse_export  // to_pulse.export
	);

	wire  [31:0] nios2_cpu_data_master_readdata;                                 // mm_interconnect_0:nios2_cpu_data_master_readdata -> nios2_cpu:d_readdata
	wire         nios2_cpu_data_master_waitrequest;                              // mm_interconnect_0:nios2_cpu_data_master_waitrequest -> nios2_cpu:d_waitrequest
	wire         nios2_cpu_data_master_debugaccess;                              // nios2_cpu:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:nios2_cpu_data_master_debugaccess
	wire  [15:0] nios2_cpu_data_master_address;                                  // nios2_cpu:d_address -> mm_interconnect_0:nios2_cpu_data_master_address
	wire   [3:0] nios2_cpu_data_master_byteenable;                               // nios2_cpu:d_byteenable -> mm_interconnect_0:nios2_cpu_data_master_byteenable
	wire         nios2_cpu_data_master_read;                                     // nios2_cpu:d_read -> mm_interconnect_0:nios2_cpu_data_master_read
	wire         nios2_cpu_data_master_readdatavalid;                            // mm_interconnect_0:nios2_cpu_data_master_readdatavalid -> nios2_cpu:d_readdatavalid
	wire         nios2_cpu_data_master_write;                                    // nios2_cpu:d_write -> mm_interconnect_0:nios2_cpu_data_master_write
	wire  [31:0] nios2_cpu_data_master_writedata;                                // nios2_cpu:d_writedata -> mm_interconnect_0:nios2_cpu_data_master_writedata
	wire  [31:0] nios2_cpu_instruction_master_readdata;                          // mm_interconnect_0:nios2_cpu_instruction_master_readdata -> nios2_cpu:i_readdata
	wire         nios2_cpu_instruction_master_waitrequest;                       // mm_interconnect_0:nios2_cpu_instruction_master_waitrequest -> nios2_cpu:i_waitrequest
	wire  [15:0] nios2_cpu_instruction_master_address;                           // nios2_cpu:i_address -> mm_interconnect_0:nios2_cpu_instruction_master_address
	wire         nios2_cpu_instruction_master_read;                              // nios2_cpu:i_read -> mm_interconnect_0:nios2_cpu_instruction_master_read
	wire         nios2_cpu_instruction_master_readdatavalid;                     // mm_interconnect_0:nios2_cpu_instruction_master_readdatavalid -> nios2_cpu:i_readdatavalid
	wire         mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_chipselect;  // mm_interconnect_0:jtag_uart_core_avalon_jtag_slave_chipselect -> jtag_uart_core:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_readdata;    // jtag_uart_core:av_readdata -> mm_interconnect_0:jtag_uart_core_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_waitrequest; // jtag_uart_core:av_waitrequest -> mm_interconnect_0:jtag_uart_core_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_address;     // mm_interconnect_0:jtag_uart_core_avalon_jtag_slave_address -> jtag_uart_core:av_address
	wire         mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_read;        // mm_interconnect_0:jtag_uart_core_avalon_jtag_slave_read -> jtag_uart_core:av_read_n
	wire         mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_write;       // mm_interconnect_0:jtag_uart_core_avalon_jtag_slave_write -> jtag_uart_core:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_writedata;   // mm_interconnect_0:jtag_uart_core_avalon_jtag_slave_writedata -> jtag_uart_core:av_writedata
	wire  [31:0] mm_interconnect_0_sha1_engine_0_avalon_slave_0_readdata;        // sha1_engine_0:readdata -> mm_interconnect_0:sha1_engine_0_avalon_slave_0_readdata
	wire   [5:0] mm_interconnect_0_sha1_engine_0_avalon_slave_0_address;         // mm_interconnect_0:sha1_engine_0_avalon_slave_0_address -> sha1_engine_0:address
	wire         mm_interconnect_0_sha1_engine_0_avalon_slave_0_read;            // mm_interconnect_0:sha1_engine_0_avalon_slave_0_read -> sha1_engine_0:read
	wire         mm_interconnect_0_sha1_engine_0_avalon_slave_0_write;           // mm_interconnect_0:sha1_engine_0_avalon_slave_0_write -> sha1_engine_0:write
	wire  [31:0] mm_interconnect_0_sha1_engine_0_avalon_slave_0_writedata;       // mm_interconnect_0:sha1_engine_0_avalon_slave_0_writedata -> sha1_engine_0:writedata
	wire  [31:0] mm_interconnect_0_nios2_cpu_debug_mem_slave_readdata;           // nios2_cpu:debug_mem_slave_readdata -> mm_interconnect_0:nios2_cpu_debug_mem_slave_readdata
	wire         mm_interconnect_0_nios2_cpu_debug_mem_slave_waitrequest;        // nios2_cpu:debug_mem_slave_waitrequest -> mm_interconnect_0:nios2_cpu_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_nios2_cpu_debug_mem_slave_debugaccess;        // mm_interconnect_0:nios2_cpu_debug_mem_slave_debugaccess -> nios2_cpu:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_nios2_cpu_debug_mem_slave_address;            // mm_interconnect_0:nios2_cpu_debug_mem_slave_address -> nios2_cpu:debug_mem_slave_address
	wire         mm_interconnect_0_nios2_cpu_debug_mem_slave_read;               // mm_interconnect_0:nios2_cpu_debug_mem_slave_read -> nios2_cpu:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_nios2_cpu_debug_mem_slave_byteenable;         // mm_interconnect_0:nios2_cpu_debug_mem_slave_byteenable -> nios2_cpu:debug_mem_slave_byteenable
	wire         mm_interconnect_0_nios2_cpu_debug_mem_slave_write;              // mm_interconnect_0:nios2_cpu_debug_mem_slave_write -> nios2_cpu:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_nios2_cpu_debug_mem_slave_writedata;          // mm_interconnect_0:nios2_cpu_debug_mem_slave_writedata -> nios2_cpu:debug_mem_slave_writedata
	wire         mm_interconnect_0_timer_core_s1_chipselect;                     // mm_interconnect_0:timer_core_s1_chipselect -> timer_core:chipselect
	wire  [15:0] mm_interconnect_0_timer_core_s1_readdata;                       // timer_core:readdata -> mm_interconnect_0:timer_core_s1_readdata
	wire   [2:0] mm_interconnect_0_timer_core_s1_address;                        // mm_interconnect_0:timer_core_s1_address -> timer_core:address
	wire         mm_interconnect_0_timer_core_s1_write;                          // mm_interconnect_0:timer_core_s1_write -> timer_core:write_n
	wire  [15:0] mm_interconnect_0_timer_core_s1_writedata;                      // mm_interconnect_0:timer_core_s1_writedata -> timer_core:writedata
	wire         mm_interconnect_0_onchip_mem_s1_chipselect;                     // mm_interconnect_0:onchip_mem_s1_chipselect -> onchip_mem:chipselect
	wire  [31:0] mm_interconnect_0_onchip_mem_s1_readdata;                       // onchip_mem:readdata -> mm_interconnect_0:onchip_mem_s1_readdata
	wire  [12:0] mm_interconnect_0_onchip_mem_s1_address;                        // mm_interconnect_0:onchip_mem_s1_address -> onchip_mem:address
	wire   [3:0] mm_interconnect_0_onchip_mem_s1_byteenable;                     // mm_interconnect_0:onchip_mem_s1_byteenable -> onchip_mem:byteenable
	wire         mm_interconnect_0_onchip_mem_s1_write;                          // mm_interconnect_0:onchip_mem_s1_write -> onchip_mem:write
	wire  [31:0] mm_interconnect_0_onchip_mem_s1_writedata;                      // mm_interconnect_0:onchip_mem_s1_writedata -> onchip_mem:writedata
	wire         mm_interconnect_0_onchip_mem_s1_clken;                          // mm_interconnect_0:onchip_mem_s1_clken -> onchip_mem:clken
	wire         mm_interconnect_0_pio_leds_s1_chipselect;                       // mm_interconnect_0:pio_leds_s1_chipselect -> pio_leds:chipselect
	wire  [31:0] mm_interconnect_0_pio_leds_s1_readdata;                         // pio_leds:readdata -> mm_interconnect_0:pio_leds_s1_readdata
	wire   [1:0] mm_interconnect_0_pio_leds_s1_address;                          // mm_interconnect_0:pio_leds_s1_address -> pio_leds:address
	wire         mm_interconnect_0_pio_leds_s1_write;                            // mm_interconnect_0:pio_leds_s1_write -> pio_leds:write_n
	wire  [31:0] mm_interconnect_0_pio_leds_s1_writedata;                        // mm_interconnect_0:pio_leds_s1_writedata -> pio_leds:writedata
	wire         mm_interconnect_0_pio_pushbuttons_s1_chipselect;                // mm_interconnect_0:pio_pushbuttons_s1_chipselect -> pio_pushbuttons:chipselect
	wire  [31:0] mm_interconnect_0_pio_pushbuttons_s1_readdata;                  // pio_pushbuttons:readdata -> mm_interconnect_0:pio_pushbuttons_s1_readdata
	wire   [1:0] mm_interconnect_0_pio_pushbuttons_s1_address;                   // mm_interconnect_0:pio_pushbuttons_s1_address -> pio_pushbuttons:address
	wire         mm_interconnect_0_pio_pushbuttons_s1_write;                     // mm_interconnect_0:pio_pushbuttons_s1_write -> pio_pushbuttons:write_n
	wire  [31:0] mm_interconnect_0_pio_pushbuttons_s1_writedata;                 // mm_interconnect_0:pio_pushbuttons_s1_writedata -> pio_pushbuttons:writedata
	wire         mm_interconnect_0_onchip_mem_s2_chipselect;                     // mm_interconnect_0:onchip_mem_s2_chipselect -> onchip_mem:chipselect2
	wire  [31:0] mm_interconnect_0_onchip_mem_s2_readdata;                       // onchip_mem:readdata2 -> mm_interconnect_0:onchip_mem_s2_readdata
	wire  [12:0] mm_interconnect_0_onchip_mem_s2_address;                        // mm_interconnect_0:onchip_mem_s2_address -> onchip_mem:address2
	wire   [3:0] mm_interconnect_0_onchip_mem_s2_byteenable;                     // mm_interconnect_0:onchip_mem_s2_byteenable -> onchip_mem:byteenable2
	wire         mm_interconnect_0_onchip_mem_s2_write;                          // mm_interconnect_0:onchip_mem_s2_write -> onchip_mem:write2
	wire  [31:0] mm_interconnect_0_onchip_mem_s2_writedata;                      // mm_interconnect_0:onchip_mem_s2_writedata -> onchip_mem:writedata2
	wire         mm_interconnect_0_onchip_mem_s2_clken;                          // mm_interconnect_0:onchip_mem_s2_clken -> onchip_mem:clken2
	wire         irq_mapper_receiver0_irq;                                       // timer_core:irq -> irq_mapper:receiver0_irq
	wire         irq_mapper_receiver1_irq;                                       // pio_pushbuttons:irq -> irq_mapper:receiver1_irq
	wire         irq_mapper_receiver2_irq;                                       // jtag_uart_core:av_irq -> irq_mapper:receiver2_irq
	wire  [31:0] nios2_cpu_irq_irq;                                              // irq_mapper:sender_irq -> nios2_cpu:irq
	wire         rst_controller_reset_out_reset;                                 // rst_controller:reset_out -> [irq_mapper:reset, jtag_uart_core:rst_n, mm_interconnect_0:nios2_cpu_reset_reset_bridge_in_reset_reset, nios2_cpu:reset_n, onchip_mem:reset, onchip_mem:reset2, pio_leds:reset_n, pio_pushbuttons:reset_n, rst_translator:in_reset, sha1_engine_0:reset_n, timer_core:reset_n]
	wire         rst_controller_reset_out_reset_req;                             // rst_controller:reset_req -> [nios2_cpu:reset_req, onchip_mem:reset_req, onchip_mem:reset_req2, rst_translator:reset_req_in]

	SHA1_Base_jtag_uart_core jtag_uart_core (
		.clk            (clk_clk),                                                        //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                                //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver2_irq)                                        //               irq.irq
	);

	SHA1_Base_nios2_cpu nios2_cpu (
		.clk                                 (clk_clk),                                                 //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                         //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                      //                          .reset_req
		.d_address                           (nios2_cpu_data_master_address),                           //               data_master.address
		.d_byteenable                        (nios2_cpu_data_master_byteenable),                        //                          .byteenable
		.d_read                              (nios2_cpu_data_master_read),                              //                          .read
		.d_readdata                          (nios2_cpu_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (nios2_cpu_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (nios2_cpu_data_master_write),                             //                          .write
		.d_writedata                         (nios2_cpu_data_master_writedata),                         //                          .writedata
		.d_readdatavalid                     (nios2_cpu_data_master_readdatavalid),                     //                          .readdatavalid
		.debug_mem_slave_debugaccess_to_roms (nios2_cpu_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (nios2_cpu_instruction_master_address),                    //        instruction_master.address
		.i_read                              (nios2_cpu_instruction_master_read),                       //                          .read
		.i_readdata                          (nios2_cpu_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (nios2_cpu_instruction_master_waitrequest),                //                          .waitrequest
		.i_readdatavalid                     (nios2_cpu_instruction_master_readdatavalid),              //                          .readdatavalid
		.irq                                 (nios2_cpu_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (),                                                        //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_nios2_cpu_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_nios2_cpu_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_nios2_cpu_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_nios2_cpu_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_nios2_cpu_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_nios2_cpu_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_nios2_cpu_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_nios2_cpu_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                         // custom_instruction_master.readra
	);

	SHA1_Base_onchip_mem onchip_mem (
		.clk         (clk_clk),                                    //   clk1.clk
		.address     (mm_interconnect_0_onchip_mem_s1_address),    //     s1.address
		.clken       (mm_interconnect_0_onchip_mem_s1_clken),      //       .clken
		.chipselect  (mm_interconnect_0_onchip_mem_s1_chipselect), //       .chipselect
		.write       (mm_interconnect_0_onchip_mem_s1_write),      //       .write
		.readdata    (mm_interconnect_0_onchip_mem_s1_readdata),   //       .readdata
		.writedata   (mm_interconnect_0_onchip_mem_s1_writedata),  //       .writedata
		.byteenable  (mm_interconnect_0_onchip_mem_s1_byteenable), //       .byteenable
		.reset       (rst_controller_reset_out_reset),             // reset1.reset
		.reset_req   (rst_controller_reset_out_reset_req),         //       .reset_req
		.address2    (mm_interconnect_0_onchip_mem_s2_address),    //     s2.address
		.chipselect2 (mm_interconnect_0_onchip_mem_s2_chipselect), //       .chipselect
		.clken2      (mm_interconnect_0_onchip_mem_s2_clken),      //       .clken
		.write2      (mm_interconnect_0_onchip_mem_s2_write),      //       .write
		.readdata2   (mm_interconnect_0_onchip_mem_s2_readdata),   //       .readdata
		.writedata2  (mm_interconnect_0_onchip_mem_s2_writedata),  //       .writedata
		.byteenable2 (mm_interconnect_0_onchip_mem_s2_byteenable), //       .byteenable
		.clk2        (clk_clk),                                    //   clk2.clk
		.reset2      (rst_controller_reset_out_reset),             // reset2.reset
		.reset_req2  (rst_controller_reset_out_reset_req),         //       .reset_req
		.freeze      (1'b0)                                        // (terminated)
	);

	SHA1_Base_pio_leds pio_leds (
		.clk        (clk_clk),                                  //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),          //               reset.reset_n
		.address    (mm_interconnect_0_pio_leds_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_pio_leds_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_pio_leds_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_pio_leds_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_pio_leds_s1_readdata),   //                    .readdata
		.out_port   (q_leds_export)                             // external_connection.export
	);

	SHA1_Base_pio_pushbuttons pio_pushbuttons (
		.clk        (clk_clk),                                         //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                 //               reset.reset_n
		.address    (mm_interconnect_0_pio_pushbuttons_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_pio_pushbuttons_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_pio_pushbuttons_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_pio_pushbuttons_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_pio_pushbuttons_s1_readdata),   //                    .readdata
		.in_port    (d_pb_export),                                     // external_connection.export
		.irq        (irq_mapper_receiver1_irq)                         //                 irq.irq
	);

	sha1_hw_computation sha1_engine_0 (
		.clk       (clk_clk),                                                  //          clock.clk
		.reset_n   (~rst_controller_reset_out_reset),                          //          reset.reset_n
		.write     (mm_interconnect_0_sha1_engine_0_avalon_slave_0_write),     // avalon_slave_0.write
		.read      (mm_interconnect_0_sha1_engine_0_avalon_slave_0_read),      //               .read
		.address   (mm_interconnect_0_sha1_engine_0_avalon_slave_0_address),   //               .address
		.writedata (mm_interconnect_0_sha1_engine_0_avalon_slave_0_writedata), //               .writedata
		.readdata  (mm_interconnect_0_sha1_engine_0_avalon_slave_0_readdata)   //               .readdata
	);

	SHA1_Base_timer_core timer_core (
		.clk           (clk_clk),                                    //           clk.clk
		.reset_n       (~rst_controller_reset_out_reset),            //         reset.reset_n
		.address       (mm_interconnect_0_timer_core_s1_address),    //            s1.address
		.writedata     (mm_interconnect_0_timer_core_s1_writedata),  //              .writedata
		.readdata      (mm_interconnect_0_timer_core_s1_readdata),   //              .readdata
		.chipselect    (mm_interconnect_0_timer_core_s1_chipselect), //              .chipselect
		.write_n       (~mm_interconnect_0_timer_core_s1_write),     //              .write_n
		.irq           (irq_mapper_receiver0_irq),                   //           irq.irq
		.timeout_pulse (to_pulse_export)                             // external_port.export
	);

	SHA1_Base_mm_interconnect_0 mm_interconnect_0 (
		.clock_bridge_clk_clk                         (clk_clk),                                                        //                      clock_bridge_clk.clk
		.nios2_cpu_reset_reset_bridge_in_reset_reset  (rst_controller_reset_out_reset),                                 // nios2_cpu_reset_reset_bridge_in_reset.reset
		.nios2_cpu_data_master_address                (nios2_cpu_data_master_address),                                  //                 nios2_cpu_data_master.address
		.nios2_cpu_data_master_waitrequest            (nios2_cpu_data_master_waitrequest),                              //                                      .waitrequest
		.nios2_cpu_data_master_byteenable             (nios2_cpu_data_master_byteenable),                               //                                      .byteenable
		.nios2_cpu_data_master_read                   (nios2_cpu_data_master_read),                                     //                                      .read
		.nios2_cpu_data_master_readdata               (nios2_cpu_data_master_readdata),                                 //                                      .readdata
		.nios2_cpu_data_master_readdatavalid          (nios2_cpu_data_master_readdatavalid),                            //                                      .readdatavalid
		.nios2_cpu_data_master_write                  (nios2_cpu_data_master_write),                                    //                                      .write
		.nios2_cpu_data_master_writedata              (nios2_cpu_data_master_writedata),                                //                                      .writedata
		.nios2_cpu_data_master_debugaccess            (nios2_cpu_data_master_debugaccess),                              //                                      .debugaccess
		.nios2_cpu_instruction_master_address         (nios2_cpu_instruction_master_address),                           //          nios2_cpu_instruction_master.address
		.nios2_cpu_instruction_master_waitrequest     (nios2_cpu_instruction_master_waitrequest),                       //                                      .waitrequest
		.nios2_cpu_instruction_master_read            (nios2_cpu_instruction_master_read),                              //                                      .read
		.nios2_cpu_instruction_master_readdata        (nios2_cpu_instruction_master_readdata),                          //                                      .readdata
		.nios2_cpu_instruction_master_readdatavalid   (nios2_cpu_instruction_master_readdatavalid),                     //                                      .readdatavalid
		.jtag_uart_core_avalon_jtag_slave_address     (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_address),     //      jtag_uart_core_avalon_jtag_slave.address
		.jtag_uart_core_avalon_jtag_slave_write       (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_write),       //                                      .write
		.jtag_uart_core_avalon_jtag_slave_read        (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_read),        //                                      .read
		.jtag_uart_core_avalon_jtag_slave_readdata    (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_readdata),    //                                      .readdata
		.jtag_uart_core_avalon_jtag_slave_writedata   (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_writedata),   //                                      .writedata
		.jtag_uart_core_avalon_jtag_slave_waitrequest (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_waitrequest), //                                      .waitrequest
		.jtag_uart_core_avalon_jtag_slave_chipselect  (mm_interconnect_0_jtag_uart_core_avalon_jtag_slave_chipselect),  //                                      .chipselect
		.nios2_cpu_debug_mem_slave_address            (mm_interconnect_0_nios2_cpu_debug_mem_slave_address),            //             nios2_cpu_debug_mem_slave.address
		.nios2_cpu_debug_mem_slave_write              (mm_interconnect_0_nios2_cpu_debug_mem_slave_write),              //                                      .write
		.nios2_cpu_debug_mem_slave_read               (mm_interconnect_0_nios2_cpu_debug_mem_slave_read),               //                                      .read
		.nios2_cpu_debug_mem_slave_readdata           (mm_interconnect_0_nios2_cpu_debug_mem_slave_readdata),           //                                      .readdata
		.nios2_cpu_debug_mem_slave_writedata          (mm_interconnect_0_nios2_cpu_debug_mem_slave_writedata),          //                                      .writedata
		.nios2_cpu_debug_mem_slave_byteenable         (mm_interconnect_0_nios2_cpu_debug_mem_slave_byteenable),         //                                      .byteenable
		.nios2_cpu_debug_mem_slave_waitrequest        (mm_interconnect_0_nios2_cpu_debug_mem_slave_waitrequest),        //                                      .waitrequest
		.nios2_cpu_debug_mem_slave_debugaccess        (mm_interconnect_0_nios2_cpu_debug_mem_slave_debugaccess),        //                                      .debugaccess
		.onchip_mem_s1_address                        (mm_interconnect_0_onchip_mem_s1_address),                        //                         onchip_mem_s1.address
		.onchip_mem_s1_write                          (mm_interconnect_0_onchip_mem_s1_write),                          //                                      .write
		.onchip_mem_s1_readdata                       (mm_interconnect_0_onchip_mem_s1_readdata),                       //                                      .readdata
		.onchip_mem_s1_writedata                      (mm_interconnect_0_onchip_mem_s1_writedata),                      //                                      .writedata
		.onchip_mem_s1_byteenable                     (mm_interconnect_0_onchip_mem_s1_byteenable),                     //                                      .byteenable
		.onchip_mem_s1_chipselect                     (mm_interconnect_0_onchip_mem_s1_chipselect),                     //                                      .chipselect
		.onchip_mem_s1_clken                          (mm_interconnect_0_onchip_mem_s1_clken),                          //                                      .clken
		.onchip_mem_s2_address                        (mm_interconnect_0_onchip_mem_s2_address),                        //                         onchip_mem_s2.address
		.onchip_mem_s2_write                          (mm_interconnect_0_onchip_mem_s2_write),                          //                                      .write
		.onchip_mem_s2_readdata                       (mm_interconnect_0_onchip_mem_s2_readdata),                       //                                      .readdata
		.onchip_mem_s2_writedata                      (mm_interconnect_0_onchip_mem_s2_writedata),                      //                                      .writedata
		.onchip_mem_s2_byteenable                     (mm_interconnect_0_onchip_mem_s2_byteenable),                     //                                      .byteenable
		.onchip_mem_s2_chipselect                     (mm_interconnect_0_onchip_mem_s2_chipselect),                     //                                      .chipselect
		.onchip_mem_s2_clken                          (mm_interconnect_0_onchip_mem_s2_clken),                          //                                      .clken
		.pio_leds_s1_address                          (mm_interconnect_0_pio_leds_s1_address),                          //                           pio_leds_s1.address
		.pio_leds_s1_write                            (mm_interconnect_0_pio_leds_s1_write),                            //                                      .write
		.pio_leds_s1_readdata                         (mm_interconnect_0_pio_leds_s1_readdata),                         //                                      .readdata
		.pio_leds_s1_writedata                        (mm_interconnect_0_pio_leds_s1_writedata),                        //                                      .writedata
		.pio_leds_s1_chipselect                       (mm_interconnect_0_pio_leds_s1_chipselect),                       //                                      .chipselect
		.pio_pushbuttons_s1_address                   (mm_interconnect_0_pio_pushbuttons_s1_address),                   //                    pio_pushbuttons_s1.address
		.pio_pushbuttons_s1_write                     (mm_interconnect_0_pio_pushbuttons_s1_write),                     //                                      .write
		.pio_pushbuttons_s1_readdata                  (mm_interconnect_0_pio_pushbuttons_s1_readdata),                  //                                      .readdata
		.pio_pushbuttons_s1_writedata                 (mm_interconnect_0_pio_pushbuttons_s1_writedata),                 //                                      .writedata
		.pio_pushbuttons_s1_chipselect                (mm_interconnect_0_pio_pushbuttons_s1_chipselect),                //                                      .chipselect
		.sha1_engine_0_avalon_slave_0_address         (mm_interconnect_0_sha1_engine_0_avalon_slave_0_address),         //          sha1_engine_0_avalon_slave_0.address
		.sha1_engine_0_avalon_slave_0_write           (mm_interconnect_0_sha1_engine_0_avalon_slave_0_write),           //                                      .write
		.sha1_engine_0_avalon_slave_0_read            (mm_interconnect_0_sha1_engine_0_avalon_slave_0_read),            //                                      .read
		.sha1_engine_0_avalon_slave_0_readdata        (mm_interconnect_0_sha1_engine_0_avalon_slave_0_readdata),        //                                      .readdata
		.sha1_engine_0_avalon_slave_0_writedata       (mm_interconnect_0_sha1_engine_0_avalon_slave_0_writedata),       //                                      .writedata
		.timer_core_s1_address                        (mm_interconnect_0_timer_core_s1_address),                        //                         timer_core_s1.address
		.timer_core_s1_write                          (mm_interconnect_0_timer_core_s1_write),                          //                                      .write
		.timer_core_s1_readdata                       (mm_interconnect_0_timer_core_s1_readdata),                       //                                      .readdata
		.timer_core_s1_writedata                      (mm_interconnect_0_timer_core_s1_writedata),                      //                                      .writedata
		.timer_core_s1_chipselect                     (mm_interconnect_0_timer_core_s1_chipselect)                      //                                      .chipselect
	);

	SHA1_Base_irq_mapper irq_mapper (
		.clk           (clk_clk),                        //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.receiver1_irq (irq_mapper_receiver1_irq),       // receiver1.irq
		.receiver2_irq (irq_mapper_receiver2_irq),       // receiver2.irq
		.sender_irq    (nios2_cpu_irq_irq)               //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (clk_clk),                            //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule