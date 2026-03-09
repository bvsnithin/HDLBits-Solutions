module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);

    localparam S3  = 3'd0,
               S23 = 3'd1,
               S32 = 3'd2,
               S12 = 3'd3,
               S21 = 3'd4,
               S1  = 3'd5;

    reg [2:0] state, next;

    always @(posedge clk) begin
        if (reset)
            state <= S1;
        else
            state <= next;
    end

    always @(*) begin
        case(state)

            S3: begin
                if (s == 3'b111) next = S3;
                else if (s == 3'b011) next = S32;
                else next = S3;
            end

            S23: begin
                if (s == 3'b111) next = S3;
                else if (s == 3'b011) next = S23;
                else if (s == 3'b001) next = S21;
                else next = S23;
            end

            S32: begin
                if (s == 3'b111) next = S3;
                else if (s == 3'b011) next = S32;
                else if (s == 3'b001) next = S21;
                else next = S32;
            end

            S12: begin
                if (s == 3'b011) next = S23;
                else if (s == 3'b001) next = S12;
                else if (s == 3'b000) next = S1;
                else next = S12;
            end

            S21: begin
                if (s == 3'b011) next = S23;
                else if (s == 3'b001) next = S21;
                else if (s == 3'b000) next = S1;
                else next = S21;
            end

            S1: begin
                if (s == 3'b000) next = S1;
                else if (s == 3'b001) next = S12;
                else next = S1;
            end

            default: next = S1;

        endcase
    end

    always @(*) begin
		case(state)
			S1  : {fr3, fr2, fr1, dfr} = 4'b1111;
			S21 : {fr3, fr2, fr1, dfr} = 4'b0111;
			S12 : {fr3, fr2, fr1, dfr} = 4'b0110;
			S32 : {fr3, fr2, fr1, dfr} = 4'b0011;
			S23 : {fr3, fr2, fr1, dfr} = 4'b0010;
			S3  : {fr3, fr2, fr1, dfr} = 4'b0000;
			default : {fr3, fr2, fr1, dfr} = 4'bxxxx;
		endcase
	end

endmodule
