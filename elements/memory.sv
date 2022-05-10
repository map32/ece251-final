
`ifndef MEM
`define MEM

module memory(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic clk, we,
    input logic [15:0] addr,
    input logic [7:0] datain,
    output logic [7:0] instr, dataout);

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [7:0] RAM[15:0];
    
    assign dataout = RAM[a]; // word aligned

    initial
    begin
        $readmemh("memfile.dat",RAM);
    end
    
    always_ff @(posedge clk)
    if (we)
        RAM[addr] <= datain;

endmodule

`endif // DMEM