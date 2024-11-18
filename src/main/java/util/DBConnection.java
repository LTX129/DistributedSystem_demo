package util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {

    private static HikariDataSource primaryDataSource;
    private static HikariDataSource secondaryDataSource;
    private static boolean usePrimary = true;  // 用于标识当前是否使用主数据源
    private static boolean debug = true;

    static {
        try {
            // 初始化主数据源配置
            HikariConfig primaryConfig = new HikariConfig();
            primaryConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
            primaryConfig.setJdbcUrl("jdbc:mysql://localhost:3306/ds_database?serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8&useSSL=false");
            primaryConfig.setUsername("root");
            primaryConfig.setPassword("123456");
            primaryConfig.setMaximumPoolSize(60);
            primaryConfig.setMinimumIdle(20);

            // 创建主数据源实例
            primaryDataSource = new HikariDataSource(primaryConfig);

            if (debug) {
                System.out.println("DBConnection: Primary HikariCP DataSource initialized");
            }

            // 初始化从数据源配置
            HikariConfig secondaryConfig = new HikariConfig();
            secondaryConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
            secondaryConfig.setJdbcUrl("jdbc:mysql://localhost2:3306/ds_database?serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8&useSSL=false");
            secondaryConfig.setUsername("root");
            secondaryConfig.setPassword("123456");
            secondaryConfig.setMaximumPoolSize(60);
            secondaryConfig.setMinimumIdle(20);

            try {
                // 尝试创建从数据源实例
                secondaryDataSource = new HikariDataSource(secondaryConfig);
                if (debug) {
                    System.out.println("DBConnection: Secondary HikariCP DataSource initialized");
                }
            } catch (Exception e) {
                if (debug) {
                    System.err.println("DBConnection Warning: Failed to initialize Secondary HikariCP DataSource. Secondary database will not be available.");
                }
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
        if (usePrimary && primaryDataSource != null) {
            try {
                return primaryDataSource.getConnection();
            } catch (SQLException e) {
                if (debug) {
                    System.err.println("DBConnection Warning: Failed to connect to Primary DataSource, switching to Secondary DataSource.");
                }
                usePrimary = false;
            }
        }

        if (secondaryDataSource != null) {
            return secondaryDataSource.getConnection();
        } else if (primaryDataSource != null) {
            // 如果没有可用的从数据源，尝试重新使用主数据源
            usePrimary = true;
            return primaryDataSource.getConnection();
        } else {
            throw new SQLException("No available DataSource is initialized.");
        }
    }

    /**
     * 关闭数据源
     */
    public static void closeDataSource() {
        if (primaryDataSource != null) {
            primaryDataSource.close();
            if (debug) {
                System.out.println("DBConnection: Primary HikariCP DataSource closed");
            }
        }
        if (secondaryDataSource != null) {
            secondaryDataSource.close();
            if (debug) {
                System.out.println("DBConnection: Secondary HikariCP DataSource closed");
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