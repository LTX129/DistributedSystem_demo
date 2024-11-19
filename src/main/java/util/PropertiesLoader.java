package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

/**
 * Utility class for loading properties from a configuration file.
 * This class loads properties from a file located at the parent directory of the current working directory.
 */
public class PropertiesLoader {

    private static final Properties properties = new Properties();
    private static String currentDir = System.getProperty("user.dir");
    private static File currentDirFile = new File(currentDir);
    private static File parentDirFile = currentDirFile.getParentFile();
    private static String parentDir = parentDirFile.getAbsolutePath();
    private static String propertiesPath = parentDir + "\\webapps";

    static {
        try (FileInputStream input = new FileInputStream(propertiesPath + "\\application.properties")) {
            properties.load(input);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load properties file", e);
        }
    }

    /**
     * Retrieves a property value as a String.
     *
     * @param key the property key
     * @return the property value associated with the key
     */
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }

    /**
     * Retrieves a property value as an integer.
     *
     * @param key the property key
     * @return the property value associated with the key, parsed as an integer
     */
    public static int getIntProperty(String key) {
        return Integer.parseInt(properties.getProperty(key));
    }

    /**
     * Retrieves a property value as a long.
     *
     * @param key the property key
     * @return the property value associated with the key, parsed as a long
     */
    public static long getLongProperty(String key) {
        return Long.parseLong(properties.getProperty(key));
    }
}
