module ifilter_mad (
        input   wire clk, reset,
        input   wire signed [15:0] x, // 16,15
        input   wire signed [31:0] a, // 32, 28
        output  wire signed [15:0] residue // 16,15
    );

    wire signed [15:0] accumulate;
    reg signed [15:0] s_accumulate;

	always @ (posedge clk) begin
        if (reset)
            s_accumulate <= x;
        else
            s_accumulate <= accumulate;
	end

    wire signed [47:0] product, product_o;
    wire signed [31:0] product_s, product_t;
    assign product = x * a; // a * 2^(-15) * b * 2^(-28) = ab * 2^(-30) * 2^(-13)
    assign product_o = product - product[47];
    assign product_s = product_o[44:13];
    assign product_t = product_s + product_s[31];

    wire signed [15:0] s_accumulate_o;
    wire signed [31:0] s_accumulate_s, s_accumulate_t; // a * 2^(-15) = a * 2^(-30) * 2^(15)
    assign s_accumulate_o = s_accumulate - s_accumulate[15];
    assign s_accumulate_s = { s_accumulate_o[15], s_accumulate_o, {15{s_accumulate_o[15]}}};
    assign s_accumulate_t = s_accumulate_s + s_accumulate_s[31];

    wire signed [32:0] accumulate_o, accumulate_t;
    wire signed [15:0] accumulate_s; // a * 2^(-30) = a * 2^(-15) * 2^(-15)
    assign accumulate_t = product_t + s_accumulate_t;
    assign accumulate_o = accumulate_t - accumulate_t[32];
    assign accumulate_s = accumulate_o[30:15];
    assign accumulate = accumulate_s + accumulate_s[15];

    assign residue = reset ? x : accumulate;

endmodule