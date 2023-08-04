module tb_ifilter_control ();

    reg clk;
    reg reset;
    wire next_sample,ready;
    wire [7:0] x_raddr;
    wire [9:0] a_rsel;
    wire [7:0] residue_waddr;
    wire residue_wen;

    // Instantiate your module
    ifilter_control dut (
        .clk(clk),
        .reset(reset),
        .ready(ready),
        .next_sample(next_sample),
        .a_rsel(a_rsel),
        .x_raddr(x_raddr),
        .residue_waddr(residue_waddr),
        .residue_wen(residue_wen)
    );

    // Clock generation
    always #5 clk = ~clk; // Assuming 10ns clock period

    // Stimulus generation
    initial begin
      clk = 1;
      // Initialize input signals if needed
      reset = 1;
      #11;
      reset = 0;

      // Provide test vectors
      // Change input values here

      #1000; // Simulation duration


    end

endmodule