module tb_shift_1x10 (
    );

    reg clk;
    reg [10:0] tap;
    reg [15:0] din;
    wire [15:0] dout;

    // Instantiate your module
    shift_1x10 shift_1x10_0 (
      .clk(clk),
      .tap(tap),
      .din(din),
      .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk; // Assuming 10ns clock period

    // Stimulus generation
    initial begin
      clk = 1;
      // Initialize input signals if needed
      tap = 1;
      #1;
      repeat (10) begin
        #1600;
        tap = tap << 1;
      end

      // Provide test vectors
      // Change input values here

      #100; // Simulation duration

      $finish; // End the simulation
    end

    // Stimulus generation
    initial begin
      din = 0;
      #1;
      repeat (1600) begin
        #10;
        din = din + 1;
        if (din == 160)
          din = 0;
      end

    end

endmodule