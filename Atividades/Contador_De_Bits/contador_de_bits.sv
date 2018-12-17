module contador_de_bits
(
	input	clk, valid_in, reset,
	input reg[7:0] data_in,
	output read_in,
	output reg [2:0] data_out,
	output [1:0] estados
);
	
	typedef enum reg [1:0] {IDLE, DATA_IN, COUNT} states;
	states state;
	assign estados = state;
	
	reg [7:0] temp_data_in;
	reg [2:0] temp_data_out;
	reg [3:0] contador;
	reg bit_para_contagem;
	
	always @ (posedge clk or posedge reset) 
	begin
		if (reset)
			state <= IDLE;
		else
			case (state)
				IDLE:
					begin
						read_in <= 1'b1;
						contador <= 3'b000;
						temp_data_out <= 2'b00;
						state <= DATA_IN;
					end
				DATA_IN:
					if (valid_in)
						begin
							temp_data_in <= data_in;
							state <= COUNT;
						end
					else
						state <= DATA_IN;
				COUNT:
					if (contador < 3'b111)
						begin
							if (read_in == 1'b1)
								begin
									read_in <= 1'b0;
									bit_para_contagem <= temp_data_in[7];
								end
							else 
								begin
									if (temp_data_in[contador] == bit_para_contagem)
										temp_data_out <= temp_data_out + 1;
									else
										temp_data_out <= temp_data_out;
									contador <= contador + 1;
								end
							state <= COUNT;
						end
					else
						begin
							data_out <= temp_data_out;
							state <= IDLE;
						end
			endcase
	end
endmodule 