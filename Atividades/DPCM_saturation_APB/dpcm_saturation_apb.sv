module dpcm_saturation_apb(
	input PCLK, PRESETn, PWRITE,
	input PSELx, PENABLE,
	input reg [31:0] PADDR, 
	input reg signed [31:0] PWDATA,
	output PREADY, PSLVERR,
	output reg signed [31:0] PRDATA,
	output [1:0] estados,
	output int contador
);
	
	reg PREADY_saturation;
	reg PSLVERR_saturation;
	
//	reg signed [31:0] fila_entradas [31:0];
	reg signed [31:0] entrada_anterior;
	
	saturation s(PCLK, PRESETn, PWRITE, PSELx, PENABLE, PADDR,
					PWDATA - entrada_anterior,
					PREADY_saturation, PSLVERR_saturation, PRDATA);
		

	typedef enum reg [1:0] {IDLE, SETUP, ACCESS} states;
	states state;
	assign estados = state;
	
	always @ (posedge PCLK or posedge PRESETn) 
	begin
		if (PRESETn)
			begin				
				contador = 1;
				//fila_entradas[1] <= 0;
				//fila_entradas[0] <= 0;
				entrada_anterior <= 0;
				PSLVERR <= 0;
				PREADY <= 1;
				state <= IDLE;
			end
		else
			case (state)
				IDLE:
					if (PSELx)
						state <= SETUP;
					else 
						state <= IDLE;	
				SETUP:
					state <= ACCESS;	
				ACCESS:
					if (PREADY & !PENABLE)
						state <= IDLE;
					else
						begin
							PREADY <= 0;
							if (PWRITE)
								begin
									PSLVERR <= 1;
									if (contador < 31)							
										entrada_anterior <= PWDATA; //fila_entradas[contador] <= PWDATA;									
									else;
//										begin								
//											contador = 0;
//											fila_entradas[0] <= fila_entradas[31];
//										end
									contador++;
									PSLVERR <= 0;
								end
							else;
							PREADY <= 1;
							if (PREADY == 0) 
								state <= ACCESS;
							else 
								state <= SETUP;
							PSLVERR <= PSLVERR | PSLVERR_saturation;

						end					
			endcase
	end


//	int fila_entradas[$];
//
//	reg signed [31:0] entrada_anterior;
//	
//	saturation s(PCLK, PRESETn, PWRITE, PSELx, PENABLE, PADDR,
//					PWDATA - entrada_anterior, PREADY, PSLVERR, PRDATA);
//	
//	always @ (posedge clk or posedge reset) 
//	if (reset)
//		begin
//			PSLVERR <= 0;
//			PREADY <= 1;
//			entrada_anterior <= 0;
//		end
//	else 
//		PREADY <= 0;
//		if (PWRITE)
//			begin
//				PSLVERR <= 1;
//				fila_entradas.push_back(PWDATA);
//				entrada_anterior = PWDATA;
//				fila_saidas.push_back(saida);
//				PSLVERR <= 0;
//			end
//		else;
//		PREADY <= 1;

endmodule 