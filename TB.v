`timescale 1ns/1ns

module TB;

    reg [19:0] Instruccion;  // Señal para las instrucciones
    reg [5:0] DL1, DL2;      // Señales para las posiciones de memoria (operandos)
    wire [31:0] Q_final;     // Salida del resultado final
    integer file;            // Variable para manejar el archivo

    // Instanciar el módulo chocorol
    chocorol uut (
        .Instruccion(Instruccion),
        .Q_final(Q_final)
    );

    // Monitor para depuración
    initial begin
        $monitor("Tiempo = %0t, Instruccion = %b, DL1 = %d, DL2 = %d, Q_final = %d", $time, Instruccion, DL1, DL2, Q_final);
    end

    initial begin
        // Abrir el archivo 'Programa' para escritura
        file = $fopen("Programa", "w");
        if (file == 0) begin
            $display("Error: no se pudo abrir el archivo 'Programa' para escritura");
            $finish;
        end

        // Escribir el encabezado del archivo
        $fwrite(file, "Programa\n\n");

        // Pruebas de operaciones usando la ALU
        DL1 = 6'd0;  DL2 = 6'd1;  Instruccion = {DL1, DL2, 8'b00000000};  #10;
        $fwrite(file, "Suma:\n\tMem[0] + Mem[1] = %d\n", Q_final);
        
        DL1 = 6'd2;  DL2 = 6'd3;  Instruccion = {DL1, DL2, 8'b00000001};  #10;
        $fwrite(file, "Resta:\n\tMem[2] - Mem[3] = %d\n", Q_final);
        
        DL1 = 6'd4;  DL2 = 6'd5;  Instruccion = {DL1, DL2, 8'b00000010};  #10;
        $fwrite(file, "AND:\n\tMem[4] & Mem[5] = %d\n", Q_final);
        
        DL1 = 6'd6;  DL2 = 6'd7;  Instruccion = {DL1, DL2, 8'b00000011};  #10;
        $fwrite(file, "OR:\n\tMem[6] | Mem[7] = %d\n", Q_final);
        
        DL1 = 6'd0;  DL2 = 6'd1;  Instruccion = {DL1, DL2, 8'b00000111};  #10;
        $fwrite(file, "Multiplicación:\n\tMem[0] * Mem[1] = %d\n", Q_final);

        // Cerrar el archivo
        $fclose(file);
        #1000;  // Tiempo de simulación adicional
        $stop;
    end

endmodule

