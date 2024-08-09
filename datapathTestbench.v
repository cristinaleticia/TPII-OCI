module datapathTestbench;
    reg _clock, _reset
    datapath datapathInst(_clock, _reset);

    always @() begin
        #1 _clock <= ~_clock
    end

    

    initial begin
        $readmemb("reg.mem", datapathInst.regMemory.registradores);
        $readmemb("reg.mem", datapathInst.dataMemory.memory);
        $readmemb("reg.mem", datapathInst.instructionMem.instructions);
    reset = 1;
    clock = 0;

    #2 reset = 0;
    end


    always @(datapathInst.instruction === 32'bx) begin
        for (integer i = 0; i <32;i++ ) begin
            $display("registrador: %d : %b", i, datapathInst.regMemory.registradores[i]);
        end
    end

endmodule