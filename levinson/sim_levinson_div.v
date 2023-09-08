module lpm_divide_var (
        input clock,
        input   wire signed [63:0] numer,
        input   wire signed [32:0] denom,
        output  wire signed [31:0] quotient
    );

    reg [255:0] shiftreg;
    wire signed [31:0] quotient_temp = numer / denom;

    always @(posedge clock) begin
        shiftreg[255:224] <= shiftreg[223:192];
        shiftreg[223:192] <= shiftreg[191:160];
        shiftreg[191:160] <= shiftreg[159:128];
        shiftreg[159:128] <= shiftreg[127:96];
        shiftreg[127:96] <= shiftreg[95:64];
        shiftreg[95:64] <= shiftreg[63:32];
        shiftreg[63:32] <= shiftreg[31:0];
        shiftreg[31:0] <= quotient_temp;
    end

    assign quotient = shiftreg[255:224];

endmodule