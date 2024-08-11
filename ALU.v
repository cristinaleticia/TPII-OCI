module ALU (
    input clock,
    input wire [3:0] resultado_alu_control,
    input wire [31:0] valor1,
    input wire [31:0] valor2,
    output reg [31:0] resultado_alu,
    output reg resultado_desvio //Retorna 1 se os numeros forem diferentes
);

    always @(negedge clock) begin
        resultado_desvio <= 0;
        case(resultado_alu_control)
            4'b0000: resultado_alu <= valor1 & valor2; // andi
            4'b0001: resultado_alu <= valor1 | valor2; // or
            4'b0010: resultado_alu <= valor1 + valor2; // add, sh e lh
            4'b0011: resultado_alu <= valor1 << valor2[4:0]; // sll
            4'b0110: begin
            resultado_alu <= valor1 - valor2; // bne
            if (resultado_alu != 0) 
                resultado_desvio <= 1;
            else 
                resultado_desvio <= 0;
        end
            default: resultado_alu <= 32'b0; 
        endcase
        
    end

endmodule
