module alu #(
    parameter WIDTH = 32
) (
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    input  [2:0] alu_op, // 4-bit control: 0000=add, 0001=sub, 0010=mul, 0011=div, 0100=and, 0101=or, 0110=xor, others=NOP
    input  [4:0] shift_amt, // Shift amount for shift operations
    input  dir, // Direction: 0 for left shift, 1 for right shift
    input  shift_or_not, // 1 for shift operations, 0 for arithmetic/logical operations
    output reg [WIDTH-1:0] result,
    output reg carry,
    output reg overflow,
    output reg zero,
    output reg parity
);
    wire [WIDTH:0] result_int;
    barrel_shifter #(.DATA_WIDTH(32), .SHIFT_WIDTH(5)) barel_shifter (
        .data_in({b[WIDTH-1],b}),
        .shift_amt(shift_amt), // Assuming b[4:0] is the shift amount
        .shift_val(1'b0), // No shift value for this example
        .dir(dir), // Left shift
        .data_out(result_int) // Output will be used in some operations
    );
   
    reg [WIDTH:0] tmp_add;
    reg [WIDTH-1:0] tmp_sub;
    reg [2*WIDTH-1:0] tmp_mul;
    reg [WIDTH-1:0] tmp_div;
    integer i;

    always @(*) begin
        carry = 0;
        overflow = 0;
        zero = 0;
        parity = 0;
        result = 0;
        if (shift_or_not) begin //Shif
            result = result_int; // Use the barrel shifter output for shift operations
            carry = result_int[WIDTH]; // Carry for shift operations
            overflow = 0; // No overflow in shifts
        end
        else begin
            case (alu_op)
                3'b000: begin // ADD
                    tmp_add = a + b;
                    result = tmp_add[WIDTH-1:0];
                    carry = tmp_add[WIDTH];
                    overflow = (a[WIDTH-1] == b[WIDTH-1]) && (result[WIDTH-1] != a[WIDTH-1]);
                end
                3'b001: begin // SUB
                    tmp_sub = a - b;
                    result = tmp_sub;
                    carry = (a < b);
                    overflow = (a[WIDTH-1] != b[WIDTH-1]) && (result[WIDTH-1] != a[WIDTH-1]);
                end
                3'b010: begin // MUL
                    tmp_mul = a * b;
                    result = tmp_mul[WIDTH-1:0];
                    carry = |tmp_mul[2*WIDTH-1:WIDTH];
                end
                3'b011: begin // DIV
                    if (b != 0)
                        result = a / b;
                    else
                        result = {WIDTH{1'b0}};
                end
                3'b100: begin // AND
                    result = a & b;
                end
                3'b101: begin // OR
                    result = a | b;
                end
                3'b110: begin // XOR
                    result = a ^ b;
                end
                default: result = {WIDTH{1'b0}}; // NOP
            endcase
        end    
        zero = (result == 0);
        parity = ~^result; // Even parity
    end

endmodule
