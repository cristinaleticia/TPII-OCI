module mux(
    input [31:0] pcm4,
    input [31:0] imediato,
    input sinal_mux,
    output [31:0] endereco_saida
);

    // Atribuição contínua usando operador ternário
    assign endereco_saida = (sinal_mux == 0) ? pcm4 : imediato;

endmodule
