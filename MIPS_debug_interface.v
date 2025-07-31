// Enhanced datapath interface module (if you want to add more debugging features)
module MIPS_debug_interface (
    input clk,
    input rst,
    input [31:0] current_instruction,
    input [5:0] opcode,
    
    // Debug outputs
    output reg [127:0] instruction_name,
    output reg [31:0] instruction_count,
    output reg [31:0] cycle_count
);

// Instruction name lookup for debugging
always @(*) begin
    case (opcode)
        6'b000000: begin
            case (current_instruction[5:0])
                6'b100000: instruction_name = "ADD     ";
                6'b100010: instruction_name = "SUB     ";
                6'b100100: instruction_name = "AND     ";
                6'b100101: instruction_name = "OR      ";
                6'b101010: instruction_name = "SLT     ";
                6'b100110: instruction_name = "XOR     ";
                6'b000000: instruction_name = "SLL     ";
                6'b000010: instruction_name = "SRL     ";
                default:   instruction_name = "R-TYPE  ";
            endcase
        end
        6'b001000: instruction_name = "ADDI    ";
        6'b001100: instruction_name = "ANDI    ";
        6'b001101: instruction_name = "ORI     ";
        6'b001010: instruction_name = "SLTI    ";
        6'b100011: instruction_name = "LW      ";
        6'b101011: instruction_name = "SW      ";
        6'b000100: instruction_name = "BEQ     ";
        6'b000101: instruction_name = "BNE     ";
        6'b000010: instruction_name = "J       ";
        default:   instruction_name = "UNKNOWN ";
    endcase
end

// Cycle and instruction counters
always @(posedge clk or posedge rst) begin
    if (rst) begin
        instruction_count <= 32'd0;
        cycle_count <= 32'd0;
    end else begin
        cycle_count <= cycle_count + 1;
        if (opcode != 6'b000000 || current_instruction[5:0] != 6'b000000) begin
            instruction_count <= instruction_count + 1;
        end
    end
end

endmodule