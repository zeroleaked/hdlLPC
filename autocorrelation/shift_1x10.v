module shift_1x10 (
        input   wire clk,
        input   wire [10:0] tap,
        input   wire [15:0] din,
        output  reg 	[15:0] dout
    );

	wire [15:0] bypass;
	reg [159:0] sr;

	always @ (posedge clk) begin
        sr[159:144] <= sr[143:128];
        sr[143:128] <= sr[127:112];
        sr[127:112] <= sr[111:96];
        sr[111:96] <= sr[95:80];
        sr[95:80] <= sr[79:64];
        sr[79:64] <= sr[63:48];
        sr[63:48] <= sr[47:32];
        sr[47:32] <= sr[31:16];
        sr[31:16] <= sr[15:0];
        sr[15:0] <= din;
	end

    assign bypass = din;
    always @* begin
        case(tap)
            11'h001: dout = bypass;
            11'h002: dout = sr[15:0];
            11'h004: dout = sr[31:16];
            11'h008: dout = sr[47:32];
            11'h010: dout = sr[63:48];
            11'h020: dout = sr[79:64];
            11'h040: dout = sr[95:80];
            11'h080: dout = sr[111:96];
            11'h100: dout = sr[127:112];
            11'h200: dout = sr[143:128];
            11'h400: dout = sr[159:144];
            default: dout = 16'b0;
        endcase
    end

endmodule