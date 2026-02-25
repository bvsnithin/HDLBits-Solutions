
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    typedef enum logic[3:0] {S, S1, S11, S110, B0, B1, B2, B3, COUNT, WAIT} state_t;
    state_t state, next_state;
    
    always @(posedge clk) begin
        state <= reset?S:next_state;
    end
    
    always @(*) begin
        case(state)
            S: begin
                next_state = data?S1:S;
            end
            S1: begin
                next_state = data?S11:S;
            end
            S11: begin
                next_state = data?S11:S110;
            end
            S110: begin
                next_state = data?B0:S;
            end
            B0: begin
                next_state = B1;
            end
            B1: begin
                next_state = B2;
            end
            B2: begin
                next_state = B3;
            end
            B3: begin
               next_state = COUNT;
            end
            COUNT: begin
                next_state = done_counting?WAIT:COUNT;
            end
            WAIT: begin
                next_state = ack?S:WAIT;
            end
            
        endcase
    end
    
    assign counting = state == COUNT;
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);
    assign done = state ==WAIT;
    

endmodule
