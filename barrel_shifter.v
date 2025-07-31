module barrel_shifter #(
    parameter WIDTH = 32,         // Data width
    parameter SHIFT_WIDTH = 5     // Width of shift amount (log2(WIDTH) for full range)
) (
    input  [WIDTH-1:0] data_in,   // Data input
    input  [SHIFT_WIDTH-1:0] shift_amt, // Shift amount
    input  shift_val,             // Value to shift in (0 or 1)
    input  dir,                   // 0: left shift, 1: right shift
    output reg [WIDTH-1:0] data_out
);
    integer i;
    always @(*) begin
        if (dir == 0) begin // Left shift
            data_out = (data_in << shift_amt) | ({WIDTH{shift_val}} >> (WIDTH-shift_amt));
        end else begin // Right shift
            data_out = (data_in >> shift_amt) | ({WIDTH{shift_val}} << (WIDTH-shift_amt));
        end
    end
endmodule

// 01010100101001 

// 10100101001000
// 00000000000111 

// 10100101001111

// 00000000000000
// 00000000000000

// 11111111111111
// 00000000000111
