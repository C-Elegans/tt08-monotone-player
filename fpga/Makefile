PROJ=ice40_top
BUILDDIR=./build
DEVICE=8k
FOOTPRINT=ct256

FILES = ice40_top.v
FILES += pll.v
FILES += ../spinal/hw/gen/Top.v

.PHONY: all

all: $(BUILDDIR)/$(PROJ).bin


$(BUILDDIR)/$(PROJ).bin: $(FILES) Makefile pin_constraints.pcf
	mkdir -p $(BUILDDIR)
	yosys -p "synth_ice40 -top ice40_top -json $(BUILDDIR)/$(PROJ).json" $(FILES)
	nextpnr-ice40 --hx8k --package $(FOOTPRINT) --json $(BUILDDIR)/$(PROJ).json --pcf pin_constraints.pcf --asc $(BUILDDIR)/$(PROJ).asc
	icepack $(BUILDDIR)/$(PROJ).asc $(BUILDDIR)/$(PROJ).bin

prog_ram: $(BUILDDIR)/$(PROJ).bin
	iceprog -S $<

prog_flash: $(BUILDDIR)/$(PROJ).bin
	iceprog $<
