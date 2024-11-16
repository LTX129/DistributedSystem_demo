package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ApplicationLifecycleListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application started: Initializing resources...");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Application shutting down: Cleaning up resources...");

        // 清除缓存中的密钥
        CacheUtility.remove("public_key");
        CacheUtility.remove("private_key");
        System.out.println("ApplicationLifecycleListener: Encryption keys removed from cache");

        // 关闭数据源
        DBConnection.closeDataSource();
    }
}
