module tb_lpc_encode (
    );

    reg reset, clk, start;
    wire [31:0] y;
    wire [10:0] wsel;
    
    reg wen;
    reg [7:0] waddr;
    reg [15:0] din;

    reg [15:0] din_values [0:159];
    integer i;
    
    lpc_encode dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        // .r_din(y),
        // .r_wsel(wsel),

        .x_wen(wen),
        .x_waddr(waddr),
        .x_din(din)
    );

    initial begin
        // Initialize inputs
        clk = 1;
        start = 0;

        // initial begin
        din_values[0] = 16'hFFC7; din_values[1] = 16'hFD54; din_values[2] = 16'hFC5E; din_values[3] = 16'hFD41; din_values[4] = 16'hFD63; din_values[5] = 16'hFF97; din_values[6] = 16'hFED1; din_values[7] = 16'hFBCA; din_values[8] = 16'hFAE1; din_values[9] = 16'hFBD7; din_values[10] = 16'hFB3F; din_values[11] = 16'hFC31; din_values[12] = 16'hFBF6; din_values[13] = 16'hFB29; din_values[14] = 16'hF96F; din_values[15] = 16'hF7FE; din_values[16] = 16'hF7FE; din_values[17] = 16'hF89D; din_values[18] = 16'hFAC1; din_values[19] = 16'hFAB9; din_values[20] = 16'hFA25; din_values[21] = 16'hFA2B; din_values[22] = 16'hFBDC; din_values[23] = 16'hFCA9; din_values[24] = 16'hFD49; din_values[25] = 16'hFF13; din_values[26] = 16'h013E; din_values[27] = 16'h0089; din_values[28] = 16'hFFA9; din_values[29] = 16'h02CA; din_values[30] = 16'h0229; din_values[31] = 16'h024B; din_values[32] = 16'h05D2; din_values[33] = 16'h0850; din_values[34] = 16'h06BB; din_values[35] = 16'h060D; din_values[36] = 16'h087B; din_values[37] = 16'h09D5; din_values[38] = 16'h0CED; din_values[39] = 16'h10C1; din_values[40] = 16'h101D; din_values[41] = 16'h1014; din_values[42] = 16'h1469; din_values[43] = 16'h15BA; din_values[44] = 16'h1948; din_values[45] = 16'h1F88; din_values[46] = 16'h20E2; din_values[47] = 16'h1FE7; din_values[48] = 16'h2013; din_values[49] = 16'h1A6F; din_values[50] = 16'h08DC; din_values[51] = 16'hF268; din_values[52] = 16'hE386; din_values[53] = 16'hDDFC; din_values[54] = 16'hDCEA; din_values[55] = 16'hDF4F; din_values[56] = 16'hE57B; din_values[57] = 16'hE997; din_values[58] = 16'hEA28; din_values[59] = 16'hEE96; din_values[60] = 16'hF9FE; din_values[61] = 16'h05F1; din_values[62] = 16'h0EB1; din_values[63] = 16'h1472; din_values[64] = 16'h13DC; din_values[65] = 16'h0C82; din_values[66] = 16'h0372; din_values[67] = 16'hFB69; din_values[68] = 16'hF501; din_values[69] = 16'hF04A; din_values[70] = 16'hEAA0; din_values[71] = 16'hE439; din_values[72] = 16'hE0E2; din_values[73] = 16'hE1DF; din_values[74] = 16'hE5E2; din_values[75] = 16'hEE11; din_values[76] = 16'hF8A1; din_values[77] = 16'h0164; din_values[78] = 16'h06D1; din_values[79] = 16'h09CA; din_values[80] = 16'h0B38; din_values[81] = 16'h0AAA; din_values[82] = 16'h0755; din_values[83] = 16'hFF9C; din_values[84] = 16'hF4F7; din_values[85] = 16'hEBF7; din_values[86] = 16'hE42D; din_values[87] = 16'hDD04; din_values[88] = 16'hDDA1; din_values[89] = 16'hE5F4; din_values[90] = 16'hECDC; din_values[91] = 16'hF1E1; din_values[92] = 16'hF92F; din_values[93] = 16'hFE15; din_values[94] = 16'hFF0E; din_values[95] = 16'h0315; din_values[96] = 16'h08A5; din_values[97] = 16'h0A6F; din_values[98] = 16'h0AA1; din_values[99] = 16'h0AFA; din_values[100] = 16'h0951; din_values[101] = 16'h0860; din_values[102] = 16'h0A8D; din_values[103] = 16'h0D0B; din_values[104] = 16'h0E44; din_values[105] = 16'h100A; din_values[106] = 16'h12EA; din_values[107] = 16'h1732; din_values[108] = 16'h1E06; din_values[109] = 16'h26FE; din_values[110] = 16'h2F22; din_values[111] = 16'h3674; din_values[112] = 16'h3C76; din_values[113] = 16'h412B; din_values[114] = 16'h399A; din_values[115] = 16'h12C1; din_values[116] = 16'hE25C; din_values[117] = 16'hD038; din_values[118] = 16'hCDF0; din_values[119] = 16'hC5E5; din_values[120] = 16'hD05D; din_values[121] = 16'hE77E; din_values[122] = 16'hE6D6; din_values[123] = 16'hDFAB; din_values[124] = 16'hEF62; din_values[125] = 16'h01B5; din_values[126] = 16'h0C9A; din_values[127] = 16'h2092; din_values[128] = 16'h2FE7; din_values[129] = 16'h2A47; din_values[130] = 16'h1C2E; din_values[131] = 16'h0A52; din_values[132] = 16'hF57E; din_values[133] = 16'hEB53; din_values[134] = 16'hE7B5; din_values[135] = 16'hDD60; din_values[136] = 16'hD6BB; din_values[137] = 16'hD8E5; din_values[138] = 16'hD6C1; din_values[139] = 16'hD836; din_values[140] = 16'hE963; din_values[141] = 16'hFCF3; din_values[142] = 16'h09F5; din_values[143] = 16'h178F; din_values[144] = 16'h20DB; din_values[145] = 16'h1F4A; din_values[146] = 16'h1A81; din_values[147] = 16'h14F0; din_values[148] = 16'h0B92; din_values[149] = 16'h027A; din_values[150] = 16'hF91D; din_values[151] = 16'hEBDD; din_values[152] = 16'hE1AD; din_values[153] = 16'hDE0E; din_values[154] = 16'hDB5A; din_values[155] = 16'hDC05; din_values[156] = 16'hE4D9; din_values[157] = 16'hEEFB; din_values[158] = 16'hF52C; din_values[159] = 16'hFCBE; 
        // end

        #1

        reset = 0;
        #10
        reset = 1;
        #10
        reset = 0;


        // Write data to register iteratively
        for (i = 0; i < 160; i = i + 1) begin
            wen = 1;
            waddr = i;
            din = din_values[i];
            #10;
        end

        wen=0;
        #10
        start=1;
        #10
        start=0;
        #1600;


    end

    always #5 clk = ~clk; // Toggle clock every 5 time units

endmodule