module autocorrelation_control (
        input   wire clk, reset,
        output  wire ready,
        output  wire next_lag,
        output  wire [7:0] raddr,
        output  wire [10:0] lag,
        output  wire [10:0] wsel
    );

    // reg delay_11;
	reg [7:0] counter_160;
    reg [10:0] counter_11;

	always @ (posedge clk) begin
        if (reset) begin
            counter_160 <= 0;
            counter_11 <= 11'b1;
        end
        else if (counter_160 == 159) begin
            counter_160 <= 0;
            counter_11 <= {counter_11[9:0], 1'b0};
        end
        else
            counter_160 <= counter_160 + 1'd1;
	end

    assign next_lag = (counter_160 == 159) || reset;
    assign raddr = counter_160;
    assign lag = counter_11;
    assign wsel = (counter_160 == 159) ? counter_11 : 1'b0;
    assign ready = counter_11 == 0;

endmodule