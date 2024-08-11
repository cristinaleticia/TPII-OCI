/*ALUop:
00 - para acesso a memoria
01 - bne
10 - para tipo R
11 - ANDI

ALU Control
0000 - AND
0001 - OR
0010 - SOMA
0011 - DESLOCAMENTO
0110 - SUBTRACAO
*/

module ALUControl (
    input wire [1:0] ALUop, // Opcode da instrucao
    input wire [2:0] funct3, // Campo funct3 (3 bits)
    output reg [3:0] operacao_selecionada // Operacao que a ALU vai realizar
);

always @(*) begin 
    case (ALUop)
        2'b00: operacao_selecionada = 4'b0010; // lh e sh (SOMA)
        2'b01: operacao_selecionada = 4'b0110; // bne (SUBTRACAO)
        2'b10: begin
            case(funct3)
                3'b110:operacao_selecionada = 4'b0001; // or (OR)
                3'b000:operacao_selecionada = 4'b0010; //add (SOMA)
                3'b001:operacao_selecionada = 4'b0011; //sll (DESLOCAMENTO)
            endcase
        end
        2'b11: operacao_selecionada = 4'b0000; // andi (AND)
        default: operacao_selecionada = 4'b1111; // Valor desconhecido
    endcase
end

endmodule
