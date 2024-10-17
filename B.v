`timescale 1ns/1ns

module B (
    input [4:0] Direccion,   // Dirección de escritura/lectura
    input [31:0] Dato,       // Dato a escribir
    input WE,                // Señal de escritura
    output reg [31:0] Q4     // Salida del dato leído
);  
    reg [31:0] Mem1 [0:31];   // Memoria de 32 registros de 32 bits

    // Inicialización opcional de la memoria
    initial begin
        Mem1[0] = 32'd1; // Inicializar Mem1[0]
        Mem1[1] = 32'd2; // Inicializar Mem1[1]
        Mem1[2] = 32'd3; // Inicializar Mem1[2]
        Mem1[3] = 32'd4; // Inicializar Mem1[3]
        Mem1[4] = 32'd5; // Inicializar Mem1[4]
        Mem1[5] = 32'd6; // Inicializar Mem1[5]
        Mem1[6] = 32'd7; // Inicializar Mem1[6]
        Mem1[7] = 32'd8; // Inicializar Mem1[7]
        // Puedes añadir más inicializaciones según sea necesario
    end

    always @* begin
        if (WE) begin
            Mem1[Direccion] <= Dato;  // Escritura si WE está activa
        end
        Q4 <= Mem1[Direccion];        // Lectura del dato
    end
endmodule

