package com.logstash;

// using Logback for SLF4J
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import java.util.HashMap;

public class Plugin {
    private static String _name;

    private Config _config;
    private HashMap<String, Object> _params;
    private Logger _logger;
    private IMetric _metric;

    public Plugin() {
        _logger = LoggerFactory.getLogger("org.logstash.plugin");
        loadGeneralConfig();
    }

    public Plugin(HashMap<String, Object> _params) {
        super();
        this._params = _params;
    }

    public Plugin addLogger(Logger loggr) {
        _logger = loggr;
        return this;
    }

    public Plugin addParams(final HashMap<String, Object> params) {
        _params = params;
        return this;
    }

    public Plugin addMetric(final IMetric metric) {
        _metric = metric;
        return this;
    }

    public Plugin addConfig(String pathOrResource) {
        Config additional = ConfigFactory.load(pathOrResource);
        _config = _config.withFallback(additional);
        return this;
    }

    public IMetric getMetric() {
        return _metric;
    }

    public static Plugin lookup(String type, String name) {
        return null;
    }

    public static String config_name(String name){
        return null;
    }

    protected void close() {
        // subclass must override
    }

    private void loadGeneralConfig() {
        Config _config = ConfigFactory.load("general");
    }
}
