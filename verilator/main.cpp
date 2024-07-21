#include <verilated.h>
#include <verilated_vcd_c.h>
#include "spi_mem.h"
#include "audio_dump.h"

#include <VTop.h>
#include <memory>

int main(int argc, char** argv){
    double clock_frequency = 20e6;
    double clock_period_ns = 1e9/clock_frequency;
    int time_increment = clock_period_ns * 1000 / 2;


    Verilated::mkdir("output");
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    context->traceEverOn(true);

    VTop top{context.get()};

    auto trace = std::make_unique<VerilatedVcdC>();
    top.trace(trace.get(), 99);
    trace->open("dump.vcd");

    auto mem = SpiMemSim<VTop>("memory.bin");
    auto audio = AudioDump<VTop>("audio.raw", clock_frequency, 200e3);

    top.resetn = 0;
    top.eval();
    top.resetn = 1;
    top.eval();


    for(int i=0; i<10000000; i++){
	top.eval();
	mem.callback(top);
	audio.callback(top);
	top.eval();
	context->timeInc(time_increment);
	top.clk = 0;
	top.eval();
	trace->dump(context->time());
	context->timeInc(time_increment);
	top.clk = 1;
	top.eval();
	trace->dump(context->time());
    }

    top.final();
}
