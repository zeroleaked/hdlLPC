module lpc_encode_control (
        input   wire clk, reset,
        input   wire start,
        input   wire ready_autocorrelation, ready_levinson, ready_ifilter,
        output  reg reset_levinson, reset_ifilter,
        output  reg [1:0] a_rsel_sel,
        output  reg x_raddr_sel
    );

    reg [2:0] current_state, next_state;

    localparam S_0      = 3'h0; // idle (mem active, no internal write)
    localparam S_1      = 3'h1; // autocorr
    localparam S_2      = 3'h2; // start levinson (1 clock)
    localparam S_3      = 3'h3; // levinson
    localparam S_4      = 3'h4; // start reverse filter (1 clock)
    localparam S_5      = 3'h5; // reverse filter
    
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @* begin
        case (current_state)
            S_0: begin
                if (start)
                    next_state = S_1;
                else
                    next_state = S_0;
            end
            S_1: begin
                if (ready_autocorrelation) begin
                    next_state = S_2;
                end else begin
                    next_state = S_1;
                end
            end
            S_2: begin
                next_state = S_3;
            end
            S_3: begin
                if (ready_levinson) begin
                    next_state = S_4;
                end else begin
                    next_state = S_3;
                end
            end
            S_4: begin
                next_state = S_5;
            end
            S_5: begin
                if (ready_ifilter) begin
                    next_state = S_0;
                end else begin
                    next_state = S_5;
                end
            end
            default: next_state = S_0;
        endcase
    end

    // output logic
    always @* begin
        case (current_state)
            S_0: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h2;
                x_raddr_sel             = 1'bx;
            end
            S_1: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'hx;
                x_raddr_sel             = 1'b0;
            end
            S_2: begin
                reset_levinson          = 1'b1;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h0;
                x_raddr_sel             = 1'bx;
            end
            S_3: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h0;
                x_raddr_sel             = 1'bx;
            end
            S_4: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b1;
                a_rsel_sel              = 2'h1;
                x_raddr_sel             = 1'b1;
            end
            S_5: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h1;
                x_raddr_sel             = 1'b1;
            end
        endcase
    end

endmodule