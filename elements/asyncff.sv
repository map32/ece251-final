`ifndef ASYNCFF
`define ASYNCFF

// asynchronously resettable flip flop

module asyncff
#(parameter l = 8)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic       clk,
    input  logic       reset, 
    input  logic [l-1:0] d, 
    output logic [l-1:0] q
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    
    // asynchronous reset
    always_ff @(posedge clk, posedge reset)
        if (reset) q <= l'b0;
        else       q <= d;

endmodule

`endif // FLOPR_ASYNC