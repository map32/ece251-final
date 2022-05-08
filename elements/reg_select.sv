`ifndef REGSELECT
`define REGSELECT

`include "./mux2.sv"

module registerSelector(
    input logic [3:0] address1, address2, address3,
    input logic clk, write,
    input logic [7:0] nextval,
    output logic [7:0] out1, out2
);
    logic [15:0] r[7:0];

    always_ff @(negedge clk)
    begin
        if (write)
            r[address3] <= nextval;
    end
    
    assign out1 = r[address1];
    assign out2 = r[address2];

endmodule

`endif
