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

    // Generate an RSA key pair and store in the cache if not already available
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

    // Load a public key from the cache
    public static PublicKey loadPublicKey() throws Exception {
        PublicKey publicKey = (PublicKey) CacheUtility.get("public_key");
        if (publicKey == null) {
            // Generate key pair if not found in cache
            generateAndStoreKeyPair();
            publicKey = (PublicKey) CacheUtility.get("public_key");
        }
        return publicKey;
    }

    // Load a private key from the cache
    public static PrivateKey loadPrivateKey() throws Exception {
        PrivateKey privateKey = (PrivateKey) CacheUtility.get("private_key");
        if (privateKey == null) {
            // Generate key pair if not found in cache
            generateAndStoreKeyPair();
            privateKey = (PrivateKey) CacheUtility.get("private_key");
        }
        return privateKey;
    }

    // Encrypt data using the public key
    public static String encrypt(String plainText, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    // Decrypt data using the private key
    public static String decrypt(String cipherText, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decodedBytes = Base64.getDecoder().decode(cipherText);
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);
        return new String(decryptedBytes);
    }

    // Helper method to get the key pair from cache
    private static KeyPair getKeyPairFromCache() {
        PublicKey publicKey = (PublicKey) CacheUtility.get("public_key");
        PrivateKey privateKey = (PrivateKey) CacheUtility.get("private_key");

        if (publicKey != null && privateKey != null) {
            return new KeyPair(publicKey, privateKey);
        }
        return null;
    }

    // 获取字符串公钥用于提供给客户端
    public static String getPublicKey() throws Exception {
        PublicKey publicKey = loadPublicKey();
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }
}