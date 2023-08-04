module levinson_k (
        input   wire [31:0] e, // 0,34
        input   wire signed [31:0] q, // 33
        output  wire signed [31:0] next_k // 31
    );

    wire signed [63:0] q_extend;
    assign q_extend = {(q-q[31]), {32{q[31]}}} + q[31]; // 2^(-33) = 2^(-65)

    wire signed [31:0] div;
    wire signed [32:0] e_signed = {{1'b0}, e[31:0]};
    assign div = q_extend/e_signed; // a * 2^(-33) / (b * 2^(-34)) = a/b * 2^(1) = a/b * 2^(32) * 2^(-31)

    assign next_k = -1 * div;

endmodule