package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class PropertiesLoader {
    private static final Properties properties = new Properties();
    private static String currentDir = System.getProperty("user.dir");
    private static File currentDirFile = new File(currentDir);
    private static File parentDirFile = currentDirFile.getParentFile();
    private static String parentDir = parentDirFile.getAbsolutePath();
    private static String propertiesPath = parentDir + "\\webapps";

    static {
        try (FileInputStream input = new FileInputStream(propertiesPath + "\\application.properties")) {
            //application.properties放置于Tomcat/webapps目录下
            properties.load(input);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load properties file", e);
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }

    public static int getIntProperty(String key) {
        return Integer.parseInt(properties.getProperty(key));
    }

    public static long getLongProperty(String key) {
        return Long.parseLong(properties.getProperty(key));
    }
}
