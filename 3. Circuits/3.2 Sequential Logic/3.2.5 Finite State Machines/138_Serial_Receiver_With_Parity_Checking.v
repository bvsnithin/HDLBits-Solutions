module top_module(
    input clk,
    input in,
    input reset,
    output done,
    output [7:0] out_byte
); 

    typedef enum logic[3:0] {
        START, B0, B1, B2, B3, B4, B5, B6, B7, PARITY, STOP, NOT_FOUND
    } state_t;

    state_t state, next_state;

    reg [7:0] shift_reg;

    wire odd;
    wire parity_reset;

    assign parity_reset = (state == START);

    parity parity_checker(
        .clk(clk),
        .reset(parity_reset),
        .in(in),
        .odd(odd)
    );

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
            B7:        next_state = PARITY;
            PARITY:    next_state = STOP;

            STOP:      next_state = in ? START : NOT_FOUND;

            NOT_FOUND: next_state = in ? START : NOT_FOUND;

            default:   next_state = START;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= START;
            shift_reg <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;

            if (state >= B0 && state <= B7)
                shift_reg <= {in, shift_reg[7:1]};

            done <= (state == STOP) && in && odd;

            if ((state == STOP) && in && odd)
                out_byte <= shift_reg;
        end
    end

endmodule
