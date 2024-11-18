package util;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import java.util.concurrent.TimeUnit;

public class CacheUtility {

    private static final Cache<String, Object> cache = Caffeine.newBuilder()
            .expireAfterWrite(PropertiesLoader.getIntProperty("cache.expireAfterWriteMinutes"), TimeUnit.MINUTES)
            .expireAfterAccess(PropertiesLoader.getIntProperty("cache.expireAfterAccessMinutes"), TimeUnit.MINUTES)
            .maximumSize(PropertiesLoader.getIntProperty("cache.maximumSize"))
            .recordStats()
            .build();

    public static Object get(String key) {
        return cache.getIfPresent(key);
    }

    public static void put(String key, Object value) {
        cache.put(key, value);
    }

    public static void remove(String key) {
        cache.invalidate(key);
    }

    public static void clearCache() {
        cache.invalidateAll();
        System.out.println("Cache cleared");
    }
}
