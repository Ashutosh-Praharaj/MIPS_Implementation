module mux_nx1 #(
    parameter N = 2,           // Number of inputs
    parameter WIDTH = 8        // Width of each input
) (
    input  [N*WIDTH-1:0] in,   // Concatenated input bus
    input  [$clog2(N)-1:0] sel,//select signal or control signal
    output reg [WIDTH-1:0] out
);
    integer i;
    always @(*) begin
        out = {WIDTH{1'b0}};//initialize output to zero
        // Select the appropriate input based on the sel signal
        for (i = 0; i < N; i = i + 1) begin
            if (sel == i)
                out = in[i*WIDTH +: WIDTH];
        end
    end
endmodule

// in1-----00|\
// in2-----10| \  N=4,Width=8
// in3-----11| /--------out
// in4-----01|/|
//             |
//             |
//            sel 
           
// 01011001_01001010_10010100_10101001_01001010
// 39                                         0

//reg to wire conversion




