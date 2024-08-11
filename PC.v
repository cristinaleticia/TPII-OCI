module PC(
    input clock,
    input reset,
    input wire [31:0] endereco_pc, // Endereco que vem do PC
    output reg [31:0] endereco_saida // Vem do PC+4 ou PC+imm
);

always @(posedge clock) begin
    if (reset) begin
        endereco_saida <= 32'b0;
    end
    else begin
        endereco_saida <= endereco_pc;
    end
end
endmodule
