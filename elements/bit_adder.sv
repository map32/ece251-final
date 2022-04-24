`ifndef BITADD
`define BITADD
module bitAdder (
    input logic A, B, C,
    output logic S,Cout
);
    assign S = A ^ B ^ Cin;
    assign Cout = Cin & (A ^ B) | (A & B);
endmodule

`endif