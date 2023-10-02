module lpc_encode_avalon (
    input clock,
    input reset,
    input [15:0] writedata,
    output [15:0] readdata,
    input write,
    input read,
	input [8:0] address,
    input chipselect
    );
	
    localparam ADDR_REG_X_BASE          = 9'd000; // WRITE
    localparam ADDR_REG_RESIDUE_BASE    = 9'd160; // READ
    localparam ADDR_REG_A_BASE          = 9'd320; // READ
    localparam ADDR_REG_CTRL_START      = 9'd340; // WRITE
    localparam ADDR_REG_CTRL_FIN        = 9'd341; // READ

    wire start;
    wire rready;

    wire x_wen;
    wire [7:0] x_waddr;
    wire [15:0] x_din;
    wire [7:0] x_raddr;
    wire [15:0] x_dout;

    wire [7:0] residue_raddr;
    wire [15:0] residue_dout;

    wire [9:0] a_rsel;
    wire [31:0] a_dout;

    assign x_wen = (chipselect==1'b1) && (address < ADDR_REG_RESIDUE_BASE) ? write : 1'b0;
    assign x_waddr = address[7:0];
    assign x_din = writedata;

    wire [8:0] residue_raddr_9 = address - ADDR_REG_RESIDUE_BASE;
    assign residue_raddr = residue_raddr_9[7:0];

    assign a_rsel = 10'b1 << ((address - ADDR_REG_A_BASE) >> 1'd1);

    wire [15:0] a_dout_L;
    wire [15:0] a_dout_H;
    assign a_dout_L = a_dout[15:0];
    assign a_dout_H = a_dout[31:16];

    assign readdata =   address < ADDR_REG_RESIDUE_BASE ?
									x_dout
								: (address < ADDR_REG_A_BASE ?
                            residue_dout
                        : (address < ADDR_REG_CTRL_START ?
                            (address % 2 ?
                                a_dout_H : a_dout_L)
                        : (address == ADDR_REG_CTRL_FIN ?
                            {15'b0, rready} : 16'h0000)));

    assign x_raddr = address -  ADDR_REG_X_BASE;
                                
    assign start =  (chipselect==1'b1) && (address == ADDR_REG_CTRL_START) ?
                        (writedata[0] & write) : 1'b0;

	lpc_encode U1 (
        .clk(clock),
        .reset(reset),

        .start(start),
        .rready(rready),

        .x_wen(x_wen),
        .x_waddr(x_waddr),
        .x_din(x_din),
        .x_raddr(x_raddr),
        .x_dout(x_dout),

        .residue_raddr(residue_raddr),
        .residue_dout(residue_dout),

        .a_rsel(a_rsel),
        .a_dout(a_dout)
        );
		
endmodule