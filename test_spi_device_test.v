`timescale 1ps/1ps

module test_spi_device_test;
	reg running;
	reg [7:0] data;
	reg [3:0] cnt;
	reg [4:0] clk_cnt;
	reg clk;
	reg reset;

	reg end_flag;
	reg [7:0] buffer;
	wire mosi;
	reg sck;
	wire miso;
	assign mosi = buffer[7];

	parameter osc = 1000000 / 4;

	test_spi_device device (reset, sck, mosi, miso);

	initial begin
		$dumpfile("test_spi_device_test.vcd");
		$dumpvars(0, test_spi_device_test);

		reset <= 1'b1;
		running <= 1'b0;
		cnt <= 3'b0;
		clk <= 1'b0;
		clk_cnt <= 5'b0;
		data <= 8'b0;
		end_flag <= 1'b0;
		#10
		reset <= 1'b0;
		#10
		reset <= 1'b1;
	end

	always #(osc/2) begin
		clk <= ~clk;
	end

	always @(posedge clk) begin
		clk_cnt <= clk_cnt + 4'b1;
		if (running) begin
			if (clk_cnt == 5'b01111) begin
				sck <= 1'b1;
			end
			if (clk_cnt == 5'b11111) begin
				sck <= 1'b0;
				buffer[7:0] <= { buffer[6:0] , miso };
				cnt <= cnt + 3'b1;
				if (cnt == 3'b111) begin
					running <= 1'b0;
					data[7:0] <= data[7:0] + 8'b1;
					if (data[7:0] == 8'b11111111) end_flag <= 1'b1;
				end
			end
		end else begin
			if (clk_cnt == 5'b11111) begin
				running <= 1'b1;
				cnt <= 3'b0;
				buffer[7:0] <= data[7:0];
				if (end_flag) $finish;
			end
		end
	end

endmodule
