INCLUDES = include/

all: build run

build:
	iverilog -o Reset_ex Reset/test_bench_reset.v
	
run:
	vvp Reset_ex
	gtkwave Reset.vcd

clean:
	rm Reset_ex Reset.vcd
