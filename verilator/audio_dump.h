#include <vector>
#include <stdint.h>
#include <stdio.h>

template<typename T>
struct AudioDump {
public:
    AudioDump(const char* romfile, double clockFrequency, double sampleRate) {
	f = fopen(romfile, "wb");
	sampleTime = 1/sampleRate;
	clockPeriod = 1/clockFrequency;

	sampleData = 0;
	sampleCount = 0;
	currentTime = 0;
    }
    ~AudioDump(){
	fflush(f);
	fclose(f);
    }

    void writeSample(){
	float sampleFraction = sampleData / (float) sampleCount;
	int8_t sample = 127 * sampleFraction;
	fwrite(&sample, 1, 1, f);
	sampleCount = 0;
	sampleData = 0;
    }

    void callback(T& top){
	if(top.osc){
	    sampleData += 1;
	} else {
	    sampleData -= 1;
	}
	sampleCount += 1;
	currentTime += clockPeriod;
	if(currentTime >= sampleTime){
	    writeSample();
	    currentTime -= sampleTime;
	}
    }
private:
    int sampleCount;
    int sampleData;
    double sampleTime;
    double clockPeriod;
    double currentTime;
    
    FILE *f;
};
