module MemDados(
    input wire clock,                
    input wire [31:0] endereco,      // Endereço de memória
    input wire [31:0] valor_reg2,    // Dado a ser escrito
    input wire sinal_escrita,        // Sinal de controle para escrita
    input wire sinal_leitura,        // Sinal de controle para leitura
    output reg [31:0] dado_saida     // Dado lido da memória
);
    reg [31:0] memoria_dados [0:63]; // Memória de 64 endereços de 32 bits
    reg [5:0] temp;                  // Endereço de memória ajustado (dividido por 4)
    reg byte;                        // Determina o byte a ser escrito/lido

    // Ajuste do endereço e determinação do byte a ser acessado
    always @(*) begin
        temp = endereco[7:2];  // Divisão do endereço por 4 (alinhamento de palavras)
        byte = endereco[1];    // Seleção do byte a ser acessado (0 ou 1)
    end

    // Leitura da memória
    always @(*) begin
        if (sinal_leitura) begin
            if (byte == 1'b0) begin
                dado_saida <= {{16{memoria_dados[temp][15]}}, memoria_dados[temp][15:0]}; // Leitura dos bytes 0 e 1
            end else begin
                dado_saida <= {{16{memoria_dados[temp][31]}}, memoria_dados[temp][31:16]}; // Leitura dos bytes 2 e 3
            end
        end
    end

    // Escrita na memória
    always @(negedge clock) begin 
        if (sinal_escrita) begin
            if (byte == 1'b0) begin
                memoria_dados[temp][15:0] <= valor_reg2[15:0]; // Escrita nos bytes 0 e 1
            end else begin
                memoria_dados[temp][31:16] <= valor_reg2[15:0]; // Escrita nos bytes 2 e 3
            end
        end
    end
endmodule
