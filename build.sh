#!/bin/bash
set -e
cd $(dirname "$0")

cd spinal
millw tinytapeout.runMain tinytapeout.VerilogTop

cp hw/gen/tt_um_monotone_player.v ../src/
