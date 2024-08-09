//`include "Processador.v"

module tb_Processador;

    reg clock, reset;
    //reg [31:0] registrador;

    // Instância do módulo Processador
    Processador processa (
        .clock(clock),
        .reset(reset)
    );

    /*
    initial begin
      codigo para gerar as ondas
    end*/
    initial clock <= 0;
    always #5 clock <=(!clock);
    integer i; // Declaração do inteiro antes de qualquer comando
    
    /*
    // Inicialização e controle do testbench
    always #5 begin
        // Exibe o valor dos registradores
        $display("Valores dos Registradores:");
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            $display("Registro %0d: %h", i, processa.reg_inst.registradores[i]);
        end

        // Finaliza a simulação
        $finish;
    end
    */

        // Inicialização e controle do testbench
    initial begin
        
        #100; // Espera 100 unidades de tempo para permitir que a simulação progrida

        // Exibe o valor dos registradores após 100 ns de simulação
        $display("Valores dos Registradores:");
        for (i = 0; i < 32; i = i + 1) begin
            $display("Registro %0d: %h", i, processa.reg_inst.registradores[i]);
        end

        // Finaliza a simulação
        $finish;
    end

    initial begin
        reset <= 0;
        #5 reset <= 1;
        #100 reset <= 0;
    end


endmodule
