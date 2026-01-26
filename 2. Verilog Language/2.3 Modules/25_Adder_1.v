module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] cout_1;
    wire [15:0] cout_2;
    add16 ( a[15:0], b[15:0], 15'b0, sum[15:0], cout_1 );
    add16 ( a[31:16], b[31:16], cout_1, sum[31:16], cout_2 );

endmodule
