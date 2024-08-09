module BRegistradores(
    input clock,                   // Clock
    input reg_escrita,             // Sinal de controle para escrita
    input [4:0] endereco_regd,     // Registrador de destino
    input [4:0] endereco_reg1,     // Registrador de origem 1
    input [4:0] endereco_reg2,     // Registrador de origem 2
    input [31:0] dado_escrita,     // Dado a ser escrito
    //output [31:0] valor_regd,      // Valor do registrador de destino
    output reg [31:0] valor_reg1,      // Valor do registrador de origem 1
    output reg [31:0] valor_reg2       // Valor do registrador de origem 2
);

    reg [31:0] registradores[31:0]; // Vetor com 32 registradores de 32 bits

    integer i;

    // Inicializa todos os registradores com 0
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registradores[i] = 32'b0;
        end
        registradores[2] = 32'b1;
    end
    
    always @(posedge clock) begin
        if (reg_escrita && endereco_regd != 0) begin
            registradores[endereco_regd] <= dado_escrita; 
        end
    end

    always @(endereco_reg1, registradores[endereco_reg1]) begin
        valor_reg1 <= registradores[endereco_reg1];
    end 
    always @(endereco_reg2, registradores[endereco_reg2]) begin
        valor_reg2 <= registradores[endereco_reg2];
    end 
endmodule
