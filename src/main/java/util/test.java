package util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class test {
    public static void main(String[] args) throws IOException, SQLException {
        //获取配置文件
        Properties properties = new Properties();
        properties.load(new FileInputStream("src\\main\\database.properties"));
        //将获取到的配置文件进行初始化配置
        HikariConfig config = new HikariConfig(properties);
        //创建HikariDataSource数据源
        HikariDataSource dataSource = new HikariDataSource(config);
        //从数据源获取连接
        Connection conn = dataSource.getConnection();
        //判断是否成功获取到连接
        if (conn !=null){
            System.out.println("连接成功");
        }else {
            System.out.println("连接失败");
        }
        //释放连接到连接池
        conn.close();
        dataSource.close();
    }
}
