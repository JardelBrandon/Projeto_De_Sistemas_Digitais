module somador_decode (a, b, s, c_in, c_out);
	input [3:0] a, b;
	input c_in;
	wire [3:0] lig;
	wire lig_c_out;
	output [6:0] s, c_out;
	
	somador_4 s0(a, b, c_in, lig, lig_c_out);
	
	decode7seg d(lig, s), d_carry(lig_c_out, c_out);
	
endmodule 