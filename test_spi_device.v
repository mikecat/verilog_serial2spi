module test_spi_device(reset, sck, mosi, miso);
	input reset;
	input mosi;
	output miso;
	input sck;

	wire miso;

	reg [7:0] data;
	reg buffer;
	assign miso = ~data[7];

	always @(negedge reset) begin
		data[7:0] <= 8'b0;
		buffer <= 1'b0;
	end

	always @(posedge sck) begin
		buffer <= mosi;
	end

	always @(negedge sck) begin
		data[7:0] = { data[6:0] , buffer };
	end

endmodule
