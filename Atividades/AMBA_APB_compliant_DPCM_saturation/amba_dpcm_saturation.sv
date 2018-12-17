module amba_dpcm_saturation(
	input clk, reset,
	input reg signed [7:0] entrada,
	output reg signed [7:0] saida
);

	reg signed [7:0] ligacao_entrada;
	reg signed [7:0] ligacao_saida;
	
	dpcm d(clk, reset, ligacao_entrada, ligacao_saida);

	always @ (posedge clk or posedge reset) 
	if (reset)
		begin
			ligacao_entrada = 0;
			saida = 0;
		end
	else 
		begin 
			ligacao_entrada = entrada;
			saida = ligacao_saida;
		end
		
endmodule 