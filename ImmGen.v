module GeradorImm(
    input [11:0] imediato,
    output reg [31:0] imm_estendido,
);

    assign imm_estendido = {{20{in[11]}}, imediato};

endmodule