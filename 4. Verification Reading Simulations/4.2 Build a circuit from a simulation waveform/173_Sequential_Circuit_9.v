module top_module (
    input clk,
    input a,
    output [3:0] q );
    
    always @(posedge clk) begin
        if(a) begin
            q <= 4'b0100;
        end
        else q <= (q == 4'b0110) ? 4'b0000 : q + 4'b0001;
    end

endmodule
