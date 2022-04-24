///////////////////////////////////////////////////////////////////////////////
//
// 32-BIT MIPS CPU TEST BENCH
//
// module: mips_cpu_tb
// hdl: Verilog
//
// author: Sarah Harris
// See https://booksite.elsevier.com/9780123944245/?ISBN=9780123944245
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 10ps // time-unit = 1 ns, precision = 10 ps

//
// TEST BENCH
//
module adder_tb(); // no I/O for a test bench
    //
    // ---------------- INPUT SIGNALS TO TEST MODULE -------------------
    //
    logic [7:0] A,B,C;
    logic Cin, Cout;


    //
    // ---------------- OUTPUT SIGNALS FROM TEST MODULE ----------------
    //

    //
    // ---------------- TEST BENCH SIGNALS -----------------------------
    //
    // Instantiate the Unit Under Test (UUT)
    // instantiate mips device to be tested (see below for definition)
        wordAdder dut(A,B,Cin,C,Cout);

    // initialize test
    initial
    begin
        integer i;
        $monitor("%6d, %8b, %8b, %1b, %8b", $time, A, B, Cin, C, Cout);
        for (i=0;i<20;i++)
            begin
                A = $urandom % 256;
                B = $urandom % 256;
                C = $urandom % 2;
                #20;
            end
    end

endmodule // mips_cpu_tb
