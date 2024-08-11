`timescale 1ns/100ps

module tb_Processador;
    reg clock, reset;
    integer i;
    // Instância do módulo Processador
    Processador processa (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        $readmemb("instrucoes.mem", processa.mem_inst.memoria_instrucoes);
        $readmemb("registradores.mem", processa.reg_inst.registradores);
        $readmemb("dados.mem", processa.memdados_inst.memoria_dados);
        $dumpfile("saida.vcd");
        $dumpvars(3, processa);

        reset = 1;
        clock = 0;
        #10 reset = 0;


    end

    always begin
        #1 clock = ~clock; // Define o período do clock para 2 unidades de tempo
    end

     always @(processa.alu_inst.resultado_alu) begin
        // Exibindo o valor de resultado_alu e outros sinais a cada borda de subida do clock
        $display("Resultado ALU: %h", processa.alu_inst.resultado_alu);
        $display("Valor1: %h", processa.alu_inst.valor1);
        $display("Valor2: %h", processa.alu_inst.valor2);
        $display("Operacao Selecionada: %b", processa.alu_inst.resultado_alu_control);
        $display("Resultado Desvio: %b", processa.alu_inst.resultado_desvio);

    end
    always @(processa.instrucao_saida) begin
    
    if (processa.instrucao_saida === 32'bx) begin
        #10
        for (integer i = 0; i < 32; i++) begin
            $display("Registrador %d = %b", i, processa.reg_inst.registradores[i]);
        end
         for (integer i = 0; i < 5; i++) begin
            $display("Dados %d = %b", i, processa.memdados_inst.memoria_dados[i]);
        end
        $finish();

    end
end
endmodule
