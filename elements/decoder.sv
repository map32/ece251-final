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
    logic [10:0] controls;
    logic sop,top,jmp,cond,ret;
    assign {load, regWE, store, memWE, regChange, imm, offset, shft, flush, sop,top} = controls;
    assign jmp = (op[7:4] == 4'b1101);
    assign ret = op[3:0] == 4'b1111;
    assign bcode = {jmp, controls[1:0]};
    assign cond = (flags == op[3:0]);


    always @*
    begin
        case(op[7:6])
            2'b00: controls           <= 11'b01000000000; // RTYPE
            2'b01:
                case(op[5:4])
                    2'b01:   controls <= 11'b01000000000; //R
                    default: controls <= 11'b01000100000; //I
                endcase
            2'b10: controls <= {~op[4],~op[4],op[4],op[4],1'b0,op[5],op[5],4'b0000}; // 
            2'b11:
                case(op[5:2])
                    4'b1100: controls <= 11'b01000001000; //lsl
                    4'b1101: controls <= 11'b01000001000; //lsr
                    4'b1110: controls <= 11'b00001000100; //change reg msb
                    4'b1111: controls <= 11'b00000000100; // nop
                    4'b1011: controls <= {9'b000000000,cond,1'b0}; //branch to register addr
                    4'b1010: controls <= {9'b000000000,cond,1'b0}; 
                    4'b1001: controls <= {9'b000000000,cond,1'b0}; 
                    4'b1000: controls <= {9'b000000000,cond,1'b0}; 
                    4'b0011: 
                        if (op[1:0] == 2'b11) controls <= 11'b00000110111; //return to lr
                        else controls <= {10'b0000011000,cond};
                    4'b0010: controls <={10'b0000011000,cond}; //branch by offset
                    4'b0001: controls <={10'b0000011000,cond}; //branch by offset
                    4'b0000: controls <={10'b0000011000,cond}; //branch by offset
                    default: controls   <= 11'b00000110001; //jump by 11, lr = pc+1
                endcase
        endcase
    end

endmodule

`endif // MAINDEC