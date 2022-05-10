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
`ifndef ALUDEC
`define ALUDEC

module aludec(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic [4:0] op,
    input logic imm,
    output logic [3:0] alucode

    //output logic writeEnable, regContext, imm, load, flush, pcSel,
    //wE = regwrite
    //load = memtoreg
    //rC = regmsb
    //pcSel = branch
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [3:0] ctrl;
    assign alucode = ctrl;
    always @(op)
        case(op[4:3])
            2'b00:
                if (op[2:0] == 3'b001)
                    ctrl <= 0;
                else
                    ctrl <= op[3:0];
            2'b01:
                if (~op[2] & op[1]) ctrl <= 4'b1000;
                else ctrl <= {1'b0,op[2:0]};
            default: ctrl <= 4'b0100;
        endcase

endmodule

`endif // MAINDEC