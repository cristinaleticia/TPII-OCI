module ImmGen (
    input [11:0] imediato, 
    output reg [31:0] imm_estendido
);
    always @(*) begin
        imm_estendido = {{20{imediato[11]}}, imediato}; // Extensao de sinal
    end
endmodule
