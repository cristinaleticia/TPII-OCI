module Controle (
    input wire [6:0] opcode,         
    input wire [6:0] funct7,          
    input wire [2:0] funct3,          
    output reg [1:0] ALUop,           // Sinal de controle da ALU
    output reg sinal_leitura,         // Sinal de leitura da memoria
    output reg sinal_escrita,         // Sinal de escrita na memoria
    output reg reg_escrita,           // Sinal de escrita no registrador
    output reg ALUSrc,                // Se eh imediato ou reg2 que vai entrar na alu
    output reg branch,                // Se a instrucao eh um desvio
    output reg MemToReg               // Se os dados sao da memoria ou da alu
);

    always @(opcode) begin
        case (opcode)
            7'b0000011: begin // Load (lh)
                ALUop <= 2'b00;   // Acesso a memoria
                sinal_leitura <= 1;
                sinal_escrita <= 0;
                reg_escrita <= 1;
                ALUSrc <= 0; //AVALIAR
                branch <= 0;
                MemToReg <= 1;
            end
            7'b0100011: begin // Store (sh)
                ALUop <= 2'b00;   // Acesso a memoria
                sinal_leitura <= 0;
                sinal_escrita <= 1;
                reg_escrita <= 0;
                ALUSrc <= 1;
                branch <= 0;
                MemToReg <= 0;
            end
            7'b0110011: begin // Tipo R
                ALUop <= 2'b10;   // OR, ADD e SLL
                sinal_leitura <= 0;
                sinal_escrita <= 0;
                reg_escrita <= 1;
                ALUSrc <= 0;
                branch <= 0;
                MemToReg <= 0;
            end
            7'b0010011: begin // Tipo I 
                ALUop <= 2'b11; // ANDI
                sinal_leitura <= 0;
                sinal_escrita <= 0;
                reg_escrita <= 1;
                ALUSrc <= 1;
                branch <= 0;
                MemToReg <= 0;
            end
            7'b1100011: begin // Resultado de desvio (bne)
                ALUop <= 2'b01;   // bne (subtração para comparacao)
                sinal_leitura <= 0;
                sinal_escrita <= 0;
                reg_escrita <= 0;
                ALUSrc <= 0;
                branch <= 1;
                MemToReg <= 0;
            end
            default: begin
                ALUop <= 2'b00;
                sinal_leitura <= 0;
                sinal_escrita <= 0;
                reg_escrita <= 0;
                ALUSrc <= 0;
                branch <= 0;
                MemToReg <= 0;
            end
        endcase
    end

endmodule
