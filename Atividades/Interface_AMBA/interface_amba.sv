module interface_amba(
	input PCLK, PRESETn, PWRITE,
	input logic PSELx, PENABLE,
	input reg [31:0] PADDR, 
	input reg signed [31:0] PWDATA,
	output logic PREADY, PSLVERR,
	output reg signed [31:0] PRDATA,
	output [1:0] estados
)

	typedef enum reg [1:0] {IDLE, SETUP, ACCESS} states;
	states state;
	assign estados = state;
	
	always @ (posedge clk or posedge reset) 
	begin
		if (reset)
			state <= IDLE;
		else
			case (state)
				IDLE:
					begin
						PSELx = 0;
						PENABLE = 0;
					end
				SETUP:
					begin
						PSELx = 0;
						PENABLE = 0;
					end
				ACCESS:
					begin
						PSELx = 1;
						PENABLE = 1;
					end
	end

endmodule 