module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    // State transition logic
    parameter A = 0, B = 1, C = 2, D = 3;
    reg [3:0] state;
    reg [3:0] next_state;
    

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if(reset) begin
            state <= 4'b0001;
        end
        else state <= next_state;
    end
    
    always @(*) begin
        next_state[A] = (state[0]&~in) | (state[2]&~in);
    	next_state[B] = (state[3]&in)  | (state[1]&in) | (state[0]&in);
    	next_state[C] = (state[1]&~in) | (state[3]&~in);
    	next_state[D] = (state[2]&in); 
    end
    // Output logic
    
    assign out = (state[3]==1)?1:0;

endmodule

