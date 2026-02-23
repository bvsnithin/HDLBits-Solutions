module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);
    parameter A = 0, B = 1;
    reg state;
    reg [1:0] count1, count3;
    
    always @(posedge clk) begin
        if(reset) begin
            state <= A;
            count1 <= 0;
            count3 <= 0;
            z <= 0;
        end
        else begin
            case(state) 
                A: begin
                    state <= s ? B : A;
                    z <= 0;
                end

                B: begin
                    if(count3 == 2) begin   // third cycle
                        z <= ((count1 + w) == 2);  // include current w
                        count3 <= 0;
                        count1 <= 0;
                    end
                    else begin
                        count3 <= count3 + 1;
                        if(w)
                            count1 <= count1 + 1;
                        z <= 0;
                    end
                end
            endcase
        end
    end

endmodule
