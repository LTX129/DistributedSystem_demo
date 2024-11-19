package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * A listener class that listens to the lifecycle events of the web application.
 * This class is responsible for initializing resources when the application starts
 * and cleaning up resources when the application shuts down.
 */
@WebListener
public class ApplicationLifecycleListener implements ServletContextListener {

    /**
     * Called when the web application is initialized.
     * This method is executed during the startup of the application.
     *
     * @param sce The ServletContextEvent containing the servlet context.
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application started: Initializing resources...");
    }

    /**
     * Called when the web application is about to shut down.
     * This method is executed during the shutdown of the application.
     *
     * @param sce The ServletContextEvent containing the servlet context.
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Application shutting down: Cleaning up resources...");

        // Clear encryption keys from the cache
        CacheUtility.remove("public_key");
        CacheUtility.remove("private_key");
        System.out.println("ApplicationLifecycleListener: Encryption keys removed from cache");

        // Close data source
        DBConnection.closeDataSource();
    }
}
