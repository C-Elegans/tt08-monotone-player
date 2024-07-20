#!/bin/bash

cd spinal
millw tinytapeout.runMain tinytapeout.VerilogTop

cp hw/gen/TopLevel.v ../src/
