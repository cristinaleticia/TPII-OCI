module ALU (
    input wire clock, // Clock
    input wire [3:0] resultado_alu_control, 
    input wire [31:0] valor_reg1,
    input wire [31:0] valor_reg2,
    input wire [31:0] imediato,
    input wire ALUSrc,
    output reg [31:0] resultado_alu,
    output reg resultado_desvio
);

always @(*) begin
    case(resultado_alu_control)
        4'b0000: 
            resultado_alu <= valor_reg1 & imediato; // andi
        4'b0001:
            resultado_alu <= valor_reg1 | valor_reg2; // or
        4'b0010:
            if (ALUSrc == 0) 
                resultado_alu <= valor_reg1 + valor_reg2; // add
            else 
                resultado_alu <= valor_reg1 + imediato; // sh e lh

        4'b0011:resultado_alu <= valor_reg1 << valor_reg2; // sll

        4'b0110: begin
            resultado_alu <= valor_reg1 - valor_reg2; // bne
            if (resultado_alu != 0) 
                resultado_desvio <= 1;
            else 
                resultado_desvio <= 0;
        end
        default: 
            resultado_alu <= 31'bx;
    endcase
end

endmodule
