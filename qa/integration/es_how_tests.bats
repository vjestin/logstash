#!/usr/bin/env bats

# This test ingests hands on workshop data, which is 300K lines of 
# apache access logs. This goes through the usual grok, geoip, and date filters.

load environment
load test_helpers

HOW_DATA_SET_URL=https://s3.amazonaws.com/data.elasticsearch.org/logstash/logs.gz

setup() {
    download_elasticsearch
    start_elasticsearch
}

teardown() {
    stop_elasticsearch
}

@test "can ingest 300K docs to ES" {
    curl -sL $HOW_DATA_SET_URL > logs.gz
    gunzip logs.gz
    run bash -c "cat logs | $LS_DIR/bin/logstash -f $BATS_TEST_DIRNAME/fixtures/configs/hands_on_workshop.conf"
    num_docs="$(curl -sL localhost:9200/_search?size=0 | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["hits"]["total"]')"
    [ $num_docs -eq 300000 ]
}