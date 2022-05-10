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
`ifndef PROCESSOR
`define PROCESSOR

`include "./datapath.sv"
`include "./controller.sv"

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
    logic [15:0] lr;
    logic [7:0] prevInstr;
    logic [3:0] aluflags;
    logic regWE, memWE, regChange, imm, load, store, offset, flush;
    logic [2:0] pccontrol;
    logic [3:0] alucontrol;


    // MIPS controller
    controller c(
        instr,prevInstr, aluflags,
        regWE, memWE, regChange, imm, load, store, offset, flush,
        pccontrol,alucontrol);

    datapath dp(
        clk, reset,
        regWE, regChange, imm, load, flush, offset,
        pc, lr, instr, prevInstr, aluout, writedata, aluflags,
        databus, alucontrol, pccontrol);

endmodule

`endif // MIPS