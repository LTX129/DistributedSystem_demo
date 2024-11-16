package util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {

    private static HikariDataSource dataSource;
    private static boolean debug = true;

    static {
        try {
            // 初始化 HikariCP 数据源配置
            HikariConfig config = new HikariConfig();
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");
            config.setJdbcUrl("jdbc:mysql://localhost:3306/ds_database?serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8&useSSL=false");
            config.setUsername("root");
            config.setPassword("123456");
            config.setMaximumPoolSize(60);
            config.setMinimumIdle(20);

            // 创建 HikariDataSource 实例
            dataSource = new HikariDataSource(config);

            if (debug) {
                System.out.println("DBConnection: HikariCP DataSource initialized");
            }
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
            // 调用 clearEncryptionKeys() 清除密钥
            clearEncryptionKeys();

            // 关闭数据源
            dataSource.close();
            if (debug) {
                System.out.println("DBConnection: HikariCP DataSource closed");
            }
        }
    }

    /**
     * 清除加密密钥（从缓存中删除）
     */
    public static void clearEncryptionKeys() {
        CacheUtility.remove("public_key");
        CacheUtility.remove("private_key");
        if (debug) {
            System.out.println("DBConnection: Encryption keys cleared from cache");
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
