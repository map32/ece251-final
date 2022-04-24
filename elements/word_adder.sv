`ifndef WORDADD
`define WORDADD

`include "./halfword_adder.sv"
`include "./mux2.sv"

module wordAdder(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    output wire [7:0] S,
    output wire Cout
);
    wire [4:0] ifzero;
    wire [4:0] ifone;
    wire Cinter;
    wire zero = 0;
    wire one = 1;
    fourBitAdder a(A[3:0],B[3:0],Cin,S[3:0],Cinter);
    fourBitAdder b(A[7:4],B[7:4],zero,ifzero[3:0],ifzero[4]);
    fourBitAdder c(A[7:4],B[7:4],one,ifone[3:0],ifone[4]);
    mux2 res(ifzero[3:0], ifone[3:0], Cinter, S[7:4]);
    assign Cout = Cinter == 0 ? ifzero[4] : ifone[4];

endmodule

`endif
