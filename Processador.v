


module Processador(
    input clock,
    input reset
);


    // Declaração de sinais
    wire [31:0] endereco_pc;
    wire [31:0] endereco_soma4;
    wire [31:0] endereco_desvio;
    wire [31:0] valor_regd;
    wire [31:0] valor_reg1;
    wire [31:0] valor_reg2;
    wire [31:0] valor2;
    wire [31:0] resultado_alu;
    wire [31:0] dado_saida;
    wire [31:0] imm_estendido;
    wire [31:0] endereco;
    wire [31:0] dado_escrita;
    wire [31:0] endereco_saida;
    wire [31:0] instrucao_saida;
    wire [4:0] rd;
    wire [3:0] operacao_selecionada;
    wire [4:0] endereco_reg1;
    wire [4:0] endereco_reg2;
    wire [4:0] endereco_regd;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    //wire [11:0] imediato;
    wire [1:0] ALUop;
    wire sinal_leitura;
    wire branch;
    wire sinal_escrita;
    wire reg_escrita;
    wire ALUSrc;
    wire resultado_desvio;
    wire MemToReg;
    wire sinal_mux;



    assign sinal_mux = resultado_desvio & branch;
    assign endereco_desvio = endereco_saida + imm_estendido;
    assign endereco_soma4 = endereco_saida + 32'h4;

    // Instancia do modulo PC
    PC pc_inst (
        .clock(clock),
        .reset(reset),
        .endereco_pc(endereco_pc),
        .endereco_saida(endereco_saida)
    );

    // Instancia do modulo MemInstrucoes
    MemInstrucoes mem_inst (
        .endereco(endereco_saida),
        .instrucao_saida(instrucao_saida),
        .rs1(endereco_reg1),
        .rs2(endereco_reg2),
        .rd(endereco_regd),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );

    // Instancia do modulo BRegistradores
    BRegistradores reg_inst (
        .clock(clock),
        .reg_escrita(reg_escrita),
        .endereco_regd(endereco_regd),
        .endereco_reg1(endereco_reg1),
        .endereco_reg2(endereco_reg2),
        .dado_escrita(dado_escrita),
        .valor_reg1(valor_reg1),
        .valor_reg2(valor_reg2)
    );

    ImmGen immgen_inst (
        .instrucao(instrucao_saida),
        .opcode(opcode),
        .imm_estendido(imm_estendido)
    );


    // Instancia do modulo ALU
    ALU alu_inst (
        .clock(clock),
        .resultado_alu_control(operacao_selecionada),
        .valor1(valor_reg1),
        .valor2(valor2),
        .resultado_alu(resultado_alu),
        .resultado_desvio(resultado_desvio)
    );

    // Instancia do modulo MemDados
    MemDados memdados_inst (
        .clock(clock),
        .endereco(resultado_alu),
        .valor_reg2(valor_reg2),
        .sinal_escrita(sinal_escrita),
        .sinal_leitura(sinal_leitura),
        .dado_saida(dado_saida)
    );

    // Instancia do modulo ALUControl
    ALUControl alucontrol_inst (
        .ALUop(ALUop),
        .funct3(funct3),
        .operacao_selecionada(operacao_selecionada)
    );
    
    // Instancia do modulo Controle
    Controle controle_inst (
        .opcode(opcode),
        .funct7(funct7),
        .funct3(funct3),
        .ALUop(ALUop),
        .sinal_leitura(sinal_leitura),
        .sinal_escrita(sinal_escrita),
        .reg_escrita(reg_escrita),
        .ALUSrc(ALUSrc),
        .branch(branch),
        .MemToReg(MemToReg)
    );


    // Instancia do mux
    mux muxpc_inst (
        .valor1(endereco_soma4),
        .valor2(endereco_desvio),
        .sinal_mux(sinal_mux),
        .endereco_saida(endereco_pc)
    );

   // Instancia do mux
    mux muxalu_inst (
        .valor1(valor_reg2),
        .valor2(imm_estendido),
        .sinal_mux(ALUSrc),
        .endereco_saida(valor2)
    );
    // Instancia do mux
    mux muxmemreg_inst (
        .valor1(resultado_alu),
        .valor2(dado_saida),
        .sinal_mux(MemToReg),
        .endereco_saida(dado_escrita)
        
    );



endmodule
