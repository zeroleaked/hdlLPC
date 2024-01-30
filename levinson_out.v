module levinson_out (
        input   wire out_sel,
        input   wire signed [31:0] temp,
        input   wire signed [31:0] a,
        input   wire signed [31:0] k,
        output  wire signed [31:0] next_a
    );

    wire signed [31:0] k_shift, k_ones, k_out;
    assign k_ones = k - k[31];
    assign k_shift = k_ones >>> 3;
    assign k_out = k_shift + k[31];

    wire signed [31:0] a_o;
    wire signed [33:0] a_s, a_t;
    assign a_o = a - a[31];
    assign a_s = {a_o, {2{a[31]}}};
    assign a_t = a_s + a[31];

    wire signed [33:0] add, add_o;
    wire signed [31:0] add_s, add_t;
    assign add = temp + a_t;
    assign add_o = add - add[33];
    assign add_s = add_o[33:2];
    assign add_t = add_s + add[33];
    
    assign next_a = out_sel ? add_t : k_out;

endmodule