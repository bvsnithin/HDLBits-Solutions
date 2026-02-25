module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    typedef enum logic[2:0] {S0,S1,S2,S3,DONE} state_t;
    
    state_t state, next_state;
    
    always @(posedge clk) begin
        state <= reset?S0:next_state;
    end
    
    always @(*) begin
        case(state) 
        	S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state =DONE;
            DONE: next_state = DONE;
        endcase
    end
    
    assign shift_ena = state!=DONE;

endmodule

