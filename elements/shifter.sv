`ifndef SHFT
`define SHFT
`include "mux2.sv"
module shifter
  (
   input  logic [7:0] A,
   input logic [1:0] shft,
   input logic left, 
    output logic [7:0] B
);
   logic [7:0] a, msbin, lsbin;
   mux2 #(8) msbinput({2'b00,A[7:2]},{A[5:0],2'b00},left,msbin);
   mux2 #(8) msb(A,msbin,shft[1],a);
   mux2 #(8) lsbinput({1'b0,a[7:1]},{A[6:0],1'b0},left,lsbin);
   mux2 #(8) lsb(a,lsbin,shft[0],B);

endmodule

`endif // MUX2