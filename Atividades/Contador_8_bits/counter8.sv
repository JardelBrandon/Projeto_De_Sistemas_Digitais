module counter8(clk, rst_n, cont, cont2);
    input clk, rst_n;
	 output [7:0] cont;
	 reg [7:0] cont;
	 output reg [24:0] cont2;
    always@(posedge clk)
        begin
            if (!rst_n)
                begin
                    cont <= 0;
                    cont2 <= 0; // Divisor de frequencia
                end
            else
                begin
                    // Conta 50 milhoes antes de incrementar
                    if (cont2 == 25'd50000000)
                        begin
                            cont <= cont + 1;
                            cont2 <= 0;
                        end
                    else
                        cont2 <= cont2 + 1;
                end
        end
endmodule
