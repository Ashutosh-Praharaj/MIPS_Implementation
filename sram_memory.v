module sram_memory #(
    parameter DATA_WIDTH = 32,   // Width of each memory word
    parameter ADDR_WIDTH = 8     // Width of address bus (number of locations = 2^ADDR_WIDTH)
) (
    input wire clk,
    input wire rst,
    input wire we,                      // Write enable
    input wire [ADDR_WIDTH-1:0] addr,   // Address
    input wire [DATA_WIDTH-1:0] din,    // Data input
    output reg [DATA_WIDTH-1:0] dout    // Data output
);
    localparam MEM_DEPTH = 1 << ADDR_WIDTH;
    reg [DATA_WIDTH-1:0] mem [0:MEM_DEPTH-1];
    integer i;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < MEM_DEPTH; i = i + 1)
                mem[i] <= {DATA_WIDTH{1'b0}};
            dout <= {DATA_WIDTH{1'b0}};
        end else begin
            if (we)
                mem[addr] <= din;
            dout <= mem[addr];
        end
    end
endmodule
