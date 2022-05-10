///////////////////////////////////////////////////////////////////////////////
//
// MAINDEC module
//
// Main decoder for MIPS CPU
//
// module: maindec
// hdl: Verilog
//
// author: Sarah Harris
// See https://booksite.elsevier.com/9780123944245/?ISBN=9780123944245
//
///////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

module maindec(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic [5:0] op,
    input logic [3:0] flags,
    output logic regWE, memWE, regChange, imm, load, store, offset,
    output logic [2:0] branchop
    //output logic writeEnable, regContext, imm, load, flush, pcSel,
    //wE = regwrite
    //load = memtoreg
    //rC = regmsb
    //pcSel = branch
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [8:0] controls;
    logic sop;
    assign {load, regWE, store, memWE, regChange, imm, offset, shft, sop} = controls;

    always @*
        case(op[7:6])
            2'b00: controls <= 9'b010000000; // RTYPE
            2'b01:
                case(op[5:4])
                    2'b01: controls <= 9'b01000000;
                    default: controls <= 9'b010001000;
                endcase
            2'b10: controls <= {~op[4],~op[4],op[4],op[4],1'b0,op[5],op[5],2'b00}; // SW
            2'b11:
                controls <= 9'bzzzzzzzzz1;
        endcase

endmodule

`endif // MAINDEC