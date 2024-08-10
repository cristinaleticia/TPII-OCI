module tb_Processador;

    reg clock, reset;
    integer i;

    // Instância do módulo Processador
    Processador processa (
        .clock(clock),
        .reset(reset)
    );

    // Geração do sinal de clock
    initial begin
        clock = 0;
    end

    always #5 clock = ~clock;

    // Inicialização e controle do testbench
    initial begin
        // Inicialização do sinal de reset
        reset = 0;
        #5 reset = 1;
        #10 reset = 0;

        // Espera para permitir que a simulação progrida
        #100;

        // Exibe os sinais endereco_saida e endereco_pc
        $display("endereco_pc = %h, endereco_saida = %h", processa.endereco_pc, processa.endereco_saida);

        // Exibe o valor dos registradores após a simulação
        $display("Valores dos Registradores:");
        for (i = 0; i < 32; i = i + 1) begin
            $display("Registro %0d: %h", i, processa.reg_inst.registradores[i]);
        end

        // Finaliza a simulação
        $finish;
    end

endmodule
