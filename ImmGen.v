module ImmGen (
    input [11:0] imediato, // Corrigido para 'imediato'
    output reg [31:0] imm_estendido
);
    always @(*) begin
        imm_estendido = {{20{imediato[11]}}, imediato}; // Extensão de sinal
    end
endmodule
