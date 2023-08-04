module register_32x10 (
    input wire clk, reset,
    input wire [9:0] wsel,
    input wire [9:0] rsel,
    input wire [31:0] din,
    output reg [31:0] dout
);

    reg [319:0] register;

    always @(posedge clk) begin
        if (reset)
            register <= 351'h0; // Reset the register to all zeros
        else begin
            case(wsel)
                10'h001: register[0 +: 32] <= din;
                10'h002: register[32 +: 32] <= din;
                10'h004: register[64 +: 32] <= din;
                10'h008: register[96 +: 32] <= din;
                10'h010: register[128 +: 32] <= din;
                10'h020: register[160 +: 32] <= din;
                10'h040: register[192 +: 32] <= din;
                10'h080: register[224 +: 32] <= din;
                10'h100: register[256 +: 32] <= din;
                10'h200: register[288 +: 32] <= din;
            endcase
        end
    end

    always @* begin
        case(rsel)
            10'h001: dout = register[0 +: 32];
            10'h002: dout = register[32 +: 32];
            10'h004: dout = register[64 +: 32];
            10'h008: dout = register[96 +: 32];
            10'h010: dout = register[128 +: 32];
            10'h020: dout = register[160 +: 32];
            10'h040: dout = register[192 +: 32];
            10'h080: dout = register[224 +: 32];
            10'h100: dout = register[256 +: 32];
            10'h200: dout = register[288 +: 32];
            default: dout = 32'hxxxxxxxx;
        endcase
    end

endmodule
