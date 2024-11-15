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

        // 在应用程序关闭时清除密钥并关闭数据源
        DBConnection.clearEncryptionKeys(); // 确保将这个方法改为 public
        DBConnection.closeDataSource();
    }
}