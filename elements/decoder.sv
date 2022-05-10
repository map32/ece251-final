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
    input logic [7:0] op,
    input logic [3:0] flags,
    output logic regWE, memWE, regChange, imm, load, store, offset, flush,
    output logic [2:0] bcode
    //output logic writeEnable, regContext, imm, load, flush, pcSel,
    //wE = regwrite
    //load = memtoreg
    //rC = regmsb
    //pcSel = branch
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [9:0] controls;
    logic sop,top,jmp;
    assign {load, regWE, store, memWE, regChange, imm, offset, shft, flush, sop,top} = controls;
    assign bcode = {jmp, sop, top};
    assign jmp = (flags == op[3:0]);

    always @*
    begin
        case(op[7:6])
            2'b00: controls <= 11'b01000000000; // RTYPE
            2'b01:
                case(op[5:4])
                    2'b01: controls <= 11'b0100000000;
                    default: controls <= 11'b01000100000;
                endcase
            2'b10: controls <= {~op[4],~op[4],op[4],op[4],1'b0,op[5],op[5],2'b00}; // SW
            2'b11:
                case(op[5:2])
                    4'b1100: controls <= 11'b01000001000;
                    4'b1101: controls <= 11'b01000001000;
                    4'b1110: controls <= 11'b00001000100;
                    4'b1111: controls <= 11'b00000000100;
                    4'b10xx: controls <= 11'b00000010010;
                    4'b00xx: controls <= {8'b00000110, op[3:0] == 1111 ,2'b01};
                    default: controls <= 11'b00000110011;
                endcase
        endcase
    end

endmodule

`endif // MAINDEC