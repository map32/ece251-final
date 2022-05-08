///////////////////////////////////////////////////////////////////////////////
//
// ALU DECODER MIPS module
//
// ALU decoder for MIPS CPU
//
// module: aludec
// hdl: Verilog
//
// author: Sarah Harris
// See https://booksite.elsevier.com/9780123944245/?ISBN=9780123944245
//
///////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

/**
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
        input logic [7:0] readdata,
        input logic [3:0] alucontrol,
        input logic [2:0] pccontrol
**/

module aludec(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic [4:0] opcode,
    output logic [3:0] alucontrol,
    output logic [2:0] pccontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @*
    case(opcode[1:0])
        5'b00: alucontrol <= 3'b010; // add (for lw/sw/addi)
        5'b01: alucontrol <= 3'b110; // sub (for beq)
        default:
            case(funct) // R-type instructions
                6'b100000: alucontrol <= 3'b010; // add
                6'b100010: alucontrol <= 3'b110; // sub
                6'b100100: alucontrol <= 3'b000; // and
                6'b100101: alucontrol <= 3'b001; // or
                6'b101010: alucontrol <= 3'b111; // slt
                default: alucontrol <= 3'bxxx; // ???
            endcase
    endcase

endmodule

`endif // ALUDEC