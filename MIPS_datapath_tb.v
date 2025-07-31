`timescale 1ns/1ps

module MIPS_top_tb;

//=============================================================================
// TESTBENCH SIGNALS
//=============================================================================

// Clock and Reset
reg clk = 0;
reg rst;

// External instruction loading interface
reg [31:0] IData_in;
reg [31:0] IAddr_in;
reg icache_we;

// External data loading interface
reg [31:0] DData_in;
reg [31:0] DAddr_in;
reg dcache_we;

// Control interface
reg start;

// Status outputs
wire processor_running;
wire [31:0] current_pc;
wire [31:0] current_instruction;

//=============================================================================
// INSTANTIATE UNIT UNDER TEST
//=============================================================================

MIPS_top uut (
    .clk(clk),
    .rst(rst),
    
    // External instruction loading interface
    .IData_in(IData_in),
    .IAddr_in(IAddr_in),
    .icache_we(icache_we),
    
    // External data loading interface
    .DData_in(DData_in),
    .DAddr_in(DAddr_in),
    .dcache_we(dcache_we),
    
    // Control interface
    .start(start),
    
    // Status outputs
    .processor_running(processor_running),
    .current_pc(current_pc),
    .current_instruction(current_instruction)
);

//=============================================================================
// CLOCK GENERATION
//=============================================================================

always #5 clk = ~clk; // 10ns period = 100MHz clock

initial begin
   rst=1;
   start =0;
   #10
   rst=0;
   icache_we=1;
   //instruction write: // addi $t0, $zero, 5  => 0x20080005
   IAddr_in=0;//IAddr_in[7:0]  /THIS COULD be started with 1 , without stalling the instruction at the pipeline_register1/
   IData_in=32'h20080005; //001000 00000 01000 0000000000000101/
   
   #10
   IAddr_in=1;
   IData_in=32'h01084820; // add $t1, $t0, $t0  /000000 01000(rs) 01000(rt) 01001(rd) 00000(shampt) 100000/
   #10
   IAddr_in=2;
   IData_in=32'h210AFFFE; // addi $t2, $t0, -2
   #10
   IAddr_in=3; // mul $t3, $t1, $t2; implement similar to Rtype
   IData_in=32'h0149582C; //000000 01010(rs->t2) 01001(t1) 01011(t3) 00000 101100(originally for or instruction)/
   #10
   IAddr_in=4; // sll $t4, $t3, 2   # Shift value in $t3 left by 2 bits, store result in $t4
   IData_in=32'h000B6080; //000000 00000(rs->t1) 01011(rt) 01100(rd->t4) 00010(shampt) 000000/
   #10
   icache_we=0;
   
   
   #20
   start=1;
   #500
   $finish;
end
always @(posedge clk) begin
    // Peek inside register file (assuming you have $display in reg_file)
    $display("t = %0t ns | $t0 = %0d | $t1 = %0d | $t2 = %0d | $t3 = %0d | $t4 = %0d",
             $time,
             uut.datapath_inst.reg_file.regs[8],
             uut.datapath_inst.reg_file.regs[9],
             uut.datapath_inst.reg_file.regs[10],
             uut.datapath_inst.reg_file.regs[11],
             uut.datapath_inst.reg_file.regs[12]);
end
endmodule