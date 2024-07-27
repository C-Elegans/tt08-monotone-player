#pragma once
#include <vector>
#include <string>
#include <sstream>
#include <memory>
#include <iomanip>
#include <stdint.h>
#include <stdio.h>
#include <CImg.h>

template<typename T>
struct VGADump {
public:
    VGADump(std::string frameFolder, int width, int height)
	:frameFolder(frameFolder), width(width), height(height),
	 currentImage(width, height, 1, 3, 0),
	 xCoord(0), yCoord(0), frameCounter(0) {
    }
    ~VGADump(){
    }

    void newImage() {
	std::stringstream ss;
	ss << frameFolder << "/frame" << std::setw(5) << std::setfill('0') << frameCounter << ".bmp";
	currentImage.save(ss.str().c_str());
	frameCounter++;
	currentImage.fill(0);
    }

    void writePixel(uint8_t r, uint8_t g, uint8_t b){
	if(xCoord < width && yCoord < height){
	    currentImage(xCoord, yCoord, 0, 0) = r;
	    currentImage(xCoord, yCoord, 0, 1) = g;
	    currentImage(xCoord, yCoord, 0, 2) = b;
	}
    }

    void callback(T& top){
	if(top.vga_hsync && !inHSync){
	    xCoord = 0;
	    yCoord+= 1;
	}
	if(top.vga_vsync && !inVSync){
	    yCoord = 0;
	    newImage();
	}

	if(!top.vga_vsync && !top.vga_hsync){
	    writePixel(top.vga_r * 64, top.vga_g * 64, top.vga_b * 64);
	    xCoord+=1;
	}

	inHSync = top.vga_hsync;
	inVSync = top.vga_vsync;
    }
private:
    std::string frameFolder;
    int width;
    int height;
    cimg_library::CImg<uint8_t> currentImage;

    int xCoord = 0;
    int yCoord = 0;
    bool inHSync = false;
    bool inVSync = false;

    int frameCounter = 0;
    
};
