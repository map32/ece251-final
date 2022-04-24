`timescale 1ns / 10ps // time-unit = 1 ns, precision = 10 ps

//
// TEST BENCH
//
module adder_tb(); // no I/O for a test bench
    //
    // ---------------- INPUT SIGNALS TO TEST MODULE -------------------
    //
    reg [7:0] A,B;
    wire [8:0] C;
    reg Cin;
    wire Cout;


    //
    // ---------------- OUTPUT SIGNALS FROM TEST MODULE ----------------
    //

    //
    // ---------------- TEST BENCH SIGNALS -----------------------------
    //
    // Instantiate the Unit Under Test (UUT)
    // instantiate mips device to be tested (see below for definition)
        wordAdder dut(A,B,Cin,C[7:0],C[8]);
        integer i,j;
        logic [8:0] ans;
    // initialize test
    initial
    begin
        for (i=0;i<256;i++)
            begin
            for (j=0;j<256;j++)
            begin
                A = i;
                B = j;
                Cin = 0;
                #20;
                ans = (A+B);
                if (C !== ans)
                   $display("error: %6d, %8b, %8b, %1b, %9b, %9b", $time, A, B, Cin, C, A+B);
                Cin = 1;
                #20;
                ans += 1;
                if (C !== ans)
                   $display("error: %6d, %8b, %8b, %1b, %9b, %9b", $time, A, B, Cin, C, A+B+1);
                
            end
            end
    end

endmodule // mips_cpu_tb