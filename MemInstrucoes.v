module memoria_instrucoes (
    input [31:0] endereco,       // Endereco da instrucao a ser lida
    output reg [31:0] instrucao_saida // Instrucao lida
    output reg [4:0] rs1,   // Registrador de origem 1
    output reg [4:0] rs2,   // Registrador de origem 2
    output reg [4:0] rd,    // Registrador de destino
    output reg [6:0] opcode, // OpCode da instrucao
    output reg [2:0] funct3, // Campo funct3 (3 bits)
    output reg [6:0] funct7, // Campo funct7 (7 bits)
    output reg [11:0] imediato // Campo imediato (12 bits)
);

    reg [31:0] memoria [49:0]; // Definimos que serao lidas ate 50 instrucoes por vez
    // Inicializacao das instrucoes a partir do arquivo
    initial begin
        $readmemb("instrucoes.asm", memoria); // Le o arquivo binario e carrega na memoria
    end

    // Atribuicao da instrucao ao endereco calculado do pc
    always @(posedge clock) begin
        instrucao_saida <= memoria[endereco]; // Le a instrcao da memoria


        opcode   = instrucao[6:0];     // Campos opcode
        funct3   = instrucao[14:12];   // Campos funct3 (3 bits)
        
        // Decodificando as instrucoes (32 bits)
        case (opcode)
            7'b0110011: begin //Tipo R: ADD, OR e SLL
                funct7 = instrucao[31:25]; // Funct7 (7 bits)
                rs1    = instrucao[19:15]; // Reg 1 (5 bits)
                rs2    = instrucao[24:20]; // Reg 2 (5 bits)
                rd     = instrucao[11:7];  // reg de destino (5 bits)
            end

            7'b0010011: begin // Tipo I: ADDI 
                imediato = instrucao[31:20];
                rs1    = instrucao[19:15]; // Reg 1 (5 bits)
                rd     = instrucao[11:7];  // reg de destino (5 bits)
            end
            
            7'b0000011: begin // Tipo I: LH
                imediato = instrucao[31:20];
                rs1    = instrucao[19:15]; // Reg 1 (5 bits)
                rd     = instrucao[11:7];  // reg de destino (5 bits)
            end

            7'b0100011: begin // Tipo S: SH
                imediato = {instrucao[31:25], instrucao[11:7]}; 
                rs1    = instrucao[19:15]; // Reg 1 (5 bits)
                rs2    = instrucao[24:20]; // Reg 2 (5 bits)
            end

            7'b1100011: begin // Tipo S: BNE
                imediato = {instrucao[31:25], instrucao[11:7]};
                rs1    = instrucao[19:15]; // Reg 1 (5 bits)
                rs2    = instrucao[24:20]; // Reg 2 (5 bits)
            end

            default begin // Se der errado a leitura da funcao
                imediato = 12'b0; 
                rs1 = 5'b0;
                rs2 = 5'b0;
                rd = 5'b0;
                funct7 = 7'b0;
            end
        endcase
    end
    
endmodule
