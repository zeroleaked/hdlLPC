module ifilter (
        input   wire clk, reset,
        output  wire ready,

        output  wire [9:0] a_rsel,
        input  wire [31:0] a_r,

        output  wire [7:0] x_raddr,
        input  wire [15:0] x_r,

        output  wire [7:0] residue_waddr,
        output  wire residue_wen,
        output  wire [15:0] residue_w

    );

    wire reset_accumulator;
    ifilter_control ifilter_control (
        .clk(clk),
        .reset(reset),
        .ready(ready),
        .next_sample(reset_accumulator),
        .a_rsel(a_rsel),
        .x_raddr(x_raddr),
        .residue_waddr(residue_waddr),
        .residue_wen(residue_wen)
    );

    ifilter_mad ifilter_mad (
      .clk(clk),
      .reset(reset_accumulator),
      .x(x_r),
      .a(a_r),
      .residue(residue_w)
    );

endmodule