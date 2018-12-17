module saturation(
	input clk, reset,
	input reg signed [7:0] entrada,
	output reg signed [7:0] saida
);
	reg signed [7:0] LIMIAR_SUP = 120;
	reg signed [7:0] LIMIAR_INF = -120;
	
	always @ (posedge clk or posedge reset) 
	begin
		if (reset)
			saida <= 0;
		else
			if (entrada > LIMIAR_SUP)
				saida <= LIMIAR_SUP;
			else 
				if (entrada < LIMIAR_INF)
					saida <= LIMIAR_INF;
				else 
					saida <= entrada;
	end	
endmodule 