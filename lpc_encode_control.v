module lpc_encode_control (
        input   wire clk, reset,
        input   wire start,
        input   wire ready_autocorrelation, ready_levinson, ready_ifilter,
        output  reg rready,
        output  reg reset_levinson, reset_ifilter,
        output  reg [1:0] a_rsel_sel,
        output  reg [1:0] x_raddr_sel
    );

    reg [2:0] current_state, next_state;

    localparam S_0      = 3'h0; // idle (mem active, external write only)
    localparam S_1      = 3'h1; // autocorr
    localparam S_2      = 3'h2; // start levinson (1 clock)
    localparam S_3      = 3'h3; // levinson
    localparam S_4      = 3'h4; // start reverse filter (1 clock)
    localparam S_5      = 3'h5; // reverse filter
    localparam S_6      = 3'h6; // finish (mem active, external read only)
    
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
            S_0: begin // wen
                if (start)
                    next_state = S_1;
                else
                    next_state = S_0;
            end
            S_1: begin // autocorr running
                if (ready_autocorrelation) begin
                    next_state = S_2;
                end else begin
                    next_state = S_1;
                end
            end
            S_2: begin // levinson start
                next_state = S_3;
            end
            S_3: begin // levinson running
                if (ready_levinson) begin
                    next_state = S_4;
                end else begin
                    next_state = S_3;
                end
            end
            S_4: begin // ifilter start
                next_state = S_5;
            end
            S_5: begin // ifilter running
                if (ready_ifilter) begin
                    next_state = S_6;
                end else begin
                    next_state = S_5;
                end
            end
            S_6: begin // external read only
                next_state = S_6;
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
                x_raddr_sel             = 2'd2;
                rready                  = 1'b0;
            end
            S_1: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'hx;
                x_raddr_sel             = 2'd0;
                rready                  = 1'b0;
            end
            S_2: begin
                reset_levinson          = 1'b1;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h0;
                x_raddr_sel             = 2'dx;
                rready                  = 1'b0;
            end
            S_3: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h0;
                x_raddr_sel             = 2'dx;
                rready                  = 1'b0;
            end
            S_4: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b1;
                a_rsel_sel              = 2'h1;
                x_raddr_sel             = 2'd1;
                rready                  = 1'b0;
            end
            S_5: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h1;
                x_raddr_sel             = 2'd1;
                rready                  = 1'b0;
            end
            S_6: begin
                reset_levinson          = 1'b0;
                reset_ifilter           = 1'b0;
                a_rsel_sel              = 2'h2;
                x_raddr_sel             = 2'd2;
                rready                  = 1'b1;
            end
        endcase
    end

endmodule