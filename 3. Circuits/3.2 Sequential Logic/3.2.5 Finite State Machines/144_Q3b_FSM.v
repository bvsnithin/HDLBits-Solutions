module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    reg [2:0] y;
    parameter y0 = 0, y1 = 1, y2 = 2, y3 = 3, y4 = 4;
    
    always @(posedge clk) begin
        if(reset) begin
        	y <= y0;
        end
        else begin
            case(y) 
                y0: begin
                    y <= x?y1:y0;
                end
                y1: begin
                    y <= x?y4:y1;
                end
                y2: begin
                    y <= x?y1:y2;
                end
                y3: begin
                    y <= x?y2:y1;
                end
                y4: begin
                    y <= x?y4:y3;
                end
            endcase
        end
    end
    
    assign z = (y==y3) || (y==y4);
    
    

endmodule
