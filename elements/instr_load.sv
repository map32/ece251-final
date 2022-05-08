///////////////////////////////////////////////////////////////////////////////
//
// MIPS CPU module
//
// 32-bit MIPS CPU
//
// module: mips
// hdl: Verilog
//
// author: Sarah Harris
// See https://booksite.elsevier.com/9780123944245/?ISBN=9780123944245
//
///////////////////////////////////////////////////////////////////////////////
`ifndef INSTRLOAD
`define INSTRLOAD

`include "./word_adder.sv"
`include "./mux2.sv"

module instr_load(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic clk, reset, isUpper,
    input logic [7:0] instr,
    output logic [7:0] prevInstr
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always_ff @(negedge clk, posedge reset)
    begin
        if (reset) instrReg <= 0;
        else prevInstr <= instr;
    end

endmodule

`endif // MIPS