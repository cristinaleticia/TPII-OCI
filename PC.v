module PC(
    input clock,
    input reset,
    input wire [31:0] endereco_pc, // Endereco que vem do PC
    input wire [31:0] imediato,    // Será usado para calcular desvio
    input wire sinal_mux,          // Resultado da porta AND
    output reg [31:0] endereco_saida // Vem do PC+4 ou PC+imm
);
reg [31:0] aux1;
reg [31:0] aux2;

always @(posedge clock) begin
    if (reset==1) begin
        endereco_saida <= 32'b0;
        // Exibição de depuração para reset
        //$display("RESET ativado: endereco_saida = %b", endereco_saida);
    end 
    else begin
        endereco_saida <= endereco_pc;
    end
    //$display("endereco pc = %b, endereco_saida = %b", endereco_pc, endereco_saida);
end

endmodule
