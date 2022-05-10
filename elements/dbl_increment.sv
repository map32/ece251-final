`ifndef INCREMENT
`define INCREMENT
module doubleword_increment (
    input logic [15:0] A,
    output logic [15:0] B
);
    assign B = A+1;
endmodule

`endif
