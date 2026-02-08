module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3;
    
    wire d1, d2, d3;
    
    assign d1 = q1 ^ x;
    assign d2 = ~q2 & x;
    assign d3 = ~q3 | x;
    
    assign z = ~ (q1 | q2 | q3);
    
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end
             
endmodule
