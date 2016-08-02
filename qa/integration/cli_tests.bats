#!/usr/bin/env bats

# These tests checks the basic command line interface switches
# 
# I know we have acceptance tests that cover some of the CLI functionality
# but wanted to put something in here so we can quickly add tests to validate.
# The inspiration to these tests were to make sure no warning messages are output 
# when LS is started

load environment
GENERATOR_CONFIG="input { generator { \"message\" => \"this is a bats test for -e\" count => 1 }} output { stdout {} }"
BAD_CONFIG="output { stdout { }"

@test "prints logstash version for --version" {
    run $LS_DIR/bin/logstash --version
    [ "$status" -eq 0 ]
    [ "$output" = "logstash $LS_VERSION" ]
}

@test "prints logstash version for -V" {
    run $LS_DIR/bin/logstash -V
    [ "$status" -eq 0 ]
    [ "$output" = "logstash $LS_VERSION" ]
}

@test "prints usage for no arguments" {
    run $LS_DIR/bin/logstash
    [ "$status" -ne 0 ]
    # fix this after jackson warning is fixed
    [ "${lines[2]}" = "ERROR: No configuration file was specified. Perhaps you forgot to provide the '-f yourlogstash.conf' flag?" ]
    [ "${lines[3]}" = "usage:" ]
}

@test "prints help for --help" {
    run $LS_DIR/bin/logstash --help
    [ "$status" -eq 0 ]
    # fix this after jackson warning is fixed
    [ "${lines[2]}" = "Usage:" ]
    [[ "${lines[3]}" =~ "bin/logstash [OPTIONS]" ]]
}

@test "prints help for -h" {
    run $LS_DIR/bin/logstash --help
    [ "$status" -eq 0 ]
    # fix this after jackson warning is fixed
    [ "${lines[2]}" = "Usage:" ]
    [[ "${lines[3]}" =~ "bin/logstash [OPTIONS]" ]]
}

@test "-e flag works and pipeline is started with generator input" {
    run $LS_DIR/bin/logstash -e "${GENERATOR_CONFIG}"
    [ "$status" -eq 0 ]
    # fix this after jackson warning is fixed
    [[ ${lines[2]} =~ "Pipeline main started" ]]
    [[ ${lines[3]} =~ "this is a bats test for -e" ]]
    [[ ${lines[4]} =~ "Pipeline main has been shutdown" ]]
}

@test "-e flag does not work for bad config and outputs correct error message" {
    run $LS_DIR/bin/logstash -e "${BAD_CONFIG}"
    [ "$status" -ne 0 ]
    [[ ${lines[2]} =~ "fetched an invalid config" ]]
}

