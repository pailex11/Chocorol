`timescale 1ns/1ns

module ALU (
    input [31:0] A,
    input [31:0] B,
    input [3:0] Sel,    // Selector de 4 bits para las operaciones de la ALU
    output reg [31:0] Q3
);

    always @(*) begin
        case (Sel)
            4'b0000: Q3 = A & B;                // AND
            4'b0001: Q3 = A | B;                // OR
            4'b0010: Q3 = A + B;                // ADD
            4'b0110: Q3 = A - B;                // SUBTRACT
            4'b0111: Q3 = (A < B) ? 32'b1 : 32'b0; // Set on less than (ternario)
            4'b1100: Q3 = ~(A | B);             // NOR
            default: Q3 = 32'b0;                // Default a 0 si no es reconocido
        endcase
    end
endmodule

