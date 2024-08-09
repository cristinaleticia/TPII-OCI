module PC(
    input clock,
    input reset,
    input wire [31:0] endereco_pc, // Endereco que vem do PC
    input wire [31:0] imediato,    // Será usado para calcular desvio
    input wire sinal_mux,          // Resultado da porta AND
    output reg [31:0] endereco_saida // Vem do PC+4 ou PC+imm
);
reg [31:0] aux1;
reg [31:0] aux2;

always @(posedge clock or posedge reset) begin
    if (reset) begin
       endereco_saida <= 32'b0;
    end 
    else begin
        aux1 <= endereco_pc + 4;
        aux2 <= endereco_pc + imediato; // PC + desvio

        if (sinal_mux == 0) begin
            endereco_saida <= aux1;
        end else begin
            endereco_saida <= aux2;
        end  
         
        $display("Endereço de saida: %b", endereco_saida);
    end
     $display("PC e imediato: %b", endereco_pc, imediato);

end

endmodule
