module saturation(
	input PCLK, PRESETn, PWRITE,
	input PSELx, PENABLE,
	input reg [31:0] PADDR, 
	input reg signed [32:0] PWDATA, 
	output PREADY, PSLVERR,
	output reg signed [31:0] PRDATA
);


	reg signed [7:0] LIMIAR_SUP = 120;
	reg signed [7:0] LIMIAR_INF = -120;
	
	int contador_inserir;
	
	int contador_retirar;
	
	reg signed [31:0] fila_saidas [31:0];

	typedef enum reg [1:0] {IDLE, SETUP, ACCESS} states;
		states state;
		assign estados = state;
		
		always @ (posedge PCLK or posedge PRESETn) 
		begin
			if (PRESETn)
				begin					
					for (int i = 0; i < 31; i = i + 1) 
						begin
							fila_saidas[i] <= 0; //reset array
						end
					contador_inserir = 0;
					contador_retirar = 0;
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
										if (contador_inserir < 31)
											if (PWDATA > LIMIAR_SUP)											
												fila_saidas[contador_inserir] <= LIMIAR_SUP;
											else if (PWDATA < LIMIAR_INF)
												fila_saidas[contador_inserir] <= LIMIAR_INF;
											else 
												fila_saidas[contador_inserir] <= PWDATA;	
										else
											contador_inserir = -1;
										PSLVERR <= 0;
										contador_inserir++;
									end
								else 
									begin
										PSLVERR <= 1;
										if (contador_retirar < 31)											
											if (contador_inserir >= contador_retirar)	
												begin
													PRDATA <= fila_saidas[contador_retirar];
													contador_retirar++;
												end
											else
												PRDATA <= fila_saidas[contador_retirar];
										else
											contador_retirar <= -1;
										PSLVERR <= 0;
									end
								PREADY <= 1;
								if (PREADY == 0) 
									state <= ACCESS;
								else 
									state <= SETUP;	
							end
					endcase
				end
//
//	reg signed [7:0] LIMIAR_SUP = 120;
//	reg signed [7:0] LIMIAR_INF = -120;
//	
//	int fila_saidas[$];
//	
//	always @ (posedge clk or posedge reset) 
//	begin
//		if (reset)
//			begin 
//				PRDATA <= 0;
//				PSLVERR <= 0;
//				PREADY <= 1;
//			end
//		else
//			PREADY <= 0;
//				if (PWRITE)
//					begin
//						if (PWDATA > LIMIAR_SUP)
//							begin
//								PSLVERR <= 1;
//								fila_saidas.push_back(LIMIAR_SUP);
//								PSLVERR <= 0;
//							end
//						else if (PWDATA < LIMIAR_INF)
//							begin
//								PSLVERR <= 1;
//								fila_saidas.push_back(LIMIAR_INF);
//								PSLVERR <= 0;
//							end
//						else 
//							begin
//								PSLVERR <= 1;
//								fila_saidas.push_back(PWDATA);
//								PSLVERR <= 0;
//							end
//					end
//				else 
//					begin
//						PSLVERR <= 1;
//						PRDATA <= fila_saidas.pop_front(PWDATA);
//						PSLVERR <= 0;
//					end
//			PREADY <= 1;
//	end	
endmodule 