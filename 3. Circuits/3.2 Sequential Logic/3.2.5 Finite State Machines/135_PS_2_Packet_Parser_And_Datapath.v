module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done);

    typedef enum logic[1:0] {B0,B1,B2,DONE} state_t;
    state_t state, next_state;
    
    reg [23:0] datapath;

    always @(posedge clk) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            B0:   next_state = in[3] ? B1 : B0;
            B1:   next_state = B2;
            B2:   next_state = DONE;
            DONE: next_state = in[3] ? B1 : B0;
        endcase
    end

    always @(posedge clk) begin
        if (reset) datapath <= 24'b0;
        else datapath <= {datapath[15:8], datapath[7:0], in};
    end

    assign done = (state == DONE);
    assign out_bytes = (state == DONE) ? datapath : 24'b0;

endmodule
