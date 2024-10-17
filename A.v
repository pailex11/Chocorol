`timescale 1ns/1ns
module A (          
    input [5:0] DE,        // Direcci�n de escritura
    input [5:0] DL1,       // Direcci�n de lectura 1
    input [5:0] DL2,       // Direcci�n de lectura 2
    input [31:0] Dato,     // Dato a escribir
    input WE,              // Se�al de escritura
    output reg [31:0] Q1,  // Salida del registro 1
    output reg [31:0] Q2   // Salida del registro 2
);

   reg [31:0] Mem [0:31];  // Memoria de 32 registros de 32 bits

   // Inicializaci�n opcional de la memoria
   initial begin
        Mem[0] = 32'd1; // Inicializar Mem[0]
        Mem[1] = 32'd2; // Inicializar Mem[1]
        Mem[2] = 32'd3; // Inicializar Mem[2]
        Mem[3] = 32'd4; // Inicializar Mem[3]
        Mem[4] = 32'd5; // Inicializar Mem[4]
        Mem[5] = 32'd6; // Inicializar Mem[5]
        Mem[6] = 32'd7; // Inicializar Mem[6]
        Mem[7] = 32'd8; // Inicializar Mem[7]
        // M�s inicializaciones seg�n sea necesario
   end

    always @* begin
        if (WE) begin
            Mem[DE] <= Dato;  // Escritura en memoria si WE est� activa
        end
        Q1 <= Mem[DL1];       // Lectura en Q1
        Q2 <= Mem[DL2];       // Lectura en Q2
    end
endmodule

