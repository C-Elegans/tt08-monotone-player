#!/bin/bash
set -e

cd spinal
millw tinytapeout.runMain tinytapeout.VerilogTop

cp hw/gen/tt_um_elegans_design.v ../src/
