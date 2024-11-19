package util;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

/**
 * Utility class for performing symmetric encryption and decryption using the AES algorithm.
 */
public class SymmetricEncryptionUtil {
    private static final String ALGORITHM = "AES";

    /**
     * Generates a new AES key.
     *
     * @return the generated AES secret key
     * @throws Exception if the key generation fails
     */
    public static SecretKey generateKey() throws Exception {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM);
        keyGenerator.init(128); // You can choose 128, 192, or 256 bits
        return keyGenerator.generateKey();
    }

    /**
     * Encrypts a plain text using the provided AES key.
     *
     * @param plainText the text to be encrypted
     * @param secretKey the AES key to be used for encryption
     * @return the encrypted text, encoded in Base64
     * @throws Exception if encryption fails
     */
    public static String encrypt(String plainText, SecretKey secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    /**
     * Decrypts a cipher text using the provided AES key.
     *
     * @param cipherText the text to be decrypted (Base64 encoded)
     * @param secretKey the AES key to be used for decryption
     * @return the decrypted text
     * @throws Exception if decryption fails
     */
    public static String decrypt(String cipherText, SecretKey secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decodedBytes = Base64.getDecoder().decode(cipherText);
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);
        return new String(decryptedBytes);
    }
}
