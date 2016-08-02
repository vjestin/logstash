# Place to store all common env variables for reuse

TESTS_WORKSPACE=$BATS_TMPDIR
LS_VERSION=5.0.0-alpha5
LS_DIR=$BATS_TEST_DIRNAME/../../build/logstash-5.0.0-alpha5-SNAPSHOT
ES_DIR=$TESTS_WORKSPACE/elasticsearch
ES_VERSION=5.0.0-alpha4
ES_PID_FILE=$TESTS_WORKSPACE/elasticsearch.pid
ES_DOWNLOAD_URL=https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ES_VERSION/elasticsearch-$ES_VERSION.tar.gz
LS_DOWNLOAD_URL=https://download.elastic.co/logstash/logstash/logstash-$LS_VERSION.tar.gz
