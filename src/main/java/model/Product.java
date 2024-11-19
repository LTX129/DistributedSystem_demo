package model;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;

import javax.imageio.ImageIO;

/**
 * Represents a product in the system, including details such as ID, name, description,
 * price, stock, category, and an associated image.
 */
public class Product {
    private int id;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private String category; // Adds category field
    private InputStream image;
    String outputPath = "uploads/my_image.jpg";
    String webImgPath;

    /**
     * Retrieves the product ID.
     *
     * @return The product's ID.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the product ID.
     *
     * @param id The product ID to set.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Retrieves the product name.
     *
     * @return The name of the product.
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the product name.
     *
     * @param name The name to set for the product.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Retrieves the product description.
     *
     * @return The description of the product.
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the product description.
     *
     * @param description The description to set for the product.
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Retrieves the product price.
     *
     * @return The price of the product.
     */
    public BigDecimal getPrice() {
        return price;
    }

    /**
     * Sets the product price.
     *
     * @param price The price to set for the product.
     */
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    /**
     * Retrieves the product's stock quantity.
     *
     * @return The stock quantity of the product.
     */
    public int getStock() {
        return stock;
    }

    /**
     * Sets the stock quantity for the product.
     *
     * @param stock The stock quantity to set for the product.
     */
    public void setStock(int stock) {
        this.stock = stock;
    }

    /**
     * Retrieves the product's category.
     *
     * @return The category of the product.
     */
    public String getCategory() {
        return category;
    }

    /**
     * Sets the product category.
     *
     * @param category The category to set for the product.
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * Retrieves the product's image as an InputStream.
     *
     * @return The InputStream of the product image.
     */
    public InputStream getImage() {
        return image;
    }

    /**
     * Sets the product image and saves it as a JPEG file.
     *
     * @param image The InputStream of the image to set for the product.
     * @throws IOException If an error occurs during image processing.
     */
    public void setImage(InputStream image) throws IOException {
        this.image = image;
        saveImageAsJPEG(image, id);
    }

    /**
     * Saves the provided image InputStream as a JPEG file on the server.
     *
     * @param inputStream The InputStream of the image to save.
     * @param productId The ID of the product associated with the image.
     * @throws IOException If an error occurs during the saving process.
     */
    public void saveImageAsJPEG(InputStream inputStream, int productId) throws IOException {
        // Read the InputStream data as BufferedImage
        BufferedImage image = ImageIO.read(inputStream);

        if (image == null) {
            throw new IOException("Unable to read image data.");
        }

        // Create the output file path
        String currentDir = System.getProperty("user.dir");
        System.out.println("Current working directory: " + currentDir);
        File currentDirFile = new File(currentDir);
        File parentDirFile = currentDirFile.getParentFile();
        String parentDir = parentDirFile.getAbsolutePath();
        System.out.println("Parent directory: " + parentDir);
        String outputPath = parentDir + "\\webapps\\demo_war\\img\\product_" + productId + ".jpeg";  // Use product ID for filename
        File outputFile = new File(outputPath);

        // Create directories if they do not exist
        File parentDirAlt = outputFile.getParentFile();
        if (!parentDirAlt.exists()) {
            parentDirAlt.mkdirs();  // Create parent directories
        }

        // Save the image as JPEG format
        ImageIO.write(image, "JPEG", outputFile);
        System.out.println("Image successfully saved as JPEG format: " + outputPath);
    }
}
