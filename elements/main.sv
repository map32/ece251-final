///////////////////////////////////////////////////////////////////////////////
//
// MIPS COMPUTER module
//
// 32-bit MIPS COMPUTER
//
// module: mips_computer
// hdl: Verilog
//
// author: Sarah Harris
// See https://booksite.elsevier.com/9780123944245/?ISBN=9780123944245
//
///////////////////////////////////////////////////////////////////////////////
`ifndef PROJECT
`define PROJECT

`include "./processor.sv"
`include "./memory.sv"

module project(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic clk, reset,
    output logic [7:0] writedata,
    output logic [15:0] dataadr, 
    output logic memwrite,

);

    module processor(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic clk, reset,
    output logic [15:0] pc,
    input logic [7:0] instr,
    output logic memWE,
    output logic [7:0] aluout, writedata,
    input logic [7:0] databus
);

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [31:0] pc, instr, readdata;
    
    // instantiate processor
    processor cpu(.clk(clk), .reset(reset), .pc(pc), .instr(instr), .memWE(memwrite), .databus(readdata), .writedata(writedata), .readdata(readdata));
    
    // instantiate instruction memory
    imem imem(pc[7:2], instr);

endmodule

`endif // MIPSCOMPUTER