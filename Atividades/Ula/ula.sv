module ula(clk, rst_n, sel, a, b, s);
	input [3:0] a, b;
	input clk, rst_n;
	input [1:0] sel;
	output reg[4:0] s;
	
	always @(posedge clk)
	begin
		if (!rst_n)
			s <= 0;
		else
			case (sel)
				2'b00 : s <= a + b;
				2'b01 : s <= a - b;
				2'b10 : s <= a << 1;
				2'b11 : s <= a >> 1;
				default : s = 0;
			endcase 
	end
endmodule 