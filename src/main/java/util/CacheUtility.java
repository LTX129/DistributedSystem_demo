package util;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import java.util.concurrent.TimeUnit;

public class CacheUtility {

    private static final Cache<String, Object> cache = Caffeine.newBuilder()
            .expireAfterWrite(10, TimeUnit.MINUTES) // 缓存过期时间设置为 10 分钟
            .maximumSize(1000) // 最大缓存条目数
            .build();

    /**
     * 获取缓存对象
     *
     * @param key 缓存键
     * @return 缓存对象
     */
    public static Object get(String key) {
        return cache.getIfPresent(key);
    }

    /**
     * 设置缓存对象
     *
     * @param key 缓存键
     * @param value 缓存值
     */
    public static void put(String key, Object value) {
        cache.put(key, value);
    }

    /**
     * 移除缓存对象
     *
     * @param key 缓存键
     */
    public static void remove(String key) {
        cache.invalidate(key);
    }
}
