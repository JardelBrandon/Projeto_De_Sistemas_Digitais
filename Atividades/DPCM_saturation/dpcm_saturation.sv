module dpcm_saturation(
	input clk, reset,
	input reg signed [7:0] entrada,
	output reg signed [7:0] saida
);

	reg signed [7:0] entrada_anterior;
	
	saturation s(clk, reset, entrada - entrada_anterior, saida);
	
	always @ (posedge clk or posedge reset) 
	if (reset)
		begin
			entrada_anterior = 0;
		end
	else 
		if (entrada == entrada_anterior);
		else
			entrada_anterior = entrada;

endmodule 