module ice40_top(/*AUTOARG*/
    // Outputs
    spi_ss, spi_sclk, spi_mosi, audio_out,
    // Inputs
    clk_12, spi_miso
    );
    input wire clk_12;
   
    output wire	spi_ss;
    output wire	spi_sclk;
    output wire	spi_mosi;
    input wire	spi_miso;
    output wire	audio_out;

    wire	rst_n;
    wire	clk_20;
   
   
   
   pll pll(
	   // Outputs
	   .clock_out			(clk_20),
	   .locked			(rst_n),
	   // Inputs
	   .clock_in			(clk_12));

   Top top(
	   // Outputs
	   .spi_ss			(spi_ss),
	   .spi_sclk			(spi_sclk),
	   .spi_mosi			(spi_mosi),
	   .osc				(audio_out),
	   // Inputs
	   .spi_miso			(spi_miso),
	   .clk				(clk_20),
	   .resetn			(rst_n));
   
   

endmodule // ice40_top


// Local Variables:
// verilog-library-directories:("../spinal/hw/gen")
// End:
