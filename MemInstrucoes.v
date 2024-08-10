module MemInstrucoes (
    input clock,
    input wire [31:0] endereco,        // Endereço da instrução a ser lida
    output reg [31:0] instrucao_saida, // Instrução lida
    output reg [4:0] rs1,              // Registrador de origem 1
    output reg [4:0] rs2,              // Registrador de origem 2
    output reg [4:0] rd,               // Registrador de destino
    output reg [6:0] opcode,           // OpCode da instrução
    output reg [2:0] funct3,           // Campo funct3 (3 bits)
    output reg [6:0] funct7,           // Campo funct7 (7 bits)
    output reg [11:0] imediato         // Campo imediato (12 bits)
);

    reg [31:0] memoria [2:0]; // Definidos para ler 3 instruções por vez
    
    // Inicialização das instruções a partir do arquivo
    initial begin
        $readmemb("instrucoes.asm", memoria, 0, 2); // Lê o arquivo binário e carrega na memória
    end

    // Atribuição da instrução ao endereço calculado do pc
    always @(endereco) begin
        instrucao_saida <= memoria[endereco]; // Lê a instrução da memória

        //$display("Endereco: %b, Instrucao: %b", $time, endereco, instrucao_saida);

        opcode   <= instrucao_saida[6:0];     // Campos opcode
        funct3   <= instrucao_saida[14:12];   // Campos funct3 (3 bits)
        
        // Decodificando as instruções (32 bits)
        case (opcode)
            7'b0110011: begin // Tipo R: ADD, OR e SLL
                funct7 <= instrucao_saida[31:25]; // Funct7 (7 bits)
                rs1    <= instrucao_saida[19:15]; // Reg 1 (5 bits)
                rs2    <= instrucao_saida[24:20]; // Reg 2 (5 bits)
                rd     <= instrucao_saida[11:7];  // Reg de destino (5 bits)
            end

            7'b0010011: begin // Tipo I: ADDI 
                imediato <= instrucao_saida[31:20];
                rs1    <= instrucao_saida[19:15]; // Reg 1 (5 bits)
                rd     <= instrucao_saida[11:7];  // Reg de destino (5 bits)
            end
            
            7'b0000011: begin // Tipo I: LH
                imediato <= instrucao_saida[31:20];
                rs1    <= instrucao_saida[19:15]; // Reg 1 (5 bits)
                rd     <= instrucao_saida[11:7];  // Reg de destino (5 bits)
            end

            7'b0100011: begin // Tipo S: SH
                imediato <= {instrucao_saida[31:25], instrucao_saida[11:7]}; 
                rs1    <= instrucao_saida[19:15]; // Reg 1 (5 bits)
                rs2    <= instrucao_saida[24:20]; // Reg 2 (5 bits)
            end

            7'b1100011: begin // Tipo B: BNE
                imediato <= {instrucao_saida[31:25], instrucao_saida[11:7]};
                rs1    <= instrucao_saida[19:15]; // Reg 1 (5 bits)
                rs2    <= instrucao_saida[24:20]; // Reg 2 (5 bits)
            end

            default: begin // Se der errado a leitura da função
                imediato <= 12'b0; 
                rs1 <= 5'b0;
                rs2 <= 5'b0;
                rd <= 5'b0;
                funct7 <= 7'b0;
            end
        endcase
        // Mensagens de depuração
        //$display("Opcode: %b, Funct3: %b, Funct7: %b, Imediato: %b", opcode, funct3, funct7, imediato);
        //$display("RS1: %d, RS2: %d, RD: %d", rs1, rs2, rd);
       // $display("---------------------------------------------------------------------------------");
    end
    
endmodule
