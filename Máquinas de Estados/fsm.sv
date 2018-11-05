// Safe state machine

module fsm
(
	input	clk, data_in, reset,
	output reg [1:0] data_out
);

	// Declare the state register to be "safe" to implement
	// a safe state machine that can recover gracefully from
	// an illegal state (by returning to the reset state).
	(* syn_encoding = "safe" *) reg [1:0] state;
	
	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	
	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					begin
						data_out <= 2'b01;
						state <= S1;
					end
				S1:
					begin
						data_out <= 2'b10;
						if (data_in)
							state <= S2;
						else
							state <= S1;
					end
				S2:
					begin
						data_out = 2'b11;
						if (data_in)
							state <= S3;
						else
							state <= S1;
					end
				S3:
					begin
						data_out = 2'b00;
						if (data_in)
							state <= S2;
						else
							state <= S3;
					end
				default:
					data_out = 2'b00;
					
			endcase
	end

endmodule