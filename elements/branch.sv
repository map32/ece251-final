`ifndef BRANCH
`define BRANCH

`include "./word_adder.sv"
`include "./mux2.sv"
`include "./dbl_increment.sv"

module branchLogic (
    input logic [15:0] pc, lr, abs,
    input logic [7:0] upper,
    input logic [2:0] lower,
    input logic [2:0] code, // JMP, CD1, CD0
    //1xx: do not add to upper half
    //x00: branchReg
    //x01: jump return
    //x11: jump link
    //x10: offset or none
    input logic C,
    output logic [15:0] pcnext, lrnext
);
    logic [7:0] buff, buff2;
    logic [15:0] pcplus1;
    doubleword_increment incre(pc,pcplus1);
    mux2(8'b00000000,{5b'0,lower},code[2],buff);
    wordAdder(pc[15:8],buff,C,buff2);
    always_ff@(*)
    begin
        case(code[1:0])
            2'b00: pcnext <= pcplus1;
            2'b01: pcnext <= {buff2, upper};
            2'b10: pcnext <= abs;
            2'b11: pcnext <= lr;
        endcase
        if (code[2])
            lrnext <= pcplus1;
        else
            lrnext <= lr;
    end
    
endmodule

`endif