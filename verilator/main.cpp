#include <verilated.h>
#include <verilated_vcd_c.h>
#include "spi_mem.h"

#include <VTop.h>
#include <memory>

int main(int argc, char** argv){

    Verilated::mkdir("output");
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    context->traceEverOn(true);
    auto trace = std::make_unique<VerilatedVcdC>();

    VTop top{context.get()};
    top.trace(trace.get(), 99);
    trace->open("dump.vcd");

    auto mem = SpiMemSim<VTop>("memory.bin");

    top.resetn = 0;
    top.eval();
    top.resetn = 1;
    top.eval();


    for(int i=0; i<1000000; i++){
	top.eval();
	mem.callback(top);
	top.eval();
	context->timeInc(1);
	top.clk = 0;
	top.eval();
	trace->dump(context->time());
	context->timeInc(1);
	top.clk = 1;
	top.eval();
	trace->dump(context->time());
    }

    top.final();
}
