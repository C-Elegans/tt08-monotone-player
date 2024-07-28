#include <vector>
#include <stdint.h>
#include <stdio.h>

template<typename T>
struct SpiMemSim {
public:
    SpiMemSim(const char* romfile) {
	memory.resize(65535);
	FILE* f = fopen(romfile, "rb");
	fread(memory.data(), 1, 65535, f);
	fclose(f);

    }

    enum class SpiState { Command, Addr1, Addr2, Data};

    std::vector<uint8_t> memory;
    uint8_t dataIn;
    uint8_t dataOut;
    bool overflow = false;
    uint16_t address;
    SpiState state = SpiState::Command;
    uint8_t bitCount;

    bool sclk_prev = false;

    void handle_recv_byte(uint8_t byte){
	switch(state){
	case SpiState::Command: {
	    if(byte == 0x3){
		printf("Received read command, moving to addr1\n");
		state = SpiState::Addr1;
	    } else {
		printf("Error, received invalid command: %x\n", byte);
	    }
	    break;
	}
	case SpiState::Addr1: {
	    address = ((uint16_t) byte) << 8;
	    state = SpiState::Addr2;
	    break;
	}
	case SpiState::Addr2: {
	    address = address | byte;
	    state = SpiState::Addr2;
	    dataOut = memory[address];
	    printf("Reading from address 0x%04x -> %02x\n", address, dataOut);
	    if(address == 0xffff){
		overflow = true;
	    }
	    break;
	}
	case SpiState::Data: {
	    address += 1;
	    dataOut = memory[address];
	    break;
	}
	}

    }

    void callback(T& top){
	if(top.spi_ss == 0){
	    if(sclk_prev == 0 && top.spi_sclk == 1){
		dataIn = (dataIn << 1) | top.spi_mosi;
		bitCount += 1;
		if(bitCount == 8){
		    handle_recv_byte(dataIn);
		}
	    }
	    if(sclk_prev == 1 && top.spi_sclk == 0){
		top.spi_miso = dataOut >> 7;
		dataOut = dataOut << 1;

		if(bitCount == 8){
		    bitCount = 0;
		}
	    }
	} else {
	    state = SpiState::Command;
	    bitCount = 0;
	    dataOut = 0;
	    top.spi_miso = 0;
	}
	sclk_prev = top.spi_sclk;
    }
};
