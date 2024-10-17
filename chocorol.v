`timescale 1ns/1ns

module chocorol (
    input [19:0] Instruccion, // Entrada de instrucción
    output [31:0] Q_final     // Salida final
);
    wire [31:0] Q1_mem;  // Salida del módulo A (Q1)
    wire [31:0] Q2_mem;  // Salida del módulo A (Q2)
    wire [31:0] Q4_mem;  // Salida del módulo B (Q4)
    wire [31:0] ALU_result; // Salida de la ALU

    // Instancia del módulo A
    A A_inst (
        .DE(Instruccion[5:0]),      // Dirección de escritura
        .DL1(Instruccion[11:6]),    // Dirección de lectura 1
        .DL2(Instruccion[17:12]),   // Dirección de lectura 2
        .Dato(Q4_mem),              // Dato desde el módulo B
        .WE(Instruccion[18]),       // Señal de escritura
        .Q1(Q1_mem),                // Salida Q1
        .Q2(Q2_mem)                 // Salida Q2
    );

    // Instancia del módulo B
    B B_inst (
        .Direccion(Instruccion[4:0]), // Dirección de la memoria B
        .Dato(Q1_mem),                // Dato a escribir desde el módulo A
        .WE(Instruccion[19]),         // Señal de escritura
        .Q4(Q4_mem)                   // Salida de B
    );

    // Instancia de la ALU
    ALU ALU_inst (
        .A(Q1_mem),                   // Primer operando de la ALU
        .B(Q2_mem),                   // Segundo operando de la ALU
        .Sel(Instruccion[3:0]),       // Selector de la operación ALU
        .Q3(ALU_result)               // Resultado de la ALU
    );

    // Conexión final al resultado
    assign Q_final = ALU_result;

endmodule

