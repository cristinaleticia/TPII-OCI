module mux(
    input [31:0] valor1,
    input [31:0] valor2,
    input sinal_mux,
    output [31:0] endereco_saida
);

    // Atribuicso usando operador ternario
    assign endereco_saida = (sinal_mux == 0) ? valor1 : valor2;

endmodule
