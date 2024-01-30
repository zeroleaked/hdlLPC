module register_16x160 (
    input wire clk, reset,
    input wire wen,
    input wire [7:0] waddr,
    input wire [7:0] raddr,
    input wire [15:0] din,
    output wire [15:0] dout
);

    reg [15:0] register [0:159]; // This array should infer BRAM

    always @(posedge clk or posedge reset) begin
        if (reset) begin
        end 
        else if (wen) 
            register[waddr] <= din;
    end

    // Inferred BRAM will use the dual-port capability
    // When wen is low (not writing), use the zero-latency read port
    assign dout = wen ? register[waddr] : register[raddr];

endmodule
