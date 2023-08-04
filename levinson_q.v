module levinson_q (
        input   wire q_sel,
        input   wire signed [31:0] r,
        input   wire signed [31:0] a,
        input   wire signed [31:0] q,
        output  wire signed [31:0] next_q
    );

    wire signed [63:0] prod, prod_s, prod_o;
    wire signed [31:0] prod_t;
    assign prod = r * a; // a * 2^(-33) * b * 2^(-28) = ab * 2^(-34) * 2^(-27)
    assign prod_o = prod - prod[63];
    assign prod_s = prod_o >>> 27;
    assign prod_t = prod_s[31:0] + prod[63];

    wire signed [31:0] q_o;
    wire signed [32:0] q_s, q_t;
    assign q_o = q - q[31];
    assign q_s = {q_o, {q[31]}};
    assign q_t = q_s + q[31];

    wire [32:0] mad, mad_o;
    wire [31:0] mad_t, mad_s;
    assign mad = prod_t + q_t;
    assign mad_o = mad - mad[32];
    assign mad_s = {mad_o[32:1]};
    assign mad_t = mad_s + mad[32];

    assign next_q = q_sel ? mad_t : r;

endmodule