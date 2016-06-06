package com.logstash;

public interface IMetric {
    void increment(String namespace, String key, int value);
    void decrement(String namespace, String key, int value);
    void gauge(String namespace, String key, int value);
    void report_time(String namespace, String key, int duration);

    Object time(String namespace, String key);
    String namespace(String name);
    Object collector();
}
