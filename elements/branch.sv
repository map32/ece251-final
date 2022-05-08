`ifndef BRANCH
`define BRANCH

`include "./word_adder.sv"
`include "./mux2.sv"

module branchLogic (
    input logic [15:0] pc, lr, abs,
    input logic [7:0] lower,
    input logic [2:0] upper,
    input logic [2:0] code, // upper, cond match, lr, abs, 
    input logic C,
    output logic [15:0] pcnext, lrnext
);
    logic [7:0] buff, buff2;
    mux2({5b'0,upper},8b'0,code[2],buff);
    wordAdder(pc[15:8],buff,C,buff2);
    always_ff@(*)
    begin
        case(code[1:0])
            2'b1x: pcnext <= {lower, upper};
            2'b01: pcnext <= lr;
            2'b00: pcnext <= abs;
        endcase
        if (code == 2'b011)
            lrnext <= pc+1;
        else
            lrnext <= lr;
    end
    
endmodule

`endif