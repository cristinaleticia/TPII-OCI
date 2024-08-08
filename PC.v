// funcoes lh, sh, add, or, andi, sll, bne
module pc_counter(
    input clock,
    input endereco_pc, //Endereco que vem do pc
    input imediato, //Sera usado para calcular desvio
    input sinal_mux; //Resultao  da porta and
    output endereco_saida //Vem do pc+4 ou pc+imm
);

reg [31:0] aux1;
reg [31:0] aux2;
initial begin
    aux1 = 32'b0;
    aux2 = 32'b0;
end
 
always @(negedge clock) begin // borda de descida = calculamos o valor do endereço
    aux1 = endereco_pc + 4;
    aux2 = endereco_pc + imediato; // PC + desvio

    if(sinal_mux == 0) begin
        endereco_saida = aux1;
    end 
    else begin
        endereco_saida = aux2;
    end
end


endmodule