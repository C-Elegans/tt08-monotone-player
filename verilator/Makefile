TOP=Top
VERILATOR_CPP_FILES=main.cpp

VERILATOR_CXX_FLAGS=-O3

VERILATOR_FLAGS+=-Wno-fatal
VERILATOR_FLAGS+=--trace
VERILATOR_FLAGS+=-x-assign fast

all: obj_dir/V$(TOP)

obj_dir/V$(TOP).cpp: ../spinal/hw/gen/$(TOP).v
	verilator $(VERILATOR_FLAGS) -CFLAGS "$(VERILATOR_CXX_FLAGS)" --cc $< --exe $(VERILATOR_CPP_FILES)

obj_dir/V$(TOP): obj_dir/V$(TOP).cpp
	make -f V$(TOP).mk -C obj_dir -j16

.PHONY: obj_dir/V$(TOP)
