module banco_registradores(
    input clock,
    input reg_escrita,        // Sinal de controle para escrita
    input [4:0] endereco_regd, // Registrador de destino
    input [4:0] endereco_reg1, // Registrador de origem 1
    input [4:0] endereco_reg2, // Registrador de origem 2
    input [31:0] dado_escrita, // Dado a ser escrito
    output [31:0] valor_regd, // Valor do registrador de destino
    output [31:0] valor_reg1, // Valor do registrador de origem 1
    output [31:0] valor_reg2  // Valor do registrador de origem 2
);

    reg [31:0] registradores[31:0]; //Um vetor com 32 registradores de 32 bits

    //Inicializa todos os registradores com 0
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registradores[i] = 32'b0;
        end
    end
    
    always @(posedge clock) begin
        if(reg_escrita == 1 and endereco_regd != 0) begin //Nao pode escrever no registrador 0
            registradores[endereco_regd] <= dado_escrita; 
        end
    end

    assign valor_regd = registradores[endereco_regd];
    assign valor_reg1 = registradores[endereco_reg1];
    assign valor_reg2 = registradores[endereco_reg2];
endmodule