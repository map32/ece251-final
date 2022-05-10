`timescale 1ns / 10ps // time-unit = 1 ns, precision = 10 ps
parameter prd = 40;
//
// TEST BENCH
//
`include "elements/main.sv"
module tb(); // no I/O for a test bench
    //
    // ---------------- INPUT SIGNALS TO TEST MODULE -------------------
    //
    //logic clk;
    /**logic [7:0] instr, prevInstr;
    logic [3:0] aluflags;
    logic regWE, memWE, regChange, imm, load, store, offset, flush;
    logic [7:0] signals;
    logic [2:0] pccontrol;
    logic [3:0] alucontrol;**/
    logic clk, reset;
    logic [7:0] databus;
    logic [7:0] aluout;
    logic [15:0] dataadr; 
    logic memwrite;

    project computer(clk,reset,databus,aluout,dataadr,memwrite);
    /**controller c(
        instr, aluflags,
        regWE, memWE, regChange, imm, load, store, offset, flush,
        pccontrol,alucontrol);
    assign signals = {regWE, memWE, regChange, imm, load, store, offset, flush};**/

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
    always #(prd) clk = ~clk;
    initial
    begin
        $dumpfile("test.vcd");
        $dumpvars(0,clk,reset,databus,aluout,dataadr,memwrite);
        clk = 0;
        reset = 1;
        #(prd+4);
        reset = 0;
    end

endmodule // mips_cpu_tb