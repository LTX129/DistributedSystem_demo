package util;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import java.util.concurrent.TimeUnit;

/**
 * Utility class for managing a cache using Caffeine.
 * This class provides methods for interacting with the cache, including
 * retrieving, putting, removing items, and clearing the cache.
 */
public class CacheUtility {

    // Cache instance with expiration and size limit configurations
    private static final Cache<String, Object> cache = Caffeine.newBuilder()
            .expireAfterWrite(PropertiesLoader.getIntProperty("cache.expireAfterWriteMinutes"), TimeUnit.MINUTES)
            .expireAfterAccess(PropertiesLoader.getIntProperty("cache.expireAfterAccessMinutes"), TimeUnit.MINUTES)
            .maximumSize(PropertiesLoader.getIntProperty("cache.maximumSize"))
            .recordStats()
            .build();

    /**
     * Retrieves the value associated with the specified key from the cache.
     *
     * @param key The key whose associated value is to be returned.
     * @return The value associated with the key, or null if the key is not present in the cache.
     */
    public static Object get(String key) {
        return cache.getIfPresent(key);
    }

    /**
     * Puts the specified value into the cache with the associated key.
     *
     * @param key The key with which the value is to be associated.
     * @param value The value to be cached.
     */
    public static void put(String key, Object value) {
        cache.put(key, value);
    }

    /**
     * Removes the specified key and its associated value from the cache.
     *
     * @param key The key to be removed from the cache.
     */
    public static void remove(String key) {
        cache.invalidate(key);
    }

    /**
     * Clears all entries from the cache.
     */
    public static void clearCache() {
        cache.invalidateAll();
        System.out.println("Cache cleared");
    }
}
