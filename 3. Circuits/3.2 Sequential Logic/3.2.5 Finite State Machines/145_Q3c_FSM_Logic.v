module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg [2:0] Y;
    parameter y0 = 0, y1 = 1, y2 = 2, y3 = 3, y4 = 4;
    
    always @(*) begin
        case(y)
            y0: Y <= x?y1:y0;
            y1: Y <= x?y4:y1;
            y2: Y <= x?y1:y2;
            y3: Y <= x?y2:y1;
            y4: Y <= x?y4:y3;
            default Y <= 3'b000;
        endcase
    end
    
    assign z = (y==y3) || (y==y4);
    assign Y0 = Y[0];

endmodule
