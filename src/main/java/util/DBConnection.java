package util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class DBConnection {

    private static HikariDataSource primaryDataSource;
    private static HikariDataSource secondaryDataSource;
    private static volatile boolean usePrimary = true;  // 用于标识当前是否使用主数据源
    private static boolean debug = true;
    private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    static {
        try {
            // 初始化主数据源配置
            HikariConfig primaryConfig = new HikariConfig();
            primaryConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
            primaryConfig.setJdbcUrl(PropertiesLoader.getProperty("db.primary.url"));
            primaryConfig.setUsername(PropertiesLoader.getProperty("db.primary.username"));
            primaryConfig.setPassword(PropertiesLoader.getProperty("db.primary.password"));
            primaryConfig.setMaximumPoolSize(PropertiesLoader.getIntProperty("db.primary.maximumPoolSize"));
            primaryConfig.setMinimumIdle(PropertiesLoader.getIntProperty("db.primary.minimumIdle"));

            try {
                // 创建主数据源实例
                primaryDataSource = new HikariDataSource(primaryConfig);
                if (debug) {
                    System.out.println("DBConnection: Primary HikariCP DataSource initialized");
                }
            } catch (Exception e) {
                if (debug) {
                    System.err.println("DBConnection Warning: Failed to initialize Primary HikariCP DataSource. Primary database will not be available.");
                }
            }

            // 初始化从数据源配置
            HikariConfig secondaryConfig = new HikariConfig();
            secondaryConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
            secondaryConfig.setJdbcUrl(PropertiesLoader.getProperty("db.secondary.url"));
            secondaryConfig.setUsername(PropertiesLoader.getProperty("db.secondary.username"));
            secondaryConfig.setPassword(PropertiesLoader.getProperty("db.secondary.password"));
            secondaryConfig.setMaximumPoolSize(PropertiesLoader.getIntProperty("db.secondary.maximumPoolSize"));
            secondaryConfig.setMinimumIdle(PropertiesLoader.getIntProperty("db.secondary.minimumIdle"));

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
            // 启动心跳检测任务
            startHeartbeatCheck();
        } catch (Exception e) {
            System.err.println("DBConnection Error: Failed to initialize HikariCP DataSource");
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize HikariCP DataSource", e);
        }
    }

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
            usePrimary = true;
            return primaryDataSource.getConnection();
        } else {
            throw new SQLException("No available DataSource is initialized.");
        }
    }

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
        scheduler.shutdown();
    }

    public static void clearEncryptionKeys() {
        CacheUtility.remove("public_key");
        CacheUtility.remove("private_key");
        if (debug) {
            System.out.println("DBConnection: Encryption keys cleared from cache");
        }
    }

    public DBConnection() {
        if (debug) {
            System.out.println("DBConnection: Initializing HikariCP DataSource...");
        }
    }

    /**
     * 启动心跳检测任务，定期检查主数据库的可用性
     */
    private static void startHeartbeatCheck() {
        Runnable heartbeatTask = () -> {
            if (!usePrimary && primaryDataSource != null) {
                try (Connection connection = primaryDataSource.getConnection()) {
                    if (connection != null && !connection.isClosed()) {
                        usePrimary = true;
                        if (debug) {
                            System.out.println("DBConnection: Primary DataSource is back online. Switching to Primary.");
                        }
                    }
                } catch (SQLException e) {
                    if (debug) {
                        System.err.println("DBConnection Heartbeat: Primary DataSource is still unavailable.");
                    }
                }
            }
        };

        // 每 30 秒检查一次主数据源的可用性
        scheduler.scheduleAtFixedRate(heartbeatTask, 30, 30, TimeUnit.SECONDS);
    }
}