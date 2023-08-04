module test ();
    reg clk;
    reg signed [15:0] a;
    wire signed [31:0] b;
    wire signed [15:0] ac;
    wire signed [31:0] bc;
    reg signed [31:0] d;
    wire signed [31:0] e;


    // Clock generation
    always #5 clk = ~clk; // Assuming 10ns clock period

    reg [15:0] ones_a;
    // assign ones_a = a[15] ? a - 1 : a;

    // always @* begin
    //   if (a[15])
    //     b <= {{a-1}, {16{1}}} + 1;
    // end


    assign b = {{a[15] ? a - 1 : a}, {16{a[15]}}} + (a[15] ? 1 : 0);
    assign ac = a * -2;
    assign bc = b * -2;
    assign e = d <<< 1;

    // Stimulus generation
    initial begin
      clk = 1;
      // Initialize input signals if needed
      a = 1;
      d = 32'h7fffffff;
      #11;
      a = -1;
      #10;
      #10;

      // Provide test vectors
      // Change input values here

      #1000; // Simulation duration

      $finish; // End the simulation

    end

endmodule