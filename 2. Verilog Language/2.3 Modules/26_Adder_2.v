module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
    wire cout_1,cout_2;
    add16 inst_1 ( a[15:0], b[15:0], 15'b0, sum[15:0], cout_1 );
    add16 inst_2 ( a[31:16], b[31:16], cout_1, sum[31:16], cout_2 );

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
    assign sum = a^b^cin;
    assign cout = a&b | a&cin | b&cin;

endmodule

