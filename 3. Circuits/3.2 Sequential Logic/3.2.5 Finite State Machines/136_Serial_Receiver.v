module top_module(
    input clk,
    input in,
    input reset,
    output reg done
); 

    typedef enum logic[3:0] {
        START, B0, B1, B2, B3, B4, B5, B6, B7, STOP, NOT_FOUND
    } state_t;

    state_t state, next_state;

    always @(*) begin
        case(state)
            START:     next_state = in ? START : B0;

            B0:        next_state = B1;
            B1:        next_state = B2;
            B2:        next_state = B3;
            B3:        next_state = B4;
            B4:        next_state = B5;
            B5:        next_state = B6;
            B6:        next_state = B7;
            B7:        next_state = STOP;

            STOP:      next_state = in ? START : NOT_FOUND;

            NOT_FOUND: next_state = in ? START : NOT_FOUND;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= START;
            done <= 0;
        end
        else begin
            state <= next_state;
            done <= (state == STOP) && in;  
        end
    end

endmodule
