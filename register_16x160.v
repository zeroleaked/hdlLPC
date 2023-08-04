module register_16x160 (
    input wire clk, reset,
    input wire wen,
    input wire [7:0] waddr,
    input wire [7:0] raddr,
    input wire [15:0] din,
    output wire [15:0] dout
);

    reg [2559:0] register;

    always @(posedge clk or posedge reset) begin
        if (reset)
            register <= 160'h0; // Reset the register to all zeros
        else begin
            if (wen) // Check if wsel[i] is high (1)
                register[waddr * 16 +: 16] <= din;
        end
    end

    assign dout = register[raddr * 16 +: 16];

    // always @(posedge clk) begin
    //     // Read operation based on rsel
    //     dout <= register[raddr * 16 +: 16];
    // end

endmodule
