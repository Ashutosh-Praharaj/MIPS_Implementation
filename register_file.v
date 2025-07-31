module register_file #(
    parameter ADDR_WIDTH = 5,      // Address width (log2 of number of registers)
    parameter DATA_WIDTH = 32,     // Data width
    parameter NUM_READ_PORTS = 2,  // Number of read ports
    parameter NUM_WRITE_PORTS = 1  // Number of write ports
) (
    input clk,
    input rst, // synchronous reset
    input MemRead, // Memory read enable
    input [NUM_WRITE_PORTS-1:0] we, // Write enable for each write port
    input [NUM_WRITE_PORTS*ADDR_WIDTH-1:0] waddr, // Write addresses
    input [NUM_WRITE_PORTS*DATA_WIDTH-1:0] wdata, // Write data
    input [NUM_READ_PORTS*ADDR_WIDTH-1:0] raddr,  // Read addresses
    output [NUM_READ_PORTS*DATA_WIDTH-1:0] rdata  // Read data
);
    localparam NUM_REGS = 1 << ADDR_WIDTH;// 100000---> 32 registers
    reg [DATA_WIDTH-1:0] regs [0:NUM_REGS-1];
    integer j;

    // Combinational read
    generate
        genvar rp;
        for (rp = 0; rp < NUM_READ_PORTS; rp = rp + 1) begin : READ_PORTS
            assign rdata[rp*DATA_WIDTH +: DATA_WIDTH] = MemRead ?
                regs[raddr[rp*ADDR_WIDTH +: ADDR_WIDTH]] : {DATA_WIDTH{1'b0}};
        end
    endgenerate


    // Sequential write
    always @(posedge clk) begin
        if (rst) begin
            for (j = 0; j < NUM_REGS; j = j + 1)
                regs[j] <= {DATA_WIDTH{1'b0}};
        end else begin
            for (j = 0; j < NUM_WRITE_PORTS; j = j + 1) begin
                if (we[j])
                    regs[waddr[j*ADDR_WIDTH +: ADDR_WIDTH]] <= wdata[j*DATA_WIDTH +: DATA_WIDTH];
            end
        end
    end
endmodule


