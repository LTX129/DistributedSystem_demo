package util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * Utility class for managing database connections using HikariCP.
 * This class initializes the primary and secondary data sources and provides methods
 * to retrieve connections, close data sources, and clear encryption keys.
 */
public class DBConnection {

    private static HikariDataSource primaryDataSource;
    private static HikariDataSource secondaryDataSource;
    private static volatile boolean usePrimary = true;
    private static boolean debug = true;
    private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    static {
        try {
            // Initialize primary data source configuration
            HikariConfig primaryConfig = new HikariConfig();
            primaryConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
            primaryConfig.setJdbcUrl(PropertiesLoader.getProperty("db.primary.url"));
            primaryConfig.setUsername(PropertiesLoader.getProperty("db.primary.username"));
            primaryConfig.setPassword(PropertiesLoader.getProperty("db.primary.password"));
            primaryConfig.setMaximumPoolSize(PropertiesLoader.getIntProperty("db.primary.maximumPoolSize"));
            primaryConfig.setMinimumIdle(PropertiesLoader.getIntProperty("db.primary.minimumIdle"));

            try {
                // Create primary data source instance
                primaryDataSource = new HikariDataSource(primaryConfig);
                if (debug) {
                    System.out.println("DBConnection: Primary HikariCP DataSource initialized");
                }
            } catch (Exception e) {
                if (debug) {
                    System.err.println("DBConnection Warning: Failed to initialize Primary HikariCP DataSource. Primary database will not be available.");
                }
            }

            // Initialize secondary data source configuration
            HikariConfig secondaryConfig = new HikariConfig();
            secondaryConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
            secondaryConfig.setJdbcUrl(PropertiesLoader.getProperty("db.secondary.url"));
            secondaryConfig.setUsername(PropertiesLoader.getProperty("db.secondary.username"));
            secondaryConfig.setPassword(PropertiesLoader.getProperty("db.secondary.password"));
            secondaryConfig.setMaximumPoolSize(PropertiesLoader.getIntProperty("db.secondary.maximumPoolSize"));
            secondaryConfig.setMinimumIdle(PropertiesLoader.getIntProperty("db.secondary.minimumIdle"));

            try {
                // Attempt to create secondary data source instance
                secondaryDataSource = new HikariDataSource(secondaryConfig);
                if (debug) {
                    System.out.println("DBConnection: Secondary HikariCP DataSource initialized");
                }
            } catch (Exception e) {
                if (debug) {
                    System.err.println("DBConnection Warning: Failed to initialize Secondary HikariCP DataSource. Secondary database will not be available.");
                }
            }

            // Start heartbeat check task
            startHeartbeatCheck();
        } catch (Exception e) {
            System.err.println("DBConnection Error: Failed to initialize HikariCP DataSource");
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize HikariCP DataSource", e);
        }
    }

    /**
     * Initializes and returns a database connection.
     * If the primary data source is unavailable, it attempts to connect to the secondary data source.
     *
     * @return a {@link Connection} to the database
     * @throws SQLException if no available data source is initialized or if connection fails
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
            usePrimary = true;
            return primaryDataSource.getConnection();
        } else {
            throw new SQLException("No available DataSource is initialized.");
        }
    }

    /**
     * Closes both the primary and secondary data sources and shuts down the heartbeat check task.
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
        scheduler.shutdown();
    }

    /**
     * Clears the encryption keys from the cache.
     */
    public static void clearEncryptionKeys() {
        CacheUtility.remove("public_key");
        CacheUtility.remove("private_key");
        if (debug) {
            System.out.println("DBConnection: Encryption keys cleared from cache");
        }
    }

    /**
     * Constructor for the DBConnection class.
     * Initializes the HikariCP data sources if they are not already initialized.
     */
    public DBConnection() {
        if (debug) {
            System.out.println("DBConnection: Initializing HikariCP DataSource...");
        }
    }

    /**
     * Starts a heartbeat check task that periodically checks the availability of the primary database.
     * If the primary database becomes available, it switches back to using the primary data source.
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

        // Check the primary data source's availability every 30 seconds
        scheduler.scheduleAtFixedRate(heartbeatTask, 30, 30, TimeUnit.SECONDS);
    }
}
