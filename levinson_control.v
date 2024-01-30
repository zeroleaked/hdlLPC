module levinson_control (
        input   wire clk, reset,
        output  wire ready,
        output  wire [10:0] r_rsel,
        output  wire [9:0] a_rsel,
        output  wire [9:0] a_wsel,
        output  wire [8:0] temp_sel,
        output  wire out_sel,
        output  wire e_sel,
        output  wire q_sel,
        output  wire k_load,
        output  wire e_load,
        output  wire q_load
    );

    reg [3:0] i, j;

    // FSM

    reg [4:0] current_state, next_state;

    localparam S_0      = 5'h0;
    localparam S_1      = 5'h1;
    localparam S_2      = 5'h2;
    localparam S_3      = 5'h3;
    localparam S_3_1     = 5'h9;
    localparam S_3_2     = 5'ha;
    localparam S_3_3     = 5'hb;
    localparam S_3_4     = 5'hc;
    localparam S_3_5     = 5'hd;
    localparam S_3_6     = 5'he;
    localparam S_3_7     = 5'hf;
    localparam S_3_8     = 5'h10;
    localparam S_4      = 5'h4;
    localparam S_5      = 5'h5;
    localparam S_6      = 5'h6;
    localparam S_7      = 5'h7;
    localparam S_8      = 5'h8;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_0;
        end
        else begin
            current_state <= next_state;
        end
    end

    reg [10:0] int_r_rsel;
    reg [9:0] int_a_rsel;
    reg [9:0] int_a_wsel;
    reg [8:0] int_temp_sel;
    reg int_out_sel;
    reg int_e_sel;
    reg int_q_sel;
    reg int_k_load;
    reg int_e_load;
    reg int_q_load;
    reg int_ready;

    // Next-state logic
    always @* begin
        case (current_state)
            S_0: begin
                next_state = S_1;
            end
            S_1: begin
                if (i == 0) begin
                    next_state = S_3;
                end else begin
                    next_state = S_2;
                end
            end
            S_2: begin
                if (j == 1) begin
                    next_state = S_3;
                end else begin
                    next_state = S_2;
                end
            end
            S_3: begin
                next_state = S_3_1;
            end
            S_3_1: begin
                next_state = S_3_2;
            end
            S_3_2: begin
                next_state = S_3_3;
            end
            S_3_3: begin
                next_state = S_3_4;
            end
            S_3_4: begin
                next_state = S_3_5;
            end
            S_3_5: begin
                next_state = S_3_6;
            end
            S_3_6: begin
                next_state = S_3_7;
            end
            S_3_7: begin
                next_state = S_3_8;
            end
            S_3_8: begin
                if (i == 0) begin
                    next_state = S_5;
                end else begin
                    next_state = S_4;
                end
            end
            S_4: begin
                if (j == 1) begin
                    next_state = S_5;
                end else begin
                    next_state = S_4;
                end
            end
            S_5: begin
                if (i == 0) begin
                    next_state = S_7;
                end else begin
                    next_state = S_6;
                end
            end
            S_6: begin
                if (j == 0) begin
                    next_state = S_7;
                end else begin
                    next_state = S_6;
                end
            end
            S_7: begin
                if (i == 9) begin
                    next_state = S_8;
                end else begin
                    next_state = S_1;
                end
            end
            S_8: begin
                next_state = S_8;
            end
            default: next_state = S_0;
        endcase
    end



    // output logic
    always @* begin
        case (current_state)
            S_0: begin
                int_r_rsel      = 11'h1;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'b0;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b1;
                int_q_load      = 1'bx;
                int_ready       = 1'b0;
            end
            S_1: begin
                int_r_rsel      = 11'b1 << (i + 1'd1);
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'b0;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b1;
                int_ready       = 1'b0;
            end
            S_2: begin
                int_r_rsel      = 11'b1 << j;
                int_a_rsel      = 10'b1 << (i-j);
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'b1;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b1;
                int_ready       = 1'b0;
            end
            S_3: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_1: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_2: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_3: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_4: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_5: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_6: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_7: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_3_8: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'b1;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_4: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'b1 << (j-1);
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'b1 << (i-j);
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'b0;
                int_e_load      = 1'b0;
                int_q_load      = 1'b0;
                int_ready       = 1'b0;
            end
            S_5: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'b1 << i;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'b0;
                int_e_sel       = 1'b1;
                int_q_sel       = 1'bx;
                int_k_load      = 1'b0;
                int_e_load      = 1'b1;
                int_q_load      = 1'bx;
                int_ready       = 1'b0;
            end
            S_6: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'b1 << j;
                int_a_wsel      = 10'b1 << j;
                int_temp_sel    = 9'b1 << j;
                int_out_sel     = 1'b1;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'bx;
                int_ready       = 1'b0;
            end
            S_7: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'b0;
                int_q_load      = 1'bx;
                int_ready       = 1'b0;
            end
            S_8: begin
                int_r_rsel      = 11'hx;
                int_a_rsel      = 10'hx;
                int_a_wsel      = 10'h0;
                int_temp_sel    = 9'hx;
                int_out_sel     = 1'bx;
                int_e_sel       = 1'bx;
                int_q_sel       = 1'bx;
                int_k_load      = 1'bx;
                int_e_load      = 1'bx;
                int_q_load      = 1'bx;
                int_ready       = 1'b1;
            end
        endcase
    end


    always @(posedge clk) begin
        if (reset) begin
            i <= 0;
        end
        else case (current_state)
            S_1: begin
                j <= i;
            end
            S_2: begin
                j <= j-4'd1;
            end
            S_3_8: begin
                j <= i;
            end
            S_4: begin
                j <= j-4'd1;
            end
            S_5: begin
                j <= i-4'd1;
            end
            S_6: begin
                j <= j-4'd1;
            end
            S_7: begin
                i <= i+4'd1;
            end
        endcase
    end

    assign r_rsel = int_r_rsel;
    assign a_rsel = int_a_rsel;
    assign a_wsel = int_a_wsel;
    assign temp_sel = int_temp_sel;
    assign out_sel = int_out_sel;
    assign e_sel = int_e_sel;
    assign q_sel = int_q_sel;
    assign k_load = int_k_load;
    assign e_load = int_e_load;
    assign q_load = int_q_load;
    assign ready = int_ready;


endmodule