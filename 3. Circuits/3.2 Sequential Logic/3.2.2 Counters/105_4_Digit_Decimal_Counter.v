module top_module (
    input  clk,
    input  reset,
    output reg [15:0] q,
    output wire [2:0] ena
);

    // Enable signals for upper digits
    assign ena[0] = (q[3:0]   == 4'd9);                              // tens
    assign ena[1] = (q[7:4]   == 4'd9) && (q[3:0]  == 4'd9);         // hundreds
    assign ena[2] = (q[11:8]  == 4'd9) && (q[7:4]  == 4'd9) &&
                    (q[3:0]   == 4'd9);                              // thousands

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'd0;
        end
        else begin
            // Ones digit
            if (q[3:0] == 4'd9)
                q[3:0] <= 4'd0;
            else
                q[3:0] <= q[3:0] + 4'd1;

            // Tens digit
            if (ena[0]) begin
                if (q[7:4] == 4'd9)
                    q[7:4] <= 4'd0;
                else
                    q[7:4] <= q[7:4] + 4'd1;
            end

            // Hundreds digit
            if (ena[1]) begin
                if (q[11:8] == 4'd9)
                    q[11:8] <= 4'd0;
                else
                    q[11:8] <= q[11:8] + 4'd1;
            end

            // Thousands digit
            if (ena[2]) begin
                if (q[15:12] == 4'd9)
                    q[15:12] <= 4'd0;
                else
                    q[15:12] <= q[15:12] + 4'd1;
            end
        end
    end

endmodule

