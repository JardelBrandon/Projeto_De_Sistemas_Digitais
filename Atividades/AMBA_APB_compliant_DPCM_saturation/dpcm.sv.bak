module dpcm(
	input clk, reset,
	input reg signed [7:0] entrada,
	output reg signed [7:0] saida
);

	reg signed [7:0] entrada_anterior;
	
	always @ (posedge clk or posedge reset) 
	if (reset)
		begin
			saida = 0;
			entrada_anterior = 0;
		end
	else 
		if (entrada == entrada_anterior);
		else
			begin
				saida = entrada - entrada_anterior;
				entrada_anterior = entrada;
			end
endmodule 