module autocorrelation_mad (
        input   wire clk, reset,
        input   wire signed [15:0] x,
        input   wire signed [15:0] x_lagged,
        output  wire signed [31:0] y
    );

    wire signed [31:0] accumulate;
    reg signed [31:0] s_accumulate;
    wire signed [31:0] product;

	always @ (posedge clk) begin
        if (reset)
            s_accumulate <= 0;
        else
            s_accumulate <= accumulate;
	end

    // wire signed [31:0] temp_product;
    // wire signed [31:0] shifted, ones;
    // assign temp_product = x * x_lagged;
    // assign ones = temp_product - temp_product[31];
    // assign shifted = ones >>> 4;  // (1,32,26)
    // assign product = shifted + shifted[31];
    // assign accumulate = product + s_accumulate; // (1,32,26)

    wire signed [31:0] accum_o, nacc_s;
    wire signed [35:0] accum_s, accum_t, accum_36, nacc_o;
    assign product = x * x_lagged;
    assign accum_o = s_accumulate - s_accumulate[31];
    assign accum_s = {accum_o, {4{s_accumulate[31]}}};
    assign accum_t = accum_s + s_accumulate[31];
    assign accum_36 = accum_t + product;
    assign nacc_o = accum_36 - accum_36[35];
    wire signed [35:0] nacc_s1 = nacc_o >>> 4; 
    assign nacc_s = nacc_s1[31:0];
    assign accumulate = nacc_s + accum_36[35];



    wire signed [63:0] normalize;
    assign normalize = accumulate * 1717986918;
    assign y = normalize[62:31] + normalize[62];

endmodule