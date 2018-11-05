// User-encoded state machine

module encoded
(
	input	clk, data_in, reset,
	output reg [1:0] data_out,
	output [1:0] estados
);

	// Declare state register
	(* syn_encoding = "user" *) typedef enum reg [1:0] {S0, S1, S2, S3} states;
	
	// Declare states
	states state;
	assign estados = state;
	
	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:
				data_out = 2'b01;
			S1:
				data_out = 2'b10;
			S2:
				data_out = 2'b11;
			S3:
				data_out = 2'b00;
			default:
				data_out = 2'b00;
		endcase
	end
	
	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					state <= S1;
				S1:
					if (data_in)
						state <= S2;
					else
						state <= S1;
				S2:
					if (data_in)
						state <= S3;
					else
						state <= S1;
				S3:
					if (data_in)
						state <= S2;
					else
						state <= S3;
			endcase
	end

endmodule