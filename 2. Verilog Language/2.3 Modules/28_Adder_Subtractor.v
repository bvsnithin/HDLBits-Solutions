module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b_1;
    wire cout_1, cout_2;
    assign b_1 = b^{32{sub}}; 
    add16 inst_1 ( a[15:0], b_1[15:0], sub, sum[15:0], cout_1 );
    add16 inst_2 ( a[31:16], b_1[31:16], cout_1, sum[31:16], cout_2);
endmodule


