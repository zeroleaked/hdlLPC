module levinson_k (
        input   clk,
        input   wire [31:0] e, // 0,34
        input   wire signed [31:0] q, // 33
        output  wire signed [31:0] next_k // 31
    );

    wire signed [63:0] q_extend;
    assign q_extend = {(q-q[31]), {32{q[31]}}} + q[31]; // 2^(-33) = 2^(-65)

    wire signed [31:0] div;
    wire signed [32:0] e_signed = {{1'b0}, e[31:0]};
    // wire signed [63:0] e_signed = {{32{1'b0}}, e[31:0]};

    lpm_divide_var inst_levinson_div (
        .clock(clk),
        .numer(q_extend),
        .denom(e_signed),
        .quotient(div)
    );

    assign next_k = -1 * div;

endmodule