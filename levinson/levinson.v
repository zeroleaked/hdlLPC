module levinson (
        input   wire clk, reset,
        output  wire ready,

        output  wire [9:0] a_wsel,
        output  wire [31:0] a_w,
        input   wire [9:0] a_rsel,
        input   wire [31:0] a_r,

        output   wire [10:0] r_rsel,
        input   wire [31:0] r_r
    );

    wire [8:0] temp_sel;
    wire e_load, k_load, q_load;
    wire out_sel, e_sel, q_sel;
    levinson_control levinson_control_0 (
        .clk(clk),
        .reset(reset),
        .ready(ready),
        .r_rsel(r_rsel),
        .a_rsel(a_rsel),
        .a_wsel(a_wsel),
        .temp_sel(temp_sel),
        .out_sel(out_sel),
        .e_sel(e_sel),
        .q_sel(q_sel),
        .k_load(k_load),
        .e_load(e_load),
        .q_load(q_load)
    );

    wire [31:0] q, k;
    wire [31:0] next_e, e;
    levinson_e calc_e (
        .e_sel(e_sel),
        .r(r_r),
        .k(k),
        .q(q),
        .e(e),
        .next_e(next_e)
    );

    register_32x1 register_e (
      .clk(clk),
      .load(e_load),
      .din(next_e),
      .dout(e)
    );

    wire [31:0] next_q;
    levinson_q calc_q (
        .q_sel(q_sel),
        .r(r_r),
        .a(a_r),
        .q(q),
        .next_q(next_q)
    );

    register_32x1 register_q (
      .clk(clk),
      .load(q_load),
      .din(next_q),
      .dout(q)
    );

    wire [31:0] next_k;
    levinson_k calc_k (
        .e(e),
        .q(q),
        .next_k(next_k)
    );

    register_32x1 register_k (
      .clk(clk),
      .load(k_load),
      .din(next_k),
      .dout(k)
    );

    wire [31:0] next_temp;
    levinson_temp calc_temp (
      .k(k),
      .a(a_r),
      .next_temp(next_temp)
    );

    wire [31:0] temp;
    register_32x9 register_temp (
        .clk(clk),
        .reset(reset),
        .wsel(temp_sel),
        .din(next_temp),
        .rsel(temp_sel),
        .dout(temp)
    );

    levinson_out calc_out (
        .k(k),
        .temp(temp),
        .a(a_r),
        .out_sel(out_sel),
        .next_a(a_w)
    );

endmodule