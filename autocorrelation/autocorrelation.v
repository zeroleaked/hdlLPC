module autocorrelation (
        input   wire clk, reset,
        output  wire ready,
        output  wire [31:0] y,
        output  wire [10:0] wsel,

        output  wire [7:0] raddr,
        input   wire [15:0] x
    );

    wire reset_accumulator;
    wire [10:0] lag;

    autocorrelation_control autocorrelation_control_0 (
        .clk(clk),
        .reset(reset),
        .ready(ready),
        .next_lag(reset_accumulator),
        .raddr(raddr),
        .lag(lag),
        .wsel(wsel)
    );

    wire [15:0] x_lagged;
    shift_1x10 shift_1x10_0 (
      .clk(clk),
      .tap(lag),
      .din(x),
      .dout(x_lagged)
    );

    autocorrelation_mad autocorrelation_mad_0 (
      .clk(clk),
      .reset(reset_accumulator),
      .x(x),
      .x_lagged(x_lagged),
      .y(y)
    );

endmodule