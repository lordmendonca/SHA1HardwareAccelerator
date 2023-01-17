	component SHA1_Base is
		port (
			clk_clk         : in  std_logic                    := 'X';             -- clk
			d_pb_export     : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			q_leds_export   : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n   : in  std_logic                    := 'X';             -- reset_n
			to_pulse_export : out std_logic                                        -- export
		);
	end component SHA1_Base;

	u0 : component SHA1_Base
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			d_pb_export     => CONNECTED_TO_d_pb_export,     --     d_pb.export
			q_leds_export   => CONNECTED_TO_q_leds_export,   --   q_leds.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --    reset.reset_n
			to_pulse_export => CONNECTED_TO_to_pulse_export  -- to_pulse.export
		);

