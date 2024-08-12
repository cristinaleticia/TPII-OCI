module ImmGen (
    input [31:0] instrucao, 
    input [6:0] opcode,
    output reg [31:0] imm_estendido
);
    always @(instrucao) begin
        case(opcode)
            7'b0010011: // Tipo I: ANDI
                imm_estendido = {{20{instrucao[31]}}, instrucao[31:20]}; 
            7'b0000011:  // Tipo I: LH 
                imm_estendido = {{20{instrucao[31]}}, instrucao[31:20]}; 
            7'b0100011:  // Tipo S: SH 
                imm_estendido = {{20{instrucao[31]}}, instrucao[31:25], instrucao[11:7]}; 
            7'b1100011:  // Tipo B: BNE 
                imm_estendido = {{19{instrucao[31]}}, instrucao[7], instrucao[30:25], instrucao[11:8], 1'b0}; 
            default:     imm_estendido = 32'b0; // Valor padrao para casos desconhecidosb
            
        endcase
        
    end
endmodule
