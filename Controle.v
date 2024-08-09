module Controle (
    input wire [6:0] opcode,          // Opcode da instrução
    input wire [6:0] funct7,          // Campo funct7 da instrução
    input wire [2:0] funct3,          // Campo funct3 da instrução
    output reg [1:0] ALUop,           // Sinal de controle da ALU
    output reg sinal_leitura,         // Sinal de leitura da memória
    output reg sinal_escrita,         // Sinal de escrita na memória
    output reg reg_escrita,           // Sinal de escrita no registrador
    output reg ALUSrc,                // Se a fonte da ALU é imediato
    output reg resultado_desvio,      // Se a instrução é um desvio
    output reg MemToReg                // Se os dados devem ser lidos da memória
);

    always @(*) begin //always @(opcode) begin
        case (opcode)
            7'b0000011: begin // Load (lh)
                ALUop = 2'b00;   // Acesso à memória
                sinal_leitura = 1;
                sinal_escrita = 0;
                reg_escrita = 1;
                ALUSrc = 1;
                resultado_desvio = 0;
                MemToReg = 1;
            end
            7'b0100011: begin // Store (sh)
                ALUop = 2'b00;   // Acesso à memória
                sinal_leitura = 0;
                sinal_escrita = 1;
                reg_escrita = 0;
                ALUSrc = 1;
                resultado_desvio = 0;
                MemToReg = 0;
            end
            7'b0110011: begin // Tipo R
                ALUop = 2'b10;   // Tipo R
                sinal_leitura = 0;
                sinal_escrita = 0;
                reg_escrita = 1;
                ALUSrc = 0;
                resultado_desvio = 0;
                MemToReg = 0;
            end
            7'b0010011: begin // Tipo I (andi, sll)
                case (funct3)
                    3'b111: ALUop = 2'b11; // ANDI
                    3'b001: ALUop = 2'b10; // SLL
                    default: ALUop = 2'b00;
                endcase
                sinal_leitura = 0;
                sinal_escrita = 0;
                reg_escrita = 1;
                ALUSrc = 1;
                resultado_desvio = 0;
                MemToReg = 0;
            end
            7'b1100011: begin // Resultado de desvio (bne)
                ALUop = 2'b01;   // bne (subtração para comparação)
                sinal_leitura = 0;
                sinal_escrita = 0;
                reg_escrita = 0;
                ALUSrc = 0;
                resultado_desvio = 1;
                MemToReg = 0;
            end
            default: begin
                ALUop = 2'b00;
                sinal_leitura = 0;
                sinal_escrita = 0;
                reg_escrita = 0;
                ALUSrc = 0;
                resultado_desvio = 0;
                MemToReg = 0;
            end
        endcase
    end

endmodule
