module Processador(
    input clock,
    input reset
);

    //reg clock;
    reg [31:0] endereco_pc;
    reg [31:0] imediato_PC;
    reg sinal_mux; // Define se vou usar pc+4 ou o desvio
    reg [31:0] endereco;
    wire [31:0] dado_escrita;
    wire [31:0] endereco_saida;
    wire [31:0] instrucao_saida;
    wire [4:0] rd;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [11:0] imediato;
    wire [1:0] ALUop;
    wire sinal_leitura;
    wire sinal_escrita;
    wire reg_escrita;
    wire ALUSrc;
    wire resultado_desvio;
    wire MemToReg;
    wire [4:0] endereco_reg1;
    wire [4:0] endereco_reg2;
    wire [4:0] endereco_regd;

    wire [31:0] valor_regd;
    wire [31:0] valor_reg1;
    wire [31:0] valor_reg2;
    wire [3:0] operacao_selecionada;
    wire [31:0] resultado_alu;
    wire [31:0] dado_saida;
    wire [31:0] imm_estendido;

    // Instância do módulo PC
    PC pc_inst (
        .clock(clock),
        .endereco_pc(endereco_pc),
        .imediato(imediato_PC),
        .sinal_mux(sinal_mux),
        .endereco_saida(endereco_saida),
        .reset(reset)
    );

    // Instância do módulo MemInstrucoes
    MemInstrucoes mem_inst (
        .clock(clock),
        .endereco(endereco),
        .instrucao_saida(instrucao_saida),
        .rs1(endereco_reg1),
        .rs2(endereco_reg2),
        .rd(endereco_regd),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .imediato(imediato)
    );

    // Instância do módulo ImmGen
    ImmGen immgen_inst (
        .imediato(imediato),
        .imm_estendido(imm_estendido)
    );

    // Instância do módulo Controle
    Controle controle_inst (
        .opcode(opcode),
        .funct7(funct7),
        .funct3(funct3),
        .ALUop(ALUop),
        .sinal_leitura(sinal_leitura),
        .sinal_escrita(sinal_escrita),
        .reg_escrita(reg_escrita),
        .ALUSrc(ALUSrc),
        .resultado_desvio(resultado_desvio),
        .MemToReg(MemToReg)
    );

    // Instância do módulo BRegistradores
    BRegistradores reg_inst (
        .clock(clock),
        .reg_escrita(reg_escrita),
        .endereco_regd(endereco_regd),
        .endereco_reg1(endereco_reg1),
        .endereco_reg2(endereco_reg2),
        .dado_escrita(dado_escrita),
        //.valor_regd(valor_regd),
        .valor_reg1(valor_reg1),
        .valor_reg2(valor_reg2)
    );

    // Instância do módulo ALUControl
    ALUControl alucontrol_inst (
        .clock(clock),
        .ALUop(ALUop),
        .funct3(funct3),
        .operacao_selecionada(operacao_selecionada)
    );

    // Instância do módulo ALU
    ALU alu_inst (
        .clock(clock),
        .resultado_alu_control(operacao_selecionada),
        .valor_reg1(valor_reg1),
        .valor_reg2(valor_reg2),
        .imediato(imm_estendido),
        .ALUSrc(ALUSrc),
        .resultado_alu(resultado_alu),
        .resultado_desvio(resultado_desvio)
    );

    // Instância do módulo MemDados
    MemDados memdados_inst (
        .clock(clock),
        .resultado_alu(resultado_alu),
        .valor_reg2(valor_reg2),
        .MemToReg(MemToReg),
        .sinal_escrita(sinal_escrita),
        .sinal_leitura(sinal_leitura),
        .dado_saida(dado_saida)
    );

endmodule
