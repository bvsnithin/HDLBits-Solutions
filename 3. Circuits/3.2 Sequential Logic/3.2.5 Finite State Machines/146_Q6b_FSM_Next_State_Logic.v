module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    assign Y2 = (y==B & ~w) | (y==F & ~w) | (y==B & w) | (y==C & w) | (y==E & w) | (y==F & w); 

endmodule
