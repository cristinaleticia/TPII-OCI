`timescale 1ns/100ps

module tb_Processador;
    reg clock, reset;
    integer i;

    // Insancia do modulo Processador
    Processador processa (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        //Iicializacao das memorias
        $readmemb("instrucoes.asm", processa.mem_inst.memoria_instrucoes);
        $readmemb("registradores.asm", processa.reg_inst.registradores);
        $readmemb("dados.asm", processa.memdados_inst.memoria_dados);

        //arquivo de ondas
        $dumpfile("saida.vcd");
        $dumpvars(3, processa);

        reset = 1;
        clock = 0;
        #10 reset = 0;
    end

    always begin
        #1 clock = ~clock; // Define o periodo do clock para 2 unidades de tempo
    end


    always @(processa.instrucao_saida) begin
    if (processa.instrucao_saida === 32'bx) begin
        #10
        $display("Registradores:");
        for (integer i = 0; i < 32; i++) begin
            $display("Registrador [%d]: %d", i, processa.reg_inst.registradores[i]);
        end
        $display("Memoria de dados:");
        for (i = 0; i < 64; i = i + 1) begin
            $display("Dados [%d] = %d", i, processa.memdados_inst.memoria_dados[i]);
        end
        $finish();

    end
end
endmodule
