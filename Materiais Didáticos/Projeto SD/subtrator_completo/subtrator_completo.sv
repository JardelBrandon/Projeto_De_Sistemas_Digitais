module subtrator_completo(a, b, bi, s, bo);
	input a, b, bi;
	output s, bo;
	logic w1, w2, w3, w4;
	
	assign w1 = a ^ b; //Primeira X0R
	assign w2 = ~a & b; //Primeira AND
	assign w3 = ~a & bi; //Segunda AND
	assign w4 = b & bi; //Terceira AND
	
	assign s = bi ^ w1;
	assign bo = w2 | w3 | w4; 

endmodule