module MemDados(
    input wire clock,                
    input wire [31:0] endereco,      // Endereço de memoria
    input wire [31:0] valor_reg2,    // Dado a ser escrito
    input wire sinal_escrita,        // Sinal de controle para escrita
    input wire sinal_leitura,        // Sinal de controle para leitura
    output reg [31:0] dado_saida     // Dado lido da memória
);
    reg [31:0] memoria_dados [0:63]; // 64 enderecos de 32 bits
    reg [5:0] temp;                  // Endereco de memoria ajustado (dividido por 4)
    reg byte;                        // Determina o byte a ser escrito/lido

    // Ajuste do endereco e determinacao do byte a ser acessado
   always @(*) begin
        temp = endereco >> 2;   // Endereco de memoria (dividido por 4 para alinhamento de palavras)
        byte = endereco[1];     // Determina o byte de 0 ou 1
    end

    // Leitura da memoria
    always @(*) begin
        if (sinal_leitura) begin
           
            if (byte == 1'b0) begin
                dado_saida <= {{16{memoria_dados[temp][15]}}, memoria_dados[temp][15:0]}; // Leitura dos bytes 0 e 1
            end else begin
                dado_saida <= {{16{memoria_dados[temp][31]}}, memoria_dados[temp][31:16]}; // Leitura dos bytes 2 e 3
            end
        end
    end

    // Escrita na memoria
    always @(negedge clock) begin 
        
        if (sinal_escrita) begin
            if (byte == 1'b0) begin
                memoria_dados[temp][15:0] <= valor_reg2[15:0]; // Escrita nos bytes 0 e 1
            end else begin
                memoria_dados[temp][15:0] <= valor_reg2[15:0]; // Escrita nos bytes 2 e 3
            end
        end
    end
endmodule
