module top_module(
    input clk,
    input [7:0] in,
    input reset,
    output done
);

	typedef enum logic [1:0] {B0, B1, B2, DONE} state_t;
	state_t state, next_state;

	always @(*) begin
    	case(state)
        	B0: next_state = in[3] ? B1 : B0;
        	B1: next_state = B2;
        	B2: next_state = DONE;
            DONE: next_state = in[3]?B1:B0;
    	endcase
	end

	always @(posedge clk) begin
    	if(reset)
        	state <= B0;
    	else
        	state <= next_state;
	end

	assign done = (state == DONE);

endmodule
