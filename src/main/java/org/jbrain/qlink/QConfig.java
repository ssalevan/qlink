package org.jbrain.qlink;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.log4j.Logger;

/** Represents the global configuration for the current QLink Reloaded instance. */
public class QConfig {

  public static final String DEFAULT_CONFIG_FILE = "qlink_defaults.properties";

  private static Logger _log = Logger.getLogger(QConfig.class);
  private static Configuration _config = null;

  public static void readConfigurationFromFile(String configFileLoc) {
    try {
      _config = new PropertiesConfiguration(configFileLoc);
    } catch (ConfigurationException ce) {
      _log.fatal("Unable to parse configuration: " + ce.getMessage());
      System.exit(2);
    }
  }

  public static void readDefaultConfiguration() {
    try {
      _config =
          new PropertiesConfiguration(
              QConfig.class.getClassLoader().getResource(DEFAULT_CONFIG_FILE));
    } catch (ConfigurationException ce) {
      _log.fatal("Unable to parse default configuration: " + ce.getMessage());
      System.exit(2);
    }
  }

  public static Configuration getInstance() {
    if (_config == null) {
      _log.warn("getConfigInstance() called without config initialization, using defaults");
      QConfig.readDefaultConfiguration();
    }
    return _config;
  }
}
