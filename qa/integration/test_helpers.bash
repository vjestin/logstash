download_elasticsearch() {
    echo "Downloading Elasticsearch version ${ES_VERSION} to ${ES_DIR}"
    local es_tar=${TESTS_WORKSPACE}/elasticsearch.tar.gz
    curl -sL $ES_DOWNLOAD_URL > $es_tar
    mkdir -p $ES_DIR
    tar -xzf $es_tar --strip-components=1 -C $ES_DIR
}

start_elasticsearch() {
    #to not make ES hang, we need FD trick '3>-'. see https://github.com/sstephenson/bats/issues/80
    run bash -ilc "$ES_DIR/bin/elasticsearch -d -p ${ES_PID_FILE}" 3>- &
    wget -O - --retry-connrefused --waitretry=1 --timeout=60 --tries 10 http://localhost:9200/_cluster/health
}

stop_elasticsearch() {
    pid=$(cat ${ES_PID_FILE})
    [ "x$pid" != "x" ] && [ "$pid" -gt 0 ]
    kill -SIGTERM $pid
}

clear_elasticsearch() {
    rm -rf $ES_DIR/data
    rm -rf $ES_PID_FILE
}
