module MIPS_datapath
(
    input clk,
    input rst,
    //signals from external world for first writing in I-cache
    input [31:0] IData_in,
    input [31:0] IAddr_in,
    input icache_we,
    //signals from external world for first writing in D-cache
    input [31:0] DData_in,
    input [31:0] DAddr_in,
    input dcache_we, /*Future use*/
    //input from controller
    //for IF stage (stage 1)
    input select_jumpD,
    //for ID stage (stage 2)
    input RegWrite,
    //for EX stage (stage 2)
    input RegDst,
    input [2:0] ALUOp,
    input ALUsrc,
    input Slt_select,
    input shift_or_not, // 1 for shift operations, 0 for arithmetic/logical operations
    input shift_direction, // 0 for left shift, 1 for right shift
    //for MA stage (stage 3)
    input MemWrite,
    input MemRead,
    input BranchD, // Branch control signal
    //for WB stage (stage 4)
    input MemtoReg,
    // Goint to the control unit
    output [5:0] opcode,
    output [5:0] funct, // Function field for R-type instructions
    // From hazard input signals to datapath:
    input StallF,         // Stall Fetch stage
    input StallD,         // Stall Decode stage
    input FlushE,         // Flush Execute stage
    input FlushD,         // Flush Fetch stage (for control hazards)
    input ForwardAD,      // Forward control for operand A in Decode
    input ForwardBD,      // Forward control for operand B in Decode
    input [1:0] ForwardAE, // Forward control for operand A in Execute
    input [1:0] ForwardBE,  // Forward control for operand B in Execute
    input start,
    // Datapath Output for the hazard control:
    output [4:0] RsE,
    output [4:0] RsD,
    output [4:0] RtD,
    output [4:0] RtE, //same as RtE
    output RegWriteE,
    output MemtoRegE,
    output RegWriteM,
    output MemtoRegM,
    output RegWriteW,
    output [4:0] WriteRegE,
    output [4:0] WriteRegM,
    output [4:0] WriteRegW
);

//-------------stage 1 Instruction Fetch-------------------start----------------------------------------------------start------
//-----------------------------------------------------------------------------------------------------------------------------
wire [31:0] pc_out;

//program counter 
program_counter #(
    .WIDTH(32)
) pc (
    .clk(clk),
    .rst(rst),
    .PC_load((~StallF) & start),
    .Nxt_Inst_Addr(mux1_out_to_pc),
    .Curr_Inst_Addr(pc_out)
);
//mux number 1
wire select_jumpD;
wire [31:0] mux1_out_to_pc;
wire [63:0] mux1_in;// Adjusted to match the input width of individual inputs of mux_2x1
wire [31:0] conc_for_jump; // Concatenated input for jump mux
wire [31:0] icache_rdata; // Output from instruction cache --> this will go to pipeline register
assign conc_for_jump = {IDstage_PC_plus4[31:28] , instruction[25:0] , 2'b00}; // Concatenate upper bits of PC with lower bits of jump address
assign mux1_in = {conc_for_jump,mux0_out};
//1st mux
mux_nx1 #(
    .N(2),
    .WIDTH(32)
) mux1 (
    .in(mux1_in),
    .sel(select_jumpD),
    .out(mux1_out_to_pc)
);
//Instruction Memory
//register_file #(
//    .DATA_WIDTH(32),
//    .ADDR_WIDTH(32),
//    .NUM_READ_PORTS(1),
//    .NUM_WRITE_PORTS(1)
//) I_cache (
//    .clk(clk),
//    .rst(rst),
//    .MemRead(1), // Read enable for instruction cache
//    .we(icache_we),
//    .waddr(IAddr_in),
//    .wdata(IData_in),
//    .raddr(pc_out),
//    .rdata(icache_rdata)
//);
register_file #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(8),      // 256 instruction slots
    .NUM_READ_PORTS(1),
    .NUM_WRITE_PORTS(1)
) I_cache (
    .clk(clk),
    .rst(rst),
    .MemRead(1), // Always read
    .we(icache_we),
    .waddr(IAddr_in[7:0]),  // Word address 
    .wdata(IData_in),
    .raddr(pc_out[7:0]),    // Word address
    .rdata(icache_rdata)
);
wire [31:0] PC_plus4; // Output from the adder--> also input to the pipeline register
adder #(
    .WIDTH(32) // ---------------------------------> width of PC out is 8 then adder ka width bhi 8 hona chaiye??????
) adder_in_IF_stage (
    .a(pc_out),
    .b(32'd1), // ----------------------------------> iska bhi width 8 hona chaiye?????
    .sum(PC_plus4)
);

wire [31:0] mux0_out;
wire [63:0] mux0_in; // Adjusted to match the input width of individual inputs of mux_2x1
assign mux0_in = {PCBranchD, PC_plus4}; //when sel is 0 the PC_plus4 is selected 
//mux number 0    
mux_nx1 #(
    .N(2),
    .WIDTH(32)
) mux0 (
    .in(mux0_in),
    .sel(PCSrc),// PCSrc= 1 for branching, 0 for normal operation
    .out(mux0_out)
);
//-----------------------------------------------------------------------------------------------------------------------
//-------------stage 1 Instruction Fetch-------------------end-------------------------------------------------end-------

//======================================================================================================================
//
//======================================================================================================================
//======================================================================================================================
//pipeline register between IF and ID stages------start
// 2input to this pipeline register1-> PC_plus4[31:0], icache_rdata[31:0], EN_to_pipelineReg1(from_HazardControl)
wire [31:0] IDstage_PC_plus4; // Output from the adder
wire [31:0] instruction ; // Output from instruction cache
pipeline_register #(
    .DATA_WIDTH(64),
    .CTRL_WIDTH(0)
) pipeline_reg1 (
    .clk(clk),
    .reset(rst | FlushD), // Reset or flush the pipeline register
    .stall(StallD | (~start)), // Stall signal from hazard unit
    .data_in({PC_plus4, icache_rdata}), // Concatenated input data
    .data_out({IDstage_PC_plus4, instruction}) // Output to decode stage
);
//======================================================================================================================
//======================================================================================================================
//pipeline register between IF and ID stages------end

//-------------stage 2 Instruction Decode-------------------start----------------------------------------------------start------
//------------------------------------------------------------------------------------------------------------------------------
wire [31:0] rs_data; // Data read from register file for rs -->go to 2nd pipeline register
wire [31:0] rt_data; // Data read from register file for rt -->go to 2nd pipeline register 
wire [4:0] RsD;
wire [4:0] RtD;
wire [4:0] RdD;
assign RsD = instruction[25:21]; // Extract rs field from instruction
assign RtD = instruction[20:16]; // Extract rt field from instruction
assign RdD = instruction[15:11]; // Extract rd field from instruction

assign opcode = instruction[31:26]; // Extract opcode from instruction
assign funct = instruction[5:0]; // Extract function code for R-type instructions

register_file #(
    .ADDR_WIDTH(5),
    .DATA_WIDTH(32),
    .NUM_READ_PORTS(2), // Two read ports for rs and rt
    .NUM_WRITE_PORTS(1) // One write port for rd
) reg_file (
    .clk(clk),
    .rst(rst),
    .MemRead(1), // Read enable for register file
    .we(RegWriteW), // Write enable signal
    .waddr(WriteRegW), // Write address
    .wdata(ResultW), // Write data
    .raddr({instruction[25:21], instruction[20:16]}), // Read addresses for rs and rt
    .rdata({rs_data, rt_data}) // Read data outputs
);

// Because both represent same thing, we can use one of them
// Declare a wire to connect the two signals


/*---------------------------------> mux1 of size [2:1] for ForwardAD (rs forwarding in decode) */
wire [31:0] rs_data_forwarded; 
// Forwarded data for rs into pipeline register2 =>on ForwardAD=1 output will go into comparator, => on ForwardAD=0 output will go into pipeline register2
wire [63:0] forwardAD_mux_in;
assign forwardAD_mux_in = {ALUOutM_forwarded, rs_data}; // Forward from Memory or use register data
mux_nx1 #(
    .N(2),
    .WIDTH(32)
) forwardAD_mux (
    .in(forwardAD_mux_in),
    .sel(ForwardAD),// ForwardAD=1 => ALUOutM_forwarded will be selected as rs_data_forwarded,ForwardAD=0 => rs_data will be selected as rs_data_forwarded
    .out(rs_data_forwarded)
);

/*---------------------------------> mux2 of size [2:1] for ForwardBD (rt forwarding in decode) */
wire [31:0] rt_data_forwarded; // this data will go into pipeline register2 on ForwardBD=1
wire [63:0] forwardBD_mux_in;
wire [31:0] ALUOutM_forwarded;
assign      ALUOutM_forwarded = ALUOutM; // Copy ALU output to be forwarded from the memory stage
assign forwardBD_mux_in = {ALUOutM_forwarded, rt_data}; // Forward from Memory or use register data
mux_nx1 #(
    .N(2),
    .WIDTH(32)
) forwardBD_mux (
    .in(forwardBD_mux_in),
    .sel(ForwardBD),// ForwardBD=1 => use ALUOutM_forwarded as rt_data_forwarded , ForwardBD=0 => use rt_data as rt_data_forwarded
    .out(rt_data_forwarded)
);
// Branch equality comparator in decode stage
wire EqualD;  // Output from the branch equality comparator --> go to and gate
assign EqualD = (rs_data_forwarded == rt_data_forwarded);
// 
wire PCSrc;
wire BranchD;
assign PCSrc = BranchD & EqualD; // AND GATE: Branch taken if BranchD=1 i.e. it can execute beq

wire [31:0] sign_extended_data; // Output from the sign extender --> go to 2nd pipeline register
sign_extender #(.IN_WIDTH(16), .OUT_WIDTH(32)) sign_extend (
    .in(instruction[15:0]), // Input from instruction
    .out(sign_extended_data) // Output to be used in ALU or other components
);

// -----------------------------------------------------------------------------> Branch unit:
wire [31:0] sign_extended_data_Dstage; // Copied Output from sign extender
assign sign_extended_data_Dstage = sign_extended_data; // Output from sign extender
wire [31:0] shifted_sign_extended_data_Dstage; // Output from barrel shifter

barrel_shifter #(.WIDTH(32),.SHIFT_WIDTH(2)) barrel_shifter (
    .data_in(sign_extended_data_Dstage), // Input data to be shifted
    .shift_amt(0), // Shift amount from instruction
    .shift_val(0),
    .dir(0),
    .data_out(shifted_sign_extended_data_Dstage) // Output shifted data
);
wire [31:0] PCBranchD; // Output from adder for branch address
adder #(
    .WIDTH(32)
) adder_in_Decode_stage (
    .a(IDstage_PC_plus4), 
    .b(shifted_sign_extended_data_Dstage), 
    .sum(PCBranchD) // Output branch address
);

//------------------------------------------------------------------------------------------------------------------------------
//-------------stage 2 Instruction Decode-------------------end-------------------------------------------------end-------------


//======================================================================================================================
//======================================================================================================================
//pipeline register between ID and EX stages------statrt
// 7input to this pipeline register2 and 3 control inputs-> 

// rs and rt are the data output from pipeline register2 in which forwarded data coming from ID stage muxes whose outputs are connected to pipeline register2
wire [31:0] rs; 
wire [31:0] rt;
wire [31:0] sign_extended_data_EXstage; // Output from sign extender
wire [4:0] RsE;
wire [4:0]  Rtype_waddr;
wire [4:0]  Itype_waddr;
pipeline_register #(
    .DATA_WIDTH(111),
    .CTRL_WIDTH(12)
) pipeline_reg2 (
    .clk(clk),
    .reset(rst | FlushE), // Reset or flush the pipeline register
    .stall(0), // Enable signal=~stall=1 for the pipeline register 
    .data_in({rs_data_forwarded,rt_data_forwarded,sign_extended_data,RsD,RtD,RdD}), // rs_data_forwarded,rt_data_forwarded from ID stage from forwardAD_mux and forwardBD_mux
    .control_in({RegWrite,MemtoReg,MemWrite,MemRead,RegDst, ALUOp, ALUsrc, Slt_select,shift_or_not, shift_direction}),
    .data_out({rs, rt, sign_extended_data_EXstage,RsE, Itype_waddr, Rtype_waddr}), 
    .control_out({RegWriteE, MemtoRegE, MemWriteE, MemReadE,RegDstE, ALUOpE, ALUsrcE, Slt_selectE,shift_or_notE,shift_directionE}) // Output to ID stage
);
// Writeback and Memory stage signals
wire RegWriteE; // Unpacked control signal for register write
wire MemtoRegE; // Unpacked control signal for memory   to register
wire MemWriteE; // Unpacked control signal for memory   write
wire MemReadE;  // Unpacked control signal for memory   read
assign RtE = Itype_waddr;
// Execute Stage signals
wire RegDstE; // Unpacked control signal for register destination
wire [2:0] ALUOpE; // Unpacked control signal for ALU
wire ALUsrcE; // Unpacked control signal for ALU source
wire Slt_selectE; // Unpacked control signal for SLT selection
wire shift_or_notE;
wire shift_directionE; // Unpacked control signal for shift direction

//pipeline register between ID and EX stages------end
//======================================================================================================================
//======================================================================================================================

//-------------stage 3 Execute-------------------start----------------------------------------------------start------
//-------------------------------------------------------------------------------------------------------------------
wire [4:0] WriteRegE; // Output write address for register file
//mux3 -> this mux is used to select the destination register in Execute stage correctly for I type and R type instructions of MIPS32 from the signal coming from control unit RegDestE
mux_nx1 #(
    .N(2),
    .WIDTH(5)
) mux3 (
    .in({Rtype_waddr,Itype_waddr}),
    .sel(RegDstE), 
    .out(WriteRegE) // Output write address for register file
);

//----------------------------------------------------------------------------> ForwardAE ForwardBE muxes
/*---------------------------------> mux1 of size [3:1] with select line- ForwardAE*/
wire [31:0] ALU_input_A;
wire [95:0] forwardAE_mux_in;
assign forwardAE_mux_in = {ALUOutM_forwarded,ResultW,rs}; 
mux_nx1 #(
    .N(3),
    .WIDTH(32)
) forwardAE_mux (
    .in(forwardAE_mux_in),
    .sel(ForwardAE), //ForwardAE-> 00-rs, 01-ResultW, 10-ALUOutM_forwarded <- from hazard detection for forwarding selection in execute stage
    .out(ALU_input_A)
);
/*---------------------------------> mux2 of size [3:1] with select line ForwardBE*/
wire [31:0] input_to_mux2; // from forwardBE_mux[3:1] to mux2[2:1]
wire [95:0] forwardBE_mux_in;
assign forwardBE_mux_in = {ALUOutM_forwarded,ResultW,rt}; 
mux_nx1 #(
    .N(3),
    .WIDTH(32)
) forwardBE_mux (
    .in(forwardBE_mux_in),
    .sel(ForwardBE), // ForwardBE-> 00-rt, 01-ResultW, 10-ALUOutM_forwarded <- from hazard detection for forwarding selection in execute stage
    .out(input_to_mux2) 
);
wire [31:0] WriteDataE; // Output write data for register file
assign WriteDataE = input_to_mux2;

wire [31:0] ALU_input_B; // Output write data for ALU

mux_nx1 #(
    .N(2),
    .WIDTH(32)
) mux2 (
    .in({input_to_mux2,sign_extended_data_EXstage}),
    .sel(~ALUsrcE), // ALUsrcE-> 1 - input_to_mux2 will be selected, 0(sel) - sign_extended_data_EXstage <- from sign extender in execute stage
    .out(ALU_input_B) // Output write data for register file
    // so eaither rt or ResultW from writeback or ALUOutM from Memory stage or sign_extended_data_EXstage will go into ALU through mux2
);

wire [31:0] ALU_result; // Output from ALU
wire ALU_carry; // Carry output from ALU
wire ALU_overflow; // Overflow output from ALU  
wire ALU_zero; // Zero output from ALU
wire ALU_parity; // Parity output from ALU

//here is the ALU--> main heart of the datapath
alu #(
     .WIDTH (32) 
) ALU(
  .a(ALU_input_A),
  .b(ALU_input_B),
  .alu_op(ALUOpE), // 3-bit control: 000=add, 001=sub, 010=mul, 011=div, others=NOP
  .result(ALU_result),
  .carry(ALU_carry),
  .overflow(ALU_overflow),//although we are not using currently ALU_overflow
  .zero(ALU_zero),
  .parity(ALU_parity), //although we are not using currently ALU_parity 
  .shift_amt(sign_extended_data_EXstage[10:6]), // Shift amount for shift operations
  .dir(shift_directionE), // Direction: 0 for left shift, 1 for right shift
  .shift_or_not(shift_or_notE) // 1 for shift operations, 0
);

//mux number 4
wire [31:0] final_ALU_result; // Output write data for register file
mux_nx1 #(
    .N(2),
    .WIDTH(32)
) mux4 (
    .in({{31'd0,ALU_carry}, ALU_result}), //specificay for SLT instruction
    .sel(Slt_selectE), 
    .out(final_ALU_result) // Output write data for register file
);


//------------------------------------------------------------------------------------------------------------------------------
//-------------stage 3 Execute-------------------end-------------------------------------------------end-------------


//======================================================================================================================
//======================================================================================================================
//pipeline register between EX and MA stages------statrt
// 4 Data input to this pipeline register3 and 2 control inputs-> 
wire zero; // Zero output from ALU
wire [31:0] WriteDataM; // Output write data for register file from execute stage
wire [31:0] data_to_Dcache; 
wire [31:0] ALUOutM; 
wire [4:0]  WriteRegM;
pipeline_register #(
    .DATA_WIDTH(69),
    .CTRL_WIDTH(5)
) pipeline_reg3 (
    .clk(clk),
    .reset(rst),
    .stall(0), // Enable signal=1 for the pipeline register
    .data_in({ALU_zero,final_ALU_result,WriteDataE,WriteRegE}), // Concatenated input data
    .control_in({RegWriteE, MemtoRegE, MemWriteE, MemReadE}), // No control signals needed for this register
    .data_out({zero , ALUOutM, WriteDataM, WriteRegM}), // Output to
    .control_out({RegWriteM, MemtoRegM, MemWriteM, MemReadM}) // Output to ID stage
);
wire RegWriteM;
wire MemtoRegM;
wire MemWriteM;
wire MemReadM;

//pipeline register between EX and MA stages------end
//======================================================================================================================
//======================================================================================================================


//-------------stage 4 Memory Access-------------------start----------------------------------------------------start------
//------------------------------------------------------------------------------------------------------------------------------
wire [31:0] Dcache_read_data; // Output from data cache
register_file #(
    .ADDR_WIDTH(8), // 256 data slots
    .DATA_WIDTH(32),
    .NUM_READ_PORTS(1), // one address port for both read and write; address is given if MemWriteM=1 then data-> WriteDataM will be written , if MemReadM=1 then data-> Dcache_read_data will be read and if MemReadM=0 AND MemWriteM=0  then neither read nor write operation will be performed
    .NUM_WRITE_PORTS(1)
) D_cache (
    .clk(clk),
    .rst(rst),
    .MemRead(MemReadM), // Memory read enable
    .we(MemWriteM), // Write enable signal
    .waddr(ALUOutM[7:0]), // Write address (lower 8 bits of ALUOutM)
    .wdata(WriteDataM), // Write data
    .raddr(ALUOutM[7:0]), // HERE WE CAN SEE THE Read address and the write addresses are the same for our datacache.
    .rdata(Dcache_read_data) // Read data outputs
);

//------------------------------------------------------------------------------------------------------------------------------
//-------------stage 2 Memory Access-------------------end-------------------------------------------------end-------------


//======================================================================================================================
//======================================================================================================================
//pipeline register between MA and WB stages------statrt
// 4 Data input to this pipeline register3 and 2 control inputs-> 
wire [4:0] WriteRegW;
pipeline_register #(
    .DATA_WIDTH(69),
    .CTRL_WIDTH(2)
) pipeline_reg4 (
    .clk(clk),
    .reset(rst),
    .stall(0), 
    .data_in({Dcache_read_data,ALUOutM,WriteRegM}), // Concatenated input data
    .control_in({RegWriteM, MemtoRegM}), 
    .data_out({ReadDataW,ALUOutW,WriteRegW}), // Output to
    .control_out({RegWriteW,MemtoRegW}) 
);
wire RegWriteW; // Unpacked control signal for register write
wire MemtoRegW; // Unpacked control signal for memory to register
//pipeline register between MA and WB stages------end
//======================================================================================================================
//======================================================================================================================


//-------------stage 5 Write Back-------------------start----------------------------------------------------start------
//------------------------------------------------------------------------------------------------------------------------------
wire [31:0] ReadDataW; // Output from data cache
wire [31:0] ALUOutW; // Output from data cache 
wire [31:0] ResultW; // Output write data for register file from writeback stage   
//mux number 5
mux_nx1 #(
    .N(2),
    .WIDTH(32)
) mux5 (
    .in({ReadDataW, ALUOutW}), // Input data for mux
    .sel(MemtoRegW), // Select signal for mux- MemtoRegW-1: data from Dcache(ReadDataW) for lw(load word) instruction, 0(sel): ALUOutW <- from ALU for ALU instruction like R type add/addi/slt/sll/mul/sub etc which envolve storing in register file after execution.
    .out(ResultW) // Output write data for register file
);
//-------------stage 5 Write Back-------------------end----------------------------------------------------end------
//------------------------------------------------------------------------------------------------------------------------------

endmodule