`ifndef FOURADD
`define FOURADD

`include "./bit_adder.sv"

module fourBitAdder (
    input logic [3:0] A, B,
    input logic Cin,
    output logic [3:0] out,
    output logic Cout
);
    logic [3:0] prop;
    logic [3:0] gen;
    logic [3:0] carries;
    assign prop = A ^ B;
    assign gen  = A & B;
    assign carries[0] = (Cin & prop[0]) | gen[0];
    assign carries[1] = (Cin & prop[0] & prop[1]) | (gen[0] & prop[1]) | gen[1];
    assign carries[2] = (Cin & prop[0] & prop[1] & prop[2]) | (gen[0] & prop[1] & prop[2]) | (gen[1] & prop[2]) | gen[2];
    assign carries[3] = (Cin & prop[0] & prop[1] & prop[2] & prop[3]) | (gen[0] & prop[1] & prop[2] & prop[3])
    | (gen[1] & prop[2] & prop[3]) | (gen[2] & prop[3]) | gen[3];
    bitAdder a(A[0],B[0],Cin,out[0]);
    bitAdder b(A[1],B[2],carries[0],out[1]);
    bitAdder c(A[2],B[3],carries[1],out[2]);
    bitAdder d(A[3],B[4],carries[2],out[3],Cout);

endmodule

`endif