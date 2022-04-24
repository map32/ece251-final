`ifndef BITADD
`define BITADD
module bitAdder (
    input wire A, B, C,
    output wire S,Cout
);
    assign S = A ^ B ^ C;
    assign Cout = C & (A ^ B) | (A & B);
endmodule

`endif
