module top_module (
    input  clk,
    input  aresetn,    // Asynchronous active-low reset
    input  x,
    output reg z
);

    parameter s0 = 2'd0,
              s1 = 2'd1,
              s2 = 2'd2;

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= s0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            s0: begin
                next_state = x ? s1 : s0;
                z = 1'b0;
            end

            s1: begin
                next_state = x ? s1 : s2;
                z = 1'b0;
            end

            s2: begin
                next_state = x ? s1 : s0;
                z = x ? 1'b1 : 1'b0;   
            end

            default: begin
                next_state = s0;
                z = 1'b0;
            end
        endcase
    end

endmodule
