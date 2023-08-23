module ifilter_control (
        input   wire clk, reset,
        output  reg ready,
        output  wire next_sample,
        output  wire [9:0] a_rsel,
        output  wire [7:0] x_raddr,
        output  wire [7:0] residue_waddr,
        output  wire residue_wen
    );

    // reg delay_11;
	reg [7:0] counter_160;
    reg [3:0] counter_11;

	always @ (posedge clk) begin
        if (reset) begin
            counter_160 <= 0;
            counter_11 <= 0;
            ready <= 0;
        end
        else if (counter_11 == 10) begin
            counter_11 <= 0;
            if (counter_160 == 159)
                ready = 1;
            else
                counter_160 <= counter_160 + 8'd1;
        end
        else
            if (counter_160 == counter_11) begin
                counter_11 <= 0;
                counter_160 <= counter_160 + 8'd1;
            end
            else
                counter_11 <= counter_11 + 4'd1;
	end

    assign next_sample = counter_11 == 0;
    assign a_rsel = counter_11 == 0 ? 10'hxxx : 10'd1 << (counter_11-1'd1);
    assign x_raddr = counter_160 - counter_11;
    assign residue_waddr = counter_160;
    assign residue_wen = ready ? 0 : (counter_160 == counter_11) || (counter_11 == 10) ? 1'b1 : 1'b0;


endmodule