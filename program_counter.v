module program_counter #(
    parameter WIDTH = 32
) (
    input clk,
    input rst, // synchronous reset
    input PC_load,
    input [WIDTH-1:0] Nxt_Inst_Addr,
    output reg [WIDTH-1:0] Curr_Inst_Addr
);
    always @(posedge clk) begin
        if (rst)
            Curr_Inst_Addr <= {WIDTH{1'b0}};
        else if (PC_load)
            Curr_Inst_Addr <= Nxt_Inst_Addr;
    end
endmodule
