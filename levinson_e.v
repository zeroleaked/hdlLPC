module levinson_e (
        input   wire e_sel,
        input   wire [31:0] r,
        input   wire signed [31:0] k,
        input   wire signed [31:0] q,
        input   wire [31:0] e,
        output  wire [31:0] next_e
    );

    wire [31:0] r_shift;
    assign r_shift = r << 1;

    wire signed [63:0] prod, ones, shifted;
    wire signed [31:0] twos;
    assign prod = k * q; // a * 2^(-33) * b * 2^(-31) = ab * 2^(-64) = ab * 2^(-34) * 2^(-30)
    assign ones = prod - prod[63];
    assign shifted = ones >>> 30;
    assign twos = shifted[31:0] + prod[63];
    wire [31:0] mad;
    assign mad = twos + e;

    assign next_e = e_sel ? mad : r_shift;

endmodule