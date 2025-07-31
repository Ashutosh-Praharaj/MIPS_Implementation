module hazard_detection_unit (
    
    // From datapath - Register addresses for hazard detection
    input [4:0] RsD,          // Source register 1 in Decode stage
    input [4:0] RtD,          // Source register 2 in Decode stage
    input [4:0] RsE,          // Source register 1 in Execute stage
    input [4:0] RtE,          // Source register 2 in Execute stage (same as Rtype_waddr)
    input [4:0] WriteRegE,    // Destination register in Execute stage
    input [4:0] WriteRegM,    // Destination register in Memory stage
    input [4:0] WriteRegW,    // Destination register in Writeback stage
    
    // Control signals from datapath for hazard detection
    input RegWriteE,          // Register write enable in Execute stage
    input MemtoRegE,          // Memory to register in Execute stage (load instruction)
    input RegWriteM,          // Register write enable in Memory stage
    input MemtoRegM,          // Memory to register in Memory stage
    input RegWriteW,          // Register write enable in Writeback stage
    input BranchD,            // Branch instruction in Decode stage
    input select_jumpD,       // Jump instruction in Decode stage
    
    // Outputs to datapath - Stall and flush controls
    output reg StallF,        // Stall Fetch stage
    output reg StallD,        // Stall Decode stage
    output reg FlushE,        // Flush Execute stage
    output reg FlushD,        // Flush Decode stage (for control hazards)
    
    // Forwarding control outputs
    output reg ForwardAD,     // Forward control for operand A in Decode (for branches)
    output reg ForwardBD,     // Forward control for operand B in Decode (for branches)
    output reg [1:0] ForwardAE, // Forward control for operand A in Execute
    output reg [1:0] ForwardBE  // Forward control for operand B in Execute
);

// Internal signals for hazard detection
wire load_use_hazard;
wire branch_hazard;
wire control_hazard;

//=============================================================================
// LOAD-USE HAZARD DETECTION
//=============================================================================
// Detect when a load instruction in Execute stage creates a dependency
// with an instruction in Decode stage that needs the loaded data
assign load_use_hazard = MemtoRegE && 
                        ((WriteRegE == RsD) || (WriteRegE == RtD)) &&
                        (WriteRegE != 5'b00000); // Not writing to $zero

//=============================================================================
// BRANCH HAZARD DETECTION
//=============================================================================
// Detect when branch instruction needs data that's being computed
assign branch_hazard = BranchD && 
                      (((RegWriteE && (WriteRegE == RsD || WriteRegE == RtD)) ||
                        (MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD))) &&
                       (RsD != 5'b00000 || RtD != 5'b00000));

//=============================================================================
// CONTROL HAZARD DETECTION
//=============================================================================
// Control hazard occurs on any branch or jump
assign control_hazard = BranchD || select_jumpD;

//=============================================================================
// STALL AND FLUSH LOGIC
//=============================================================================
always @(*) begin
    // Default values
    StallF = 1'b0;
    StallD = 1'b0;
    FlushE = 1'b0;
    FlushD = 1'b0;
    
    // Load-use hazard: Stall fetch and decode, flush execute
    if (load_use_hazard) begin
        StallF = 1'b1;
        StallD = 1'b1;
        FlushE = 1'b1;
    end
    
    // Branch hazard: Stall fetch and decode
    else if (branch_hazard) begin
        StallF = 1'b1;
        StallD = 1'b1;
    end
    
    // Control hazard: Flush decode stage (branch/jump taken)
    // This happens when branch condition is resolved or jump is taken
    else if (control_hazard) begin
        FlushD = 1'b1;
    end
end

//=============================================================================
// FORWARDING LOGIC FOR DECODE STAGE (Branch instructions)
//=============================================================================
always @(*) begin
    // Default: No forwarding
    ForwardAD = 1'b0;
    ForwardBD = 1'b0;
    
    // Forward from Memory stage to Decode stage for branch comparisons
    // Forward A operand (Rs)
    if (RegWriteM && (WriteRegM != 5'b00000) && (WriteRegM == RsD)) begin
        ForwardAD = 1'b1;
    end
    
    // Forward B operand (Rt)
    if (RegWriteM && (WriteRegM != 5'b00000) && (WriteRegM == RtD)) begin
        ForwardBD = 1'b1;
    end
end

//=============================================================================
// FORWARDING LOGIC FOR EXECUTE STAGE
//=============================================================================
always @(*) begin
    // Default: No forwarding (use register file data)
    ForwardAE = 2'b00;
    ForwardBE = 2'b00;
    
    //-------------------------------------------------------------------------
    // Forward A operand (Rs) in Execute stage
    //-------------------------------------------------------------------------
    // Priority: Memory stage forwarding over Writeback stage forwarding
    
    // Forward from Memory stage (EX/MEM hazard)
    if (RegWriteM && (WriteRegM != 5'b00000) && (WriteRegM == RsE)) begin
        ForwardAE = 2'b10; // Forward from Memory stage
    end
    // Forward from Writeback stage (MEM/WB hazard)
    else if (RegWriteW && (WriteRegW != 5'b00000) && 
             (WriteRegW == RsE) && 
             !((RegWriteM && (WriteRegM != 5'b00000) && (WriteRegM == RsE)))) begin
        ForwardAE = 2'b01; // Forward from Writeback stage
    end
    
    //-------------------------------------------------------------------------
    // Forward B operand (Rt) in Execute stage
    //-------------------------------------------------------------------------
    // Priority: Memory stage forwarding over Writeback stage forwarding
    
    // Forward from Memory stage (EX/MEM hazard)
    if (RegWriteM && (WriteRegM != 5'b00000) && (WriteRegM == RtE)) begin
        ForwardBE = 2'b10; // Forward from Memory stage
    end
    // Forward from Writeback stage (MEM/WB hazard)
    else if (RegWriteW && (WriteRegW != 5'b00000) && 
             (WriteRegW == RtE) && 
             !((RegWriteM && (WriteRegM != 5'b00000) && (WriteRegM == RtE)))) begin
        ForwardBE = 2'b01; // Forward from Writeback stage
    end
end

//=============================================================================
// END OF MIPS HAZARD CONTROL MODULE
endmodule