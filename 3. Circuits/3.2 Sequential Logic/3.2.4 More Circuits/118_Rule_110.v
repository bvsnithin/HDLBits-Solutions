module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    reg [511:0] left;
    assign left = {1'b0, q[511:1]};
    reg [511:0] right;
    assign right  = {q[510:0],1'b0};
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            q <= (~(left) & right) | (q ^ right);
        end
    end

endmodule
