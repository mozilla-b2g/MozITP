#!/bin/bash
set -e
export TEST_FILES=gaiatest/tests/functional/clock/test_clock_run_stopwatch_laps.py
source ./launch.sh gip #use source to get the correct error code
