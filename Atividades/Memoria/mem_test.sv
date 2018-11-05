module mem_test(clock, saida1, saida2,endereco);
	output [6:0] saida1;
	output [6:0] saida2;
	input [7:0] endereco;
	input clock;
	wire [7:0] fio;
	memoria	memoria_inst (
	.address ( endereco ),
	.clock ( clock ),
	.data ( 8'b00000000 ),
	.wren ( 1'b0 ),
	.q ( fio )
	);
	decode7seg dec1(fio[3:0], saida1);
	decode7seg dec2(fio[7:4], saida2);
endmodule 