module subtrator_completo(a, b, bin, d, bout);
    input a, b, bin;
    output d, bout;
    wire sm, cm, ct;
    meio_subtrator MS1(a, b, sm, cm), MS2(sm, bin, d, ct);
    assign bout = ct | cm;
endmodule
