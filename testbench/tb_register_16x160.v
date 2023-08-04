module tb_register_16x160;

    reg clk;
    reg reset;
    reg wen;
    reg [7:0] waddr;
    reg [7:0] raddr;
    reg [15:0] din;
    wire [15:0] dout;

    register_16x160 dut (
        .clk(clk),
        .reset(reset),
        .wen(wen),
        .waddr(waddr),
        .raddr(raddr),
        .din(din),
        .dout(dout)
    );

    initial begin
        // Initialize inputs
        clk = 1;
        reset = 0;
        waddr = 0;
        raddr = 0;
        din = 0;

        #1;

        // Apply reset
        reset = 1;
        #10;
        reset = 0;

        // Write operation
        waddr = 0;
        din = 16'h1234;
        wen = 1;
        #10;
        din = 16'h5678;
        #10;
        waddr = 9;
        din = 16'hABCD;
        #10;
        wen = 0;

        // Read operation
        raddr = 0;
        #10;
        raddr = 9;
        #10;

        // Add additional test cases as needed

        $finish;
    end

    always #5 clk = ~clk; // Toggle clock every 5 time units

endmodule
