`ifndef WORDADD
`define WORDADD

`include "./halfword_adder.sv"

module wordAdder(
    input logic [7:0] A,
    input logic [7:0] B,
    input logic Cin,
    output logic [7:0] S,
    output logic Cout
);
    logic [3:0] inter;
    logic Cinter;
    fourBitAdder a(A[3:0],B[3:0],Cin,S[3:0],Cinter);
    fourBitAdder b(A[7:4],B[7:4],Cinter,S[7:4],Cout);

endmodule

`endif