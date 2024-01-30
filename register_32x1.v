module register_32x1 (
    input wire clk, load,
    input wire [31:0] din,
    output wire [31:0] dout
);

    reg [31:0] register;

    always @(posedge clk) begin
        if (load)
            register <= din; // Reset the register to all zeros
    end

    assign dout = register;

endmodule
