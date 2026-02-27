module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    typedef enum logic[3:0] {S0,S1,S2,S3,S4,S5,S6,S50,S60,FAIL} state_t;
    
    state_t state, next_state;
    
    always @(posedge clk) begin
        state <= reset?S0:next_state;
    end
    
    always @(*) begin
        case(state)
            S0: next_state = in?S1:S0;
            S1: next_state = in?S2:S0;
            S2: next_state = in?S3:S0;
            S3: next_state = in?S4:S0;
            S4: next_state = in?S5:S0;
            S5: next_state = in?S6:S50;
            S6: next_state = in?FAIL:S60;
            FAIL: next_state = in?FAIL:S0;
            S50: next_state = in?S1:S50;
            S60: next_state = in?S1:S60;
            
        endcase
    end
    
    assign disc = state == S50;
    assign flag = state == S60;
    assign err = state == FAIL;
    

endmodule

