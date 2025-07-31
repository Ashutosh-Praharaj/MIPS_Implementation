module pipeline_register #(
    parameter DATA_WIDTH    = 138 ,   // Width of data signal
    parameter CTRL_WIDTH    = 15      // Width of control signal
)(
    input  wire  clk,
    input  wire  reset,
    input  wire  stall,

    input  wire [DATA_WIDTH-1:0]   data_in,     // Flattened vector
    input  wire [CTRL_WIDTH-1:0]   control_in,  // Flattened vector

    output reg  [DATA_WIDTH-1:0]   data_out,
    output reg  [CTRL_WIDTH-1:0]   control_out
);

    always @(posedge clk) begin
        if (reset) begin
            data_out    <= 0;
            control_out <= 0;
        end else if (~stall) begin
            data_out     <= data_in;
            control_out  <= control_in;
        end
        // else: retain previous values (stall)
    end

endmodule


