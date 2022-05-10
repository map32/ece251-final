`ifndef ALU
`define ALU
`include "./word_adder.sv"
`include "./bit_adder.sv"
module alu(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic [7:0] A, B, 
    input logic [3:0] code,
    input logic prevCarry,
    output logic [7:0] Y,
    output logic carry, overflow, zero, negative
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    
    logic [7:0] Bout;
    logic [8:0] S;
    logic computedCarry;
    assign Bout = code[0] ? ~B : B;
    // normal op: code[0]
    // with carry = code[0] ^ carry
    assign computedCarry = code[3] & (code[0] ^ prevCarry) | ~code[3] & code[0];
    wordAdder adder(A,Bout,computedCarry,S[7:0],S[8]);
    logic [15:0] mult;
    assign mult = A*B;
    assign carry = S[8];
    assign overflow = (A[7] & Bout[7] & ~S[7]) | (~A[7] & ~Bout[7] & S[7]);
    assign zero = A == 0;
    assign negative = S[7];

    always @(S,A,Bout,code)
    begin
        case (code[2:0])
            3'b000: Y <= S[7:0];
            3'b010: Y <= mult[7:0];
            3'b011: Y <= mult[15:8];
            3'b100: Y <= A & B;
            3'b101: Y <= A | B;
            3'b110: Y <= A ^ B;
            3'b111: Y <= ~(A | B); 
            default Y <= S[7:0];
        endcase
    end

endmodule

`endif // ALU32
