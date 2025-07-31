module sign_extender #(
    parameter IN_WIDTH = 8,   // Input width
    parameter OUT_WIDTH = 16  // Output width (must be >= IN_WIDTH)
) (
    input  [IN_WIDTH-1:0] in,
    output [OUT_WIDTH-1:0] out
);
    assign out = {{(OUT_WIDTH-IN_WIDTH){in[IN_WIDTH-1]}}, in};
endmodule

