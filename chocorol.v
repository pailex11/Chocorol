`timescale 1ns/1ns

module chocorol (
    input [19:0] Instruccion, // Entrada de instrucci�n
    output [31:0] Q_final     // Salida final
);
    wire [31:0] Q1_mem;  // Salida del m�dulo A (Q1)
    wire [31:0] Q2_mem;  // Salida del m�dulo A (Q2)
    wire [31:0] Q4_mem;  // Salida del m�dulo B (Q4)
    wire [31:0] ALU_result; // Salida de la ALU

    // Instancia del m�dulo A
    A A_inst (
        .DE(Instruccion[5:0]),      // Direcci�n de escritura
        .DL1(Instruccion[11:6]),    // Direcci�n de lectura 1
        .DL2(Instruccion[17:12]),   // Direcci�n de lectura 2
        .Dato(Q4_mem),              // Dato desde el m�dulo B
        .WE(Instruccion[18]),       // Se�al de escritura
        .Q1(Q1_mem),                // Salida Q1
        .Q2(Q2_mem)                 // Salida Q2
    );

    // Instancia del m�dulo B
    B B_inst (
        .Direccion(Instruccion[4:0]), // Direcci�n de la memoria B
        .Dato(Q1_mem),                // Dato a escribir desde el m�dulo A
        .WE(Instruccion[19]),         // Se�al de escritura
        .Q4(Q4_mem)                   // Salida de B
    );

    // Instancia de la ALU
    ALU ALU_inst (
        .A(Q1_mem),                   // Primer operando de la ALU
        .B(Q2_mem),                   // Segundo operando de la ALU
        .Sel(Instruccion[3:0]),       // Selector de la operaci�n ALU
        .Q3(ALU_result)               // Resultado de la ALU
    );

    // Conexi�n final al resultado
    assign Q_final = ALU_result;

endmodule

