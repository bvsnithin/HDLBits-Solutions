module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] in_prev = 8'b0;
    always @(posedge clk) begin
        pedge = ~in_prev & in;
        in_prev <= in;
    end

endmodule
