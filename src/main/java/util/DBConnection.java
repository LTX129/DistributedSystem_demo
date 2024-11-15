package util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static HikariDataSource dataSource;
    private static boolean debug = true;

    static {
        try {
            // 加载配置文件
            Properties properties = new Properties();
            FileInputStream input = new FileInputStream("D:\\A课程文件\\大四\\DS\\pj\\src\\main\\database.properties");
            properties.load(input);

            // 初始化 HikariCP 数据源配置
            HikariConfig config = new HikariConfig();
            config.setDriverClassName(properties.getProperty("DriverClassName"));
            config.setJdbcUrl(properties.getProperty("JdbcUrl"));
            config.setUsername(properties.getProperty("Username"));
            config.setPassword(properties.getProperty("Password"));
            config.setMaximumPoolSize(Integer.parseInt(properties.getProperty("MaximumPoolSize")));
            config.setMinimumIdle(Integer.parseInt(properties.getProperty("MinimumIdle")));

            // 创建 HikariDataSource 实例
            dataSource = new HikariDataSource(config);

            if (debug) {
                System.out.println("DBConnection: HikariCP DataSource initialized");
            }
        } catch (IOException e) {
            System.err.println("DBConnection Error: Unable to load properties file");
            e.printStackTrace();
            throw new RuntimeException("Failed to load database properties file", e);
        } catch (Exception e) {
            System.err.println("DBConnection Error: Failed to initialize HikariCP DataSource");
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize HikariCP DataSource", e);
        }
    }

    /**
     * 获取数据库连接
     * @return Connection 数据库连接对象
     * @throws SQLException
     */
    public static Connection initializeDatabase() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        } else {
            throw new SQLException("DataSource is not initialized.");
        }
    }

    /**
     * 关闭数据源
     */
    public static void closeDataSource() {
        if (dataSource != null) {
            dataSource.close();
            if (debug) {
                System.out.println("DBConnection: HikariCP DataSource closed");
            }
        }
    }

    /**
     * 构造器
     */
    public DBConnection() {
        if (debug) {
            System.out.println("DBConnection: Initializing HikariCP DataSource...");
        }
    }
}
