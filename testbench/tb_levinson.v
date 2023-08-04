module tb_levinson (
    );

    reg reset, clk, start;

    wire [9:0] a_wsel;
    wire [31:0] a_w;
    wire [9:0] a_rsel;
    wire [31:0] a_r;


    reg [10:0] r_wsel;
    reg [31:0] r_w;
    wire [10:0] r_rsel;
    wire [31:0] r_r;

    levinson dut (
        .clk(clk),
        .reset(start),
        .a_wsel(a_wsel),
        .a_w(a_w),
        .a_rsel(a_rsel),
        .a_r(a_r),
        .r_rsel(r_rsel),
        .r_r(r_r)
    );

    register_32x11 register_r (
        .clk(clk),
        .reset(reset),
        .wsel(r_wsel),
        .din(r_w),
        .rsel(r_rsel),
        .dout(r_r)
    );

    register_32x10 register_a (
        .clk(clk),
        .reset(reset),
        .wsel(a_wsel),
        .din(a_w),
        .rsel(a_rsel),
        .dout(a_r)
    );

    reg [31:0] din_values [0:10];
    integer i;

    initial begin
        // Initialize inputs
        clk = 1;
        start = 0;

        // initial begin
        din_values[0] = 32'h11072150; din_values[1] = 32'h0FC15598; din_values[2] = 32'h0C9CD289; din_values[3] = 32'h08900BDB; din_values[4] = 32'h0410363B; din_values[5] = 32'hFFC626D6; din_values[6] = 32'hFC59F3C9; din_values[7] = 32'hF9C68770; din_values[8] = 32'hF7FE50E8; din_values[9] = 32'hF756B0D0; din_values[10] = 32'hF7F736B4;     
        // end

        #1

        reset = 0;
        #10
        r_wsel = 0;
        reset = 1;
        #10
        reset = 0;


        // Write data to register iteratively
        for (i = 0; i < 11; i = i + 1) begin
            r_wsel = 1 << i;
            r_w = din_values[i];
            #10;
        end

        r_wsel=0;
        #10
        start=1;
        #10
        start=0;
        #1600;


    end

    always #5 clk = ~clk; // Toggle clock every 5 time units

endmodule