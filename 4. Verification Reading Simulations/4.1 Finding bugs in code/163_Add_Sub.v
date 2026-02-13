// synthesis verilog_input_version verilog_2001
module top_module ( 
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);//
    always @(*) begin
        result_is_zero = 1;
        case (do_sub)
          0: out = a+b;
          1: out = a-b;
        endcase
		
        // Add reduction or operator
        if (|out)
            result_is_zero = 0;
    end

endmodule

