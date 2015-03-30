`timescale 1ps/1ps

module serial2spi_test;
	reg reset;
	reg clk;
	wire [7:0] data;
	wire tx;
	wire rx;
	wire rts;
	wire cts;
	wire end_flag;
	wire sck;
	wire mosi;
	wire miso;

	parameter osc = 1000000 / 4;

	test_serial_device input_device (reset, clk, data, tx, rts, cts, end_flag);
	serial2spi converter (reset, clk, tx, rx, rts, cts, sck, mosi, miso);
	test_spi_device output_device (reset, sck, mosi, miso);

	initial begin
		$dumpfile("serial2spi_test.vcd");
		$dumpvars(0, serial2spi_test);

		reset <= 1'b1;
		clk <= 1'b0;
		#10
		reset <= 1'b0;
		#10
		reset <= 1'b1;
	end

	always #(osc/2) begin
		clk <= ~clk;
	end

	always @(posedge clk) begin
		if (end_flag) $finish;
	end

endmodule
