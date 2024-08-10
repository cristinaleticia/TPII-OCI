module ADD (
    input [31:0] valor1,
    input [31:0] valor2,
    input [31:0] endereco_saida
); 
    assign endereco_saida = valor1 + valor2;
endmodule