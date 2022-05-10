
`ifndef MEM
`define MEM

module memory(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic clk, we,
    input logic [15:0] daddr,iaddr,
    inout logic [7:0] databus,
    output logic [7:0] instr
    )

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [7:0] RAM[15:0];
    
    assign databus = we ? RAM[daddr] : 8'bzzzzzzzz; // word aligned
    assign instr = RAM[iaddr];

    initial
    begin
        $readmemh("memfile.dat",RAM);
    end
    
    always_ff @(negedge clk)
    if (we)
        RAM[addr] <= databus;

endmodule

`endif // DMEM