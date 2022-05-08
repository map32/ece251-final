///////////////////////////////////////////////////////////////////////////////
//
// DATAPATH MIPS module
//
// Datapath for MIPS CPU
//
// module: datapath
// hdl: Verilog
//
// author: Sarah Harris
// See https://booksite.elsevier.com/9780123944245/?ISBN=9780123944245
//
///////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH
`include "./mux2.sv"
`include "./reg_select.sv"
`include "./alu.sv"
`include "./branch.sv"
`include "./instr_load.sv"
module datapath(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
        input logic clk, reset,
        input logic writeEnable, regContext, isItype,
        input logic isLoad,
        input logic isUpper,
        input logic cycleDone,
        output logic [15:0] pc, lr,
        input logic [7:0] instr,
        input logic [7:0] prevInstr,
        output logic [7:0] aluout, writedata,
        input logic C,
        output logic [3:0] nextFlags,
        input logic [7:0] databus,
        input logic [3:0] alucontrol,
        input logic [2:0] pccontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [3:0] regAaddress;
    logic [7:0] writereg;
    logic [15:0] pcn, lrn;
    logic [7:0] regA, regB, aluA, aluB;
    logic [31:0] result;

    instr_load(clk,reset,isUpper,instr,prevInstr);

    // next PC logic
    always_ff@(posedge clk, posedge reset)
    begin
        if (reset)
        begin
            pc <= 15b'0;
            lr <= 15b'0;
        end
        else
        begin
            pc <= pcnext;
            lr <= lrnext;
        end
    end
    branchLogic(pc,lr,{regB, regA},aluout,prevInstr[2:0],pccontrol,nextFlags[3],pcnext,lrnext);
    mux2 #(16) pcbrmux(pc, pcnextstep, cycleDone, pcnext);

    // register file logic
    assign writereg = {regContext, prevInstr[7:5]};
    mux2 #(4) regAmux(instr[3:0], writereg, isItype, regAaddress);
    mux2 #(8) resmux(aluout, databus, isLoad, writedata);

    registerSelector rf(.address1(regAaddress), .address2(instr[7:4]), .address3(writereg),
    .clk(clk), .write(writeEnable), .nextval(writedata), .out1(regA), out2(regB));

    // ALU logic
    mux2 #(8) iTypeChecker(regB,instr,isItype,srcb);
    assign srca = regA;
    alu alu(.A(srca), .B(srcb), .code(alucontrol), .prevCarry(C), .Y(aluout),
    .carry(nextFlags[3]), .overflow(nextFlags[2]), .zero(nextFlags[1]), .negative(nextFlags[0]));

endmodule

`endif // DATAPATH