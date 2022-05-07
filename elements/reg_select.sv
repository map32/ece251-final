`ifndef REGSELECT
`define REGSELECT

`include "./mux2.sv"

module registerSelector(
    input logic [2:0] address,
    input logic clk, write,
    input logic [7:0] nextval,
    output logic [7:0] out,
);
    logic [7:0] r[7:0];

    always_ff @(posedge clk)
    begin
        if (write)
            r[address] <= nextval;
    end
    
    assign out = r[address];

endmodule

`endif
