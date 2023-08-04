module tb_autocorrelation_mad ();

    reg clk;
    reg reset;
    reg [15:0] x;
    reg [15:0] x_lagged;
    wire [31:0] product;
    wire [31:0] y;

    // Instantiate your module
    autocorrelation_mad autocorrelation_mad_0 (
      .clk(clk),
      .reset(reset),
      .x(x),
      .x_lagged(x_lagged),
      .product(product),
      .y(y)
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
      
      x = -58;
      x_lagged = -835;
      #10
      x = -685;
      x_lagged = -58;
      #10
      x = -931;
      x_lagged = -685;
      #10
      x = -704;
      x_lagged = -931;
      #10
      x = -670;
      x_lagged = -704;
      #10
      x = -106;
      x_lagged = -670;
      #10
      x = -304;
      x_lagged = -106;
      #10
      x = -1079;
      x_lagged = -304;
      #10
      x = -1312;
      x_lagged = -1079;
      #10
      x = -1066;
      x_lagged = -1312;
      #10
      x = -1218;
      x_lagged = -1066;
      #10
      x = -976;
      x_lagged = -1218;
      #10
      x = -1035;
      x_lagged = -976;
      #10
      x = -1240;
      x_lagged = -1035;
      #10
      x = -1682;
      x_lagged = -1240;
      #10
      x = -2051;
      x_lagged = -1682;
      #10
      x = -2051;
      x_lagged = -2051;
      #10
      x = -1892;
      x_lagged = -2051;
      #10
      x = -1344;
      x_lagged = -1892;
      #10
      x = -1352;
      x_lagged = -1344;
      #10
      x = -1500;
      x_lagged = -1352;
      #10
      x = -1494;
      x_lagged = -1500;
      #10
      x = -1061;
      x_lagged = -1494;
      #10
      x = -856;
      x_lagged = -1061;
      #10
      x = -696;
      x_lagged = -856;
      #10
      x = -238;
      x_lagged = -696;
      #10
      x = 318;
      x_lagged = -238;
      #10
      x = 137;
      x_lagged = 318;
      #10
      x = -88;
      x_lagged = 137;
      #10
      x = 714;
      x_lagged = -88;
      #10
      x = 553;
      x_lagged = 714;
      #10
      x = 587;
      x_lagged = 553;
      #10
      x = 1490;
      x_lagged = 587;
      #10
      x = 2128;
      x_lagged = 1490;
      #10
      x = 1723;
      x_lagged = 2128;
      #10
      x = 1549;
      x_lagged = 1723;
      #10
      x = 2171;
      x_lagged = 1549;
      #10
      x = 2517;
      x_lagged = 2171;
      #10
      x = 3309;
      x_lagged = 2517;
      #10
      x = 4289;
      x_lagged = 3309;
      #10
      x = 4125;
      x_lagged = 4289;
      #10
      x = 4116;
      x_lagged = 4125;
      #10
      x = 5225;
      x_lagged = 4116;
      #10
      x = 5562;
      x_lagged = 5225;
      #10
      x = 6472;
      x_lagged = 5562;
      #10
      x = 8072;
      x_lagged = 6472;
      #10
      x = 8418;
      x_lagged = 8072;
      #10
      x = 8167;
      x_lagged = 8418;
      #10
      x = 8211;
      x_lagged = 8167;
      #10
      x = 6767;
      x_lagged = 8211;
      #10
      x = 2268;
      x_lagged = 6767;
      #10
      x = -3481;
      x_lagged = 2268;
      #10
      x = -7291;
      x_lagged = -3481;
      #10
      x = -8709;
      x_lagged = -7291;
      #10
      x = -8983;
      x_lagged = -8709;
      #10
      x = -8370;
      x_lagged = -8983;
      #10
      x = -6790;
      x_lagged = -8370;
      #10
      x = -5738;
      x_lagged = -6790;
      #10
      x = -5593;
      x_lagged = -5738;
      #10
      x = -4459;
      x_lagged = -5593;
      #10
      x = -1539;
      x_lagged = -4459;
      #10
      x = 1521;
      x_lagged = -1539;
      #10
      x = 3761;
      x_lagged = 1521;
      #10
      x = 5234;
      x_lagged = 3761;
      #10
      x = 5084;
      x_lagged = 5234;
      #10
      x = 3202;
      x_lagged = 5084;
      #10
      x = 882;
      x_lagged = 3202;
      #10
      x = -1176;
      x_lagged = 882;
      #10
      x = -2816;
      x_lagged = -1176;
      #10
      x = -4023;
      x_lagged = -2816;
      #10
      x = -5473;
      x_lagged = -4023;
      #10
      x = -7112;
      x_lagged = -5473;
      #10
      x = -7967;
      x_lagged = -7112;
      #10
      x = -7714;
      x_lagged = -7967;
      #10
      x = -6687;
      x_lagged = -7714;
      #10
      x = -4592;
      x_lagged = -6687;
      #10
      x = -1888;
      x_lagged = -4592;
      #10
      x = 356;
      x_lagged = -1888;
      #10
      x = 1745;
      x_lagged = 356;
      #10
      x = 2506;
      x_lagged = 1745;
      #10
      x = 2872;
      x_lagged = 2506;
      #10
      x = 2730;
      x_lagged = 2872;
      #10
      x = 1877;
      x_lagged = 2730;
      #10
      x = -101;
      x_lagged = 1877;
      #10
      x = -2826;
      x_lagged = -101;
      #10
      x = -5130;
      x_lagged = -2826;
      #10
      x = -7124;
      x_lagged = -5130;
      #10
      x = -8957;
      x_lagged = -7124;
      #10
      x = -8800;
      x_lagged = -8957;
      #10
      x = -6669;
      x_lagged = -8800;
      #10
      x = -4901;
      x_lagged = -6669;
      #10
      x = -3616;
      x_lagged = -4901;
      #10
      x = -1746;
      x_lagged = -3616;
      #10
      x = -492;
      x_lagged = -1746;
      #10
      x = -243;
      x_lagged = -492;
      #10
      x = 789;
      x_lagged = -243;
      #10
      x = 2213;
      x_lagged = 789;
      #10
      x = 2671;
      x_lagged = 2213;
      #10
      x = 2721;
      x_lagged = 2671;
      #10
      x = 2810;
      x_lagged = 2721;
      #10
      x = 2385;
      x_lagged = 2810;
      #10
      x = 2144;
      x_lagged = 2385;
      #10
      x = 2701;
      x_lagged = 2144;
      #10
      x = 3339;
      x_lagged = 2701;
      #10
      x = 3652;
      x_lagged = 3339;
      #10
      x = 4106;
      x_lagged = 3652;
      #10
      x = 4842;
      x_lagged = 4106;
      #10
      x = 5938;
      x_lagged = 4842;
      #10
      x = 7686;
      x_lagged = 5938;
      #10
      x = 9982;
      x_lagged = 7686;
      #10
      x = 12066;
      x_lagged = 9982;
      #10
      x = 13940;
      x_lagged = 12066;
      #10
      x = 15478;
      x_lagged = 13940;
      #10
      x = 16683;
      x_lagged = 15478;
      #10
      x = 14746;
      x_lagged = 16683;
      #10
      x = 4801;
      x_lagged = 14746;
      #10
      x = -7589;
      x_lagged = 4801;
      #10
      x = -12233;
      x_lagged = -7589;
      #10
      x = -12817;
      x_lagged = -12233;
      #10
      x = -14876;
      x_lagged = -12817;
      #10
      x = -12196;
      x_lagged = -14876;
      #10
      x = -6275;
      x_lagged = -12196;
      #10
      x = -6443;
      x_lagged = -6275;
      #10
      x = -8278;
      x_lagged = -6443;
      #10
      x = -4255;
      x_lagged = -8278;
      #10
      x = 437;
      x_lagged = -4255;
      #10
      x = 3226;
      x_lagged = 437;
      #10
      x = 8338;
      x_lagged = 3226;
      #10
      x = 12263;
      x_lagged = 8338;
      #10
      x = 10823;
      x_lagged = 12263;
      #10
      x = 7214;
      x_lagged = 10823;
      #10
      x = 2642;
      x_lagged = 7214;
      #10
      x = -2691;
      x_lagged = 2642;
      #10
      x = -5294;
      x_lagged = -2691;
      #10
      x = -6220;
      x_lagged = -5294;
      #10
      x = -8865;
      x_lagged = -6220;
      #10
      x = -10566;
      x_lagged = -8865;
      #10
      x = -10012;
      x_lagged = -10566;
      #10
      x = -10560;
      x_lagged = -10012;
      #10
      x = -10187;
      x_lagged = -10560;
      #10
      x = -5790;
      x_lagged = -10187;
      #10
      x = -782;
      x_lagged = -5790;
      #10
      x = 2549;
      x_lagged = -782;
      #10
      x = 6031;
      x_lagged = 2549;
      #10
      x = 8411;
      x_lagged = 6031;
      #10
      x = 8010;
      x_lagged = 8411;
      #10
      x = 6785;
      x_lagged = 8010;
      #10
      x = 5360;
      x_lagged = 6785;
      #10
      x = 2962;
      x_lagged = 5360;
      #10
      x = 634;
      x_lagged = 2962;
      #10
      x = -1764;
      x_lagged = 634;
      #10
      x = -5156;
      x_lagged = -1764;
      #10
      x = -7764;
      x_lagged = -5156;
      #10
      x = -8691;
      x_lagged = -7764;
      #10
      x = -9383;
      x_lagged = -8691;
      #10
      x = -9212;
      x_lagged = -9383;
      #10
      x = -6952;
      x_lagged = -9212;
      #10
      x = -4358;
      x_lagged = -6952;
      #10
      x = -2773;
      x_lagged = -4358;
      #10
      x = -835;
      x_lagged = -2773;
      #10


      // Provide test vectors
      // Change input values here

      #1000; // Simulation duration

    //   $finish; // End the simulation

    end

endmodule