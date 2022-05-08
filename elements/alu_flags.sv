`ifndef ALUFLAGS
`define ALUFLAGS

module aluFlags(
    input logic [3:0] nextFlags,
    output logic [3:0] flags,
    input clk, reset, writeEnable
);
    always_ff(posedge clk, posedge reset)
        if (reset) flags <= 4b'0;
        else if (writeEnable) flags <= nextFlags;

endmodule

`endif // ALU32
