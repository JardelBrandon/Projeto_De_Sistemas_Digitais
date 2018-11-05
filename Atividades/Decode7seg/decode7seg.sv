module decode7seg (input [3:0] entrada,
	output reg [6:0] saida);
	always @ (entrada)
	begin
		case (entrada)
			4'd0: saida= 7'h01;
			4'd1: saida= 7'h4f;
			4'd2: saida= 7'h12;
			4'd3: saida= 7'h06;
			4'd4: saida= 7'h4c;
			4'd5: saida= 7'h24;
			4'd6: saida= 7'h20;
			4'd7: saida= 7'h0f;
			4'd8: saida= 7'h00;
			4'd9: saida= 7'h0c;
			4'd10: saida= 7'h08;
			4'd11: saida= 7'h60;
			4'd12: saida= 7'h31;
			4'd13: saida= 7'h42;
			4'd14: saida= 7'h30;
			4'd15: saida= 7'h38;
			default: saida = 7'b1111111;
		endcase
	end
endmodule
