/*ALUop:
00 - para acesso a memoria
01 - bne
10 - para tipo R
11 - ANDI

ALU Control
0000 - AND
0001 - OR
0010 - SOMA
0110 - SUBTRACAO
*/

module ALU_controle (
    input wire clk, // Clock
    input wire [1:0] ALUop, // Opcode da instrucao
    input wire [2:0] funct3, // Campo funct3 (3 bits)
    output reg [3:0] operacao_selecionada // Operacao que a ALU vai realizar
);

always @(posedge clk) begin //Verificar se e negedge 
    case (ALUop)
        3'b00: operacao_selecionada = 4'b0010; // lh e sh
        3'b01: operacao_selecionada = 4'b0110; // bne
        3'b10: begin
            if (funct3 == 3'b110) begin
                operacao_selecionada = 4'b0001; // or
            end else begin
                operacao_selecionada = 4'b0010; // add e sll
            end
        end
        3'b11: operacao_selecionada = 4'b0000; // andi
        default: operacao_selecionada = 4'bxxxx; // Valor desconhecido
    endcase
end

endmodule

