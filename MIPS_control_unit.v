module MIPS_control_unit (
    input [5:0] opcode,
    input [5:0] funct,  // Function field for R-type instructions
    
    // Control signals output
    // IF stage
    output reg select_jumpD,
    //below 2 signals are for hazard control
    output reg PC_load,
    output reg EN_to_pipelineReg1,
    
    // ID stage  
    output reg RegWrite,
    
    // EX stage
    output reg RegDst,
    output reg [2:0] ALUOp,
    output reg ALUsrc,
    output reg Slt_select,
    output reg shift_or_not,
    output reg shift_direction,
    
    // MA stage
    output reg MemWrite,
    output reg MemRead,
    output reg branch,
    
    // WB stage
    output reg MemtoReg
);

// Opcode Encodings
parameter OP_RTYPE   = 6'b000000;  // R-type instructions (add, sub, and, or, slt, xor, sll, srl)
parameter OP_ADDI    = 6'b001000;  // Add immediate
parameter OP_ANDI    = 6'b001100;  // AND immediate
parameter OP_ORI     = 6'b001101;  // OR immediate
parameter OP_SLTI    = 6'b001010;  // Set less than immediate
parameter OP_LW      = 6'b100011;  // Load word
parameter OP_SW      = 6'b101011;  // Store word
parameter OP_BEQ     = 6'b000100;  // Branch if equal
parameter OP_BNE     = 6'b000101;  // Branch if not equal
parameter OP_J       = 6'b000010;  // Jump

// Function codes for R-type instructions
parameter FUNC_ADD   = 6'b100000;  // Add
parameter FUNC_SUB   = 6'b100010;  // Subtract
parameter FUNC_AND   = 6'b100100;  // AND
parameter FUNC_OR    = 6'b100101;  // OR
parameter FUNC_SLT   = 6'b101010;  // Set less than
parameter FUNC_XOR   = 6'b100110;  // XOR
parameter FUNC_SLL   = 6'b000000;  // Shift left logical
parameter FUNC_SRL   = 6'b000010;  // Shift right logical
parameter FUNC_MUL   = 6'b101100;  // Multiplication (new, not overlapping)

// ALU Operation encodings
parameter ALU_ADD    = 3'b000;     // Addition
parameter ALU_SUB    = 3'b001;     // Subtraction
parameter ALU_AND    = 3'b100;     // AND
parameter ALU_OR     = 3'b101;     // OR
parameter ALU_XOR    = 3'b110;     // XOR
parameter ALU_SLT    = 3'b101;     // Set less than
parameter ALU_SHIFT  = 3'b110;     // Shift operations
parameter ALU_MUL    = 3'b010;     // Multiplication (use 110 if not used, else 111 if needed)
parameter ALU_NOP    = 3'b111;     // No operation

always @(*) begin
    // Default values - all control signals disabled
    select_jumpD = 1'b0;
    PC_load = 1'b1;              // PC always loads unless hazard detected
    EN_to_pipelineReg1 = 1'b1;   // Pipeline register always enabled unless hazard
    RegWrite = 1'b0;
    RegDst = 1'b0;
    ALUOp = ALU_NOP;
    ALUsrc = 1'b0;
    Slt_select = 1'b0;
    shift_or_not = 1'b0;
    shift_direction = 1'b0;
    MemWrite = 1'b0;
    MemRead = 1'b0;
    branch = 1'b0;
    MemtoReg = 1'b0;
    
    case (opcode)
        OP_RTYPE: begin
            // R-type instructions
            RegWrite = 1'b1;
            RegDst = 1'b1;     // Write to rd (bits [15:11])
            ALUsrc = 1'b0;     // Use register for ALU source B
            
            case (funct)
                FUNC_ADD: begin
                    ALUOp = ALU_ADD;
                end
                
                FUNC_SUB: begin
                    ALUOp = ALU_SUB;
                end
                
                FUNC_AND: begin
                    ALUOp = ALU_AND;
                end
                
                FUNC_OR: begin
                    ALUOp = ALU_OR;
                end
                
                FUNC_XOR: begin
                    ALUOp = ALU_XOR;
                end
                
                FUNC_SLT: begin
                    ALUOp = ALU_NOP;
                    Slt_select = 1'b1;  // Select carry output for SLT result
                end
                
                FUNC_SLL: begin
                    ALUOp = ALU_NOP;
                    shift_or_not = 1'b1;
                    shift_direction = 1'b0;  // Left shift
                end
                
                FUNC_SRL: begin
                    ALUOp = ALU_NOP;
                    shift_or_not = 1'b1;
                    shift_direction = 1'b1;  // Right shift
                end
                
                FUNC_MUL: begin
                    ALUOp = ALU_MUL;
                end
                
                default: begin
                    // Invalid function code - disable write
                    RegWrite = 1'b0;
                    ALUOp = ALU_NOP;
                end
            endcase
        end
        
        OP_ADDI: begin
            // Add immediate
            RegWrite = 1'b1;
            RegDst = 1'b0;     // Write to rt (bits [20:16])
            ALUOp = ALU_ADD;
            ALUsrc = 1'b1;     // Use immediate for ALU source B
        end
        
        OP_ANDI: begin
            // AND immediate
            RegWrite = 1'b1;
            RegDst = 1'b0;     // Write to rt
            ALUOp = ALU_AND;
            ALUsrc = 1'b1;     // Use immediate
        end
        
        OP_ORI: begin
            // OR immediate
            RegWrite = 1'b1;
            RegDst = 1'b0;     // Write to rt
            ALUOp = ALU_OR;
            ALUsrc = 1'b1;     // Use immediate
        end
        
        OP_SLTI: begin
            // Set less than immediate
            RegWrite = 1'b1;
            RegDst = 1'b0;     // Write to rt
            ALUOp = ALU_SLT;
            ALUsrc = 1'b1;     // Use immediate
            Slt_select = 1'b1; // Select carry for SLT result
        end
        
        OP_LW: begin
            // Load word
            RegWrite = 1'b1;
            RegDst = 1'b0;     // Write to rt
            ALUOp = ALU_ADD;   // Calculate memory address
            ALUsrc = 1'b1;     // Use immediate offset
            MemRead = 1'b1;    // Enable memory read
            MemtoReg = 1'b1;   // Write memory data to register
        end
        
        OP_SW: begin
            // Store word
            RegWrite = 1'b0;   // Don't write to register file
            ALUOp = ALU_ADD;   // Calculate memory address
            ALUsrc = 1'b1;     // Use immediate offset
            MemWrite = 1'b1;   // Enable memory write
        end
        
        OP_BEQ: begin
            // Branch if equal
            RegWrite = 1'b0;   // Don't write to register file
            ALUOp = ALU_SUB;   // Subtract to check equality
            ALUsrc = 1'b0;     // Use register for comparison
            branch = 1'b1;     // Enable branch logic
        end
        
        OP_BNE: begin
            // Branch if not equal
            RegWrite = 1'b0;   // Don't write to register file
            ALUOp = ALU_SUB;   // Subtract to check equality
            ALUsrc = 1'b0;     // Use register for comparison
            branch = 1'b1;     // Enable branch logic
            // Note: BNE logic will need to invert the zero flag
        end
        
        OP_J: begin
            // Jump
            RegWrite = 1'b0;   // Don't write to register file
            select_jumpD = 1'b1; // Select jump address for PC
        end
        
        default: begin
            // Invalid opcode - all control signals remain at default (disabled)
            // This creates a NOP-like behavior
        end
    endcase
end

endmodule



// End of MIPS_control_unit module
// This module implements the control unit for a MIPS processor, generating control signals based on the opcode and function code of the instruction.
// It handles R-type, I-type, and J-type instructions, setting appropriate control signals for each stage of the pipeline (IF, ID, EX, MA, WB).
// The control signals include register write enable, ALU operation selection, memory read/write control,