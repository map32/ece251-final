`timescale 1ns / 10ps // time-unit = 1 ns, precision = 10 ps
parameter prd = 10;
//
// TEST BENCH
//
`include "elements/controller.sv"
module tb(); // no I/O for a test bench
    //
    // ---------------- INPUT SIGNALS TO TEST MODULE -------------------
    //
    //logic clk;
    logic [7:0] instr, prevInstr;
    logic [3:0] aluflags;
    logic regWE, memWE, regChange, imm, load, store, offset, flush;
    logic [7:0] signals;
    logic [2:0] pccontrol;
    logic [3:0] alucontrol;

    controller c(
        instr, aluflags,
        regWE, memWE, regChange, imm, load, store, offset, flush,
        pccontrol,alucontrol);
    assign signals = {regWE, memWE, regChange, imm, load, store, offset, flush};

    //
    // ---------------- OUTPUT SIGNALS FROM TEST MODULE ----------------
    //

    //
    // ---------------- TEST BENCH SIGNALS -----------------------------
    //
    // Instantiate the Unit Under Test (UUT)
    // instantiate mips device to be tested (see below for definition)
        integer i,j;
    // initialize test

    initial
    begin
        //clk = 0;
        aluflags = 0;
        for (i=0;i<256;i++)
            begin
            //for (j=0;j<16;j++)
            //begin
                instr = i;
                //aluflags = j;
                #20;
                $display("%6d, %8b, %4b, %8b, %1b %1b %1b, %4b", $time, instr, aluflags, signals, pccontrol[2],pccontrol[1],pccontrol[0], alucontrol);
            //end
            end
    end

endmodule // mips_cpu_tb