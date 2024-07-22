module ice40_top(/*AUTOARG*/
    // Outputs
    spi_ss, spi_sclk, spi_mosi, audio_out,
    // Inputs
    clk_12, rst_n, spi_miso
    );
    input wire clk_12;
    input wire rst_n;
   
   
    output wire	spi_ss;
    output wire	spi_sclk;
    output wire	spi_mosi;
    input wire	spi_miso;
    output wire	audio_out;

    wire	rst_n_combined;
    wire	locked;
    wire	clk_20;
   
   assign rst_n_combined = rst_n & locked;
   
   
   pll pll(
	   // Outputs
	   .clock_out			(clk_20),
	   .locked			(locked),
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
	   .resetn			(rst_n_combined));
   
   

endmodule // ice40_top


// Local Variables:
// verilog-library-directories:("../spinal/hw/gen")
// End:
