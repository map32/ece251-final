///////////////////////////////////////////////////////////////////////////////
//
// MAINCONTROLLER module
//
// Controller for MIPS CPU
//
// module: controller
// hdl: Verilog
//
// author: Sarah Harris
// See https://booksite.elsevier.com/9780123944245/?ISBN=9780123944245
//
///////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`include "decoder.sv"
`include "aludec.sv"

module controller(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic [7:0] instr,
    input logic [3:0] aluflags,
    output logic regWE, memWE, regChange, imm, load, store, offset, flush,
    output logic [2:0] pccontrol,
    output logic [3:0] alucontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    
    logic immm;
    assign immm = imm;
    maindec md(instr, aluflags, regWE, memWE, regChange, imm, load, store, offset, flush, pccontrol);
    aludec ad(instr[7:3],immm,alucontrol);

endmodule

`endif // CONTROLLER






