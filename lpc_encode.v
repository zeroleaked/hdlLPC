module lpc_encode (
        input   wire clk, reset, start,

        input   wire x_wen,
        input   wire [7:0] x_waddr,
        input   wire [15:0] x_din,
        input   wire [7:0] residue_raddr,
        output  wire [15:0] residue_dout,
        input   wire [9:0] a_rsel,
        output   wire [31:0] a_dout
    );

    wire [7:0] x_raddr;
    wire [15:0] x_dout;

    register_16x160 register_input (
        .clk(clk),
        .reset(reset),
        .wen(x_wen),
        .waddr(x_waddr),
        .din(x_din),
        .raddr(x_raddr),
        .dout(x_dout)
    );

    wire [10:0] r_wsel;
    wire [31:0] r_din;
    wire [10:0] r_rsel;
    wire [31:0] r_dout;

    register_32x11 register_r (
        .clk(clk),
        .reset(reset),
        .wsel(r_wsel),
        .din(r_din),
        .rsel(r_rsel),
        .dout(r_dout)
    );

    wire [9:0] a_wsel;
    wire [31:0] a_din;
    wire [9:0] int_a_rsel;

    register_32x10 register_a (
        .clk(clk),
        .reset(reset),
        .wsel(a_wsel),
        .din(a_din),
        .rsel(int_a_rsel),
        .dout(a_dout)
    );

    wire [7:0] residue_waddr;
    wire residue_wen;
    wire [15:0] residue_w;
    register_16x160 register_residue (
        .clk(clk),
        .reset(reset),
        .wen(residue_wen),
        .waddr(residue_waddr),
        .din(residue_w),
        .raddr(residue_raddr),
        .dout(residue_dout)
    );

    wire ready_autocorrelation;
    wire [7:0] x_raddr_autocorrelation;

    autocorrelation autocorrelation (
        .clk(clk),
        .reset(start),
        .ready(ready_autocorrelation),
        .raddr(x_raddr_autocorrelation),
        .x(x_dout),
        .wsel(r_wsel),
        .y(r_din)
    );

    wire reset_levinson;
    wire ready_levinson;
    wire [9:0] a_rsel_levinson;
    levinson levinson (
        .clk(clk),
        .reset(reset_levinson),
        .ready(ready_levinson),
        .a_wsel(a_wsel),
        .a_w(a_din),
        .a_rsel(a_rsel_levinson),
        .a_r(a_dout),
        .r_rsel(r_rsel),
        .r_r(r_dout)
    );


    wire ready_ifilter;
    wire reset_ifilter;
    wire [9:0] a_rsel_ifilter;
    wire [7:0] x_raddr_ifilter;
    ifilter ifilter (
        .clk(clk),
        .reset(reset_ifilter),
        .ready(ready_ifilter),
        .a_rsel(a_rsel_ifilter),
        .a_r(a_dout),
        .x_raddr(x_raddr_ifilter),
        .x_r(x_dout),
        .residue_waddr(residue_waddr),
        .residue_wen(residue_wen),
        .residue_w(residue_w)
    );


    wire [1:0] a_rsel_sel;
    assign int_a_rsel = a_rsel_sel == 2'h0 ? a_rsel_levinson : a_rsel_sel == 2'h1 ? a_rsel_ifilter : a_rsel;

    wire x_raddr_sel;
    assign x_raddr = x_raddr_sel ? x_raddr_ifilter : x_raddr_autocorrelation;

    lpc_encode_control lpc_encode_control (
        .clk(clk),
        .reset(reset),
        .start(start),
        .ready_autocorrelation(ready_autocorrelation),
        .ready_levinson(ready_levinson),
        .ready_ifilter(ready_ifilter),
        .reset_levinson(reset_levinson),
        .reset_ifilter(reset_ifilter),
        .a_rsel_sel(a_rsel_sel),
        .x_raddr_sel(x_raddr_sel)
    );



endmodule