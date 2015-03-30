.PHONY: all
all: test_spi_device_test.vcd serial2spi_test.vcd

test_spi_device_test.vcd: test_spi_device_test.vpi
	vvp test_spi_device_test.vpi

test_spi_device_test.vpi: test_spi_device_test.v test_spi_device.v
	iverilog -o test_spi_device_test.vpi test_spi_device_test.v test_spi_device.v

serial2spi_test.vcd: serial2spi_test.vpi
	vvp serial2spi_test.vpi

serial2spi_test.vpi: serial2spi_test.v serial2spi.v test_serial_device.v test_spi_device.v
	iverilog -o serial2spi_test.vpi serial2spi_test.v serial2spi.v test_serial_device.v test_spi_device.v
