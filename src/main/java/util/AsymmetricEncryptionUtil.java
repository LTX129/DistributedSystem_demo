package util;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.X509EncodedKeySpec;
import java.security.spec.PKCS8EncodedKeySpec;
import javax.crypto.Cipher;
import java.util.Base64;

/**
 * Utility class for performing asymmetric encryption (RSA) operations.
 * This class provides methods for generating RSA key pairs, encrypting and decrypting data,
 * and loading keys from a cache.
 */
public class AsymmetricEncryptionUtil {
    private static final String ALGORITHM = "RSA";

    // Ensure keys are available (generate if not already cached)
    static {
        try {
            generateAndStoreKeyPair();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to generate RSA key pair", e);
        }
    }

    /**
     * Generates an RSA key pair and stores it in the cache if not already available.
     * If keys are already present in the cache, they are reused.
     *
     * @throws Exception If an error occurs during key generation or storage.
     */
    public static void generateAndStoreKeyPair() throws Exception {
        KeyPair keyPair = getKeyPairFromCache();

        if (keyPair == null) {
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance(ALGORITHM);
            keyGen.initialize(2048);
            keyPair = keyGen.generateKeyPair();

            // Store keys in the cache
            CacheUtility.put("public_key", keyPair.getPublic());
            CacheUtility.put("private_key", keyPair.getPrivate());

            System.out.println("AsymmetricEncryptionUtil: New key pair generated and stored in cache");
        } else {
            System.out.println("AsymmetricEncryptionUtil: Using existing key pair from cache");
        }
    }

    /**
     * Loads the public key from the cache.
     * If the public key is not found, a new key pair is generated and stored in the cache.
     *
     * @return The public key.
     * @throws Exception If an error occurs while loading or generating the key.
     */
    public static PublicKey loadPublicKey() throws Exception {
        PublicKey publicKey = (PublicKey) CacheUtility.get("public_key");
        if (publicKey == null) {
            // Generate key pair if not found in cache
            generateAndStoreKeyPair();
            publicKey = (PublicKey) CacheUtility.get("public_key");
        }
        return publicKey;
    }

    /**
     * Loads the private key from the cache.
     * If the private key is not found, a new key pair is generated and stored in the cache.
     *
     * @return The private key.
     * @throws Exception If an error occurs while loading or generating the key.
     */
    public static PrivateKey loadPrivateKey() throws Exception {
        PrivateKey privateKey = (PrivateKey) CacheUtility.get("private_key");
        if (privateKey == null) {
            // Generate key pair if not found in cache
            generateAndStoreKeyPair();
            privateKey = (PrivateKey) CacheUtility.get("private_key");
        }
        return privateKey;
    }

    /**
     * Encrypts the given plain text using the specified public key.
     *
     * @param plainText The plain text to encrypt.
     * @param publicKey The public key to use for encryption.
     * @return The encrypted text, encoded as a Base64 string.
     * @throws Exception If an error occurs during encryption.
     */
    public static String encrypt(String plainText, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    /**
     * Decrypts the given cipher text using the specified private key.
     *
     * @param cipherText The cipher text to decrypt, encoded as a Base64 string.
     * @param privateKey The private key to use for decryption.
     * @return The decrypted plain text.
     * @throws Exception If an error occurs during decryption.
     */
    public static String decrypt(String cipherText, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decodedBytes = Base64.getDecoder().decode(cipherText);
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);
        return new String(decryptedBytes);
    }

    /**
     * Helper method to retrieve the key pair from the cache.
     *
     * @return The RSA key pair, or null if not found in the cache.
     */
    private static KeyPair getKeyPairFromCache() {
        PublicKey publicKey = (PublicKey) CacheUtility.get("public_key");
        PrivateKey privateKey = (PrivateKey) CacheUtility.get("private_key");

        if (publicKey != null && privateKey != null) {
            return new KeyPair(publicKey, privateKey);
        }
        return null;
    }

    /**
     * Retrieves the public key as a Base64-encoded string.
     *
     * @return The Base64-encoded public key.
     * @throws Exception If an error occurs while loading or encoding the public key.
     */
    public static String getPublicKey() throws Exception {
        PublicKey publicKey = loadPublicKey();
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }
}
