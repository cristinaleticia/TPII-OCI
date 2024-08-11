module BRegistradores(
    input clock,                   
    input reg_escrita,             // Sinal de controle para escrita
    input [4:0] endereco_regd,     // Registrador de destino
    input [4:0] endereco_reg1,     // Registrador de origem 1
    input [4:0] endereco_reg2,     // Registrador de origem 2
    input [31:0] dado_escrita,     // Dado a ser escrito
    output reg [31:0] valor_reg1,  // Valor do registrador de origem 1
    output reg [31:0] valor_reg2   // Valor do registrador de origem 2
);

    reg [31:0] registradores[0:31]; // Vetor com 32 registradores de 32 bits
    
    
    always @(posedge clock) begin
        //$display("regd: %b", endereco_regd);

        if (reg_escrita && endereco_regd != 0) begin //Registrador 0 eh somente de leitura, portanto nao eh possivel escrever nele
            registradores[endereco_regd] = dado_escrita;
        end
       // $display("dado: %b", dado_escrita);
    end

    always @(endereco_reg1, registradores[endereco_reg1]) begin
        valor_reg1 = registradores[endereco_reg1];
        //$display("leitura: %b dado:", endereco_reg1, valor_reg1);
    end 
    always @(endereco_reg2, registradores[endereco_reg2]) begin
        valor_reg2 = registradores[endereco_reg2];
        // $display("leitura: %b dado:", endereco_reg2, valor_reg2);
    end 

endmodule
