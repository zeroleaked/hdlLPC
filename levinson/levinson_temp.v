module levinson_temp (
        input   wire signed [31:0] a,
        input   wire signed [31:0] k,
        output  wire signed [31:0] next_temp
    );

    wire signed [63:0] prod, ones, shifted;
    assign prod = a * k;
    assign ones = prod - prod[63];
    assign shifted = ones >>> 29;
    assign next_temp = shifted[31:0] + prod[63];


endmodule