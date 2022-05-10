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
    inout logic [7:0] databus,
    output logic [7:0] aluout, 
    output logic [15:0] dataadr, 
    output logic memwrite,

);

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [15:0] pc, instr;
    logic [7:0] aluout, readdata;
    
    // instantiate processor
    processor cpu(.clk(clk), .reset(reset), .pc(pc), .instr(instr), .memWE(memwrite), .aluout(aluout), .writedata(writedata), .readdata(databus));
    
    // instantiate instruction memory
    memory mem(clk,memwrite,dataadr,pc,databus,instr);

endmodule

`endif // MIPSCOMPUTER