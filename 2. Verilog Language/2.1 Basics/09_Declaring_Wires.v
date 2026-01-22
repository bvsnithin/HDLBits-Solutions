`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire a_b_and, c_d_and,or_temp;
    assign a_b_and = a&b;
    assign c_d_and = c&d;
    assign or_temp = a_b_and | c_d_and;
    assign out = or_temp;
    assign out_n = ~or_temp; 

endmodule
