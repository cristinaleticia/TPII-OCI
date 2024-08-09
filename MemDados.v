module MemDados(
    input wire clock,                // Clock
    input wire [31:0] resultado_alu, // Endereço de memória
    input wire [31:0] valor_reg2,    // Dado a ser escrito
    input wire MemToReg,             // Controle para escolher entre ALU e memória
    input wire sinal_escrita,        // Sinal de controle para escrita
    input wire sinal_leitura,        // Sinal de controle para leitura
    output reg [31:0] dado_saida     // Dado lido da memória
);
    reg [31:0] memoria [0:255];      // Memória de 256 endereços de 32 bits
    reg [7:0] temp;                 // Endereço de memória ajustado para 32 bits
    reg byte;                       // Determina o byte a ser escrito/lido (1 bit)

    always @(*) begin
        temp = resultado_alu >> 2;   // Endereço de memória (dividido por 4 para alinhamento de palavras)
        byte = resultado_alu[1];     // Determina o byte de 0 ou 1
    end

    always @(negedge clock) begin //talvez mudar e separar escrita e leitura
        if (sinal_escrita) begin
            // Escrita na memória
            if (byte == 1'b0) begin
                memoria[temp][15:0] <= valor_reg2[15:0];   // Escreve nos bytes 0 e 1
            end else begin
                memoria[temp][31:16] <= valor_reg2[15:0];   // Escreve nos bytes 2 e 3
            end
        end
        
        if (sinal_leitura) begin
            if (MemToReg == 1'b0) begin
                dado_saida <= resultado_alu; // Quando MemToReg é 0, usa o endereço diretamente
            end else begin
                // Leitura da memória
                if (byte == 1'b0) begin
                    dado_saida <= {{16{memoria[temp][15]}}, memoria[temp][15:0]}; // Leitura dos bytes 0 e 1
                end else begin
                    dado_saida <= {{16{memoria[temp][31]}}, memoria[temp][31:16]}; // Leitura dos bytes 2 e 3
                end
            end
        end
    end
endmodule



/*module MemDados(
    input wire clock,                // Clock
    input wire [31:0] resultado_alu, // Endereco de memoria
    input wire [31:0] valor_reg2,    // Dado a ser escrito
    input wire MemToReg,             // Controle para escolher entre ALU e memoria
    input wire sinal_escrita,        // Sinal de controle para escrita
    input wire sinal_leitura,        // Sinal de controle para leitura
    output reg [31:0] dado_saida     // Dado lido da memória
);
    reg [31:0] memoria [0:255];  // Memoria de 256 endereços de 32 bits
    temp <= resultado_alu >> 2;
    byte <= resultado_alu % 2;

    always @(posedge clock) begin
        if (sinal_escrita) begin
            // Escrita na memoria
            if(byte == 0) begin
                memoria[temp][15:0] <= valor_reg2[15:0];
            end
            else begin
                memoria[temp][31:16] <= valor_reg2[31:16];
            end
        end
        
        if (sinal_leitura) begin
            if (MemToReg == 0) begin
                dado_saida <= resultado_alu;
            end
            else begin
                if(byte == 0) begin
                dado_saida <= {{16{memoria[15]}}, memoria[temp][15:0]};
                end
            else begin
                dado_saida <= {{16{memoria[31]}},memoria[temp][31:16]};
            end
            end
        end
    end
endmodule
*/