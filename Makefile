# Definición de las instrucciones (C = compile, R = run, S = show)
C = iverilog
R = vvp
S = gtkwave

# Definición de los archivos a usar
TARGET1 = I2C_Module.v
TARGET2 = Tx.v
TARGET3 = Rx_Module.v
.PHONY: gen
.PHONY: cmos
.PHONY: retardo
.PHONY: estructural

default: all

all:
	$(C) -o $(TARGET1).o test_bench_I2C.v
	$(R) $(TARGET1).o
	$(S) $(TARGET1).vcd



clean:
	rm -rf *.o *.out *.vcd
