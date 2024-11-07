package util;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.X509EncodedKeySpec;
import java.security.spec.PKCS8EncodedKeySpec;
import javax.crypto.Cipher;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;

public class AsymmetricEncryptionUtil {
    private static final String ALGORITHM = "RSA";

    // Generate an RSA key pair and save to the database
    public static void generateAndStoreKeyPair() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance(ALGORITHM);
            keyGen.initialize(2048);
            KeyPair keyPair = keyGen.generateKeyPair();

            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();

            // Store keys in the database
            conn = DBConnection.initializeDatabase();
            String deleteQuery = "DELETE FROM encryption_keys WHERE key_name IN (?, ?)";
            pstmt = conn.prepareStatement(deleteQuery);
            pstmt.setString(1, "public_key");
            pstmt.setString(2, "private_key");
            pstmt.executeUpdate();
            pstmt.close();

            storeKey(conn, "public_key", Base64.getEncoder().encodeToString(publicKey.getEncoded()));
            storeKey(conn, "private_key", Base64.getEncoder().encodeToString(privateKey.getEncoded()));
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // Store key in the database
    private static void storeKey(Connection conn, String keyName, String keyValue) throws Exception {
        String query = "INSERT INTO encryption_keys (key_name, key_value) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, keyName);
            pstmt.setString(2, keyValue);
            pstmt.executeUpdate();
        }
    }

    // Load a public key from the database
    public static PublicKey loadPublicKey() throws Exception {
        String keyValue = loadKey("public_key");
        if (keyValue == null) {
            throw new Exception("Public key not found in the database. Make sure keys are generated and stored properly.");
        }
        byte[] keyBytes = Base64.getDecoder().decode(keyValue);
        X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePublic(spec);
    }

    // Load a private key from the database
    public static PrivateKey loadPrivateKey() throws Exception {
        String keyValue = loadKey("private_key");
        if (keyValue == null) {
            throw new Exception("Private key not found in the database. Make sure keys are generated and stored properly.");
        }
        byte[] keyBytes = Base64.getDecoder().decode(keyValue);
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePrivate(spec);
    }

    // Load key from the database
    private static String loadKey(String keyName) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.initializeDatabase();
            String query = "SELECT key_value FROM encryption_keys WHERE key_name = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, keyName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getString("key_value");
            } else {
                return null;
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
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
}

