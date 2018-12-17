module dpcm(
	input clk, reset,
	input reg signed [7:0] entrada,
	output reg signed [7:0] saida
);

	reg signed [7:0] entrada_anterior;
	reg signed [8:0] ligacao_saida;
	
	saturation s(clk, reset, ligacao_saida, saida);
	
	always @ (posedge clk or posedge reset) 
	if (reset)
		begin
			ligacao_saida = 0;
			entrada_anterior = 0;
		end
	else 
		if (entrada == entrada_anterior);
		else
			begin
				ligacao_saida = entrada - entrada_anterior;
				entrada_anterior = entrada;
			end
endmodule 