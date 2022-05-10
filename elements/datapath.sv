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
`include "./alu_flags.sv"
module datapath(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
        input logic clk, reset,
        input logic writeEnable, regChange, imm, load, flush, offset,
        output logic [15:0] pc, lr,
        input logic [7:0] instr,
        output logic [7:0] prevInstr,
        output logic [7:0] aluout, writedata,
        output logic [3:0] flags,
        input logic [7:0] databus,
        input logic [3:0] alucontrol,
        input logic [2:0] pccontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [3:0] rnAddr, rmAddr, rdAddr;
    logic [7:0] lower;
    logic [15:0] pcnext, lrnext;
    logic [7:0] regA, regB, srca, srcb;
    logic [3:0] nextFlags;
    logic regmsb;

    //load or reset last instr
    instr_load last(clk,reset,flush,instr,prevInstr); //output: previnstr
    assign lower = prevInstr;
    // next PC logic
    always_ff@(posedge clk, posedge reset)
    begin
        if (reset)
        begin
            pc <= 15b'0;
            lr <= 15b'0;
            regmsb <= 1b'0;
        end
        else
        begin
            pc <= pcnext;
            lr <= lrnext;
            if (regChange)
                regmsb <= instr[0];
        end
    end
    branchLogic pclogic(pc,lr,{srca,srcb},aluout,lower[2:0],pccontrol,nextFlags[3],pcnext,lrnext);

    // register file logic
    assign rdAddr = {regmsb, lower[2:0]};
    assign rmAddr = instr[3:0];
    mux2 #(4) regAselector(instr[7:4], rdAddr, imm, rnAddr);
    mux2 #(8) regWriteSelector(aluout, databus, load, writedata);

    registerSelector rf(.address1(rnAddr), .address2(rmAddr), .address3(rdAddr),
    .clk(clk), .write(writeEnable), .nextval(writedata), .out1(regA), out2(regB));

    // ALU logic
    logic C;
    mux2 #(8) immSelector(regB,instr,imm,srcb);
    mux2 #(8) pcSelector(regA,pc[7:0],offset,srca);
    aluFlags flagRegs(nextFlags,flags,clk,reset,alucontrol[0]);
    assign C = flags[3];
    alu alu(.A(srca), .B(srcb), .code(alucontrol), .prevCarry(flags[3]), .Y(aluout),
    .carry(nextFlags[3]), .overflow(nextFlags[2]), .zero(nextFlags[1]), .negative(nextFlags[0]));

endmodule

`endif // DATAPATH