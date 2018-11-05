module somador(a, b, rst_n, clk, sel, s);

input [3:0] a, b;
input rst_n, clk, sel;
output reg [4:0] s;

always @(posedge clk)
begin
	if(!rst_n)
		s = 0;
	else
		if (sel)
			s = a + b;
		else
			s = a - b;

end

endmodule