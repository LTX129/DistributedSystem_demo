package model;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;

import javax.imageio.ImageIO;

public class Product {
    private int id;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private String category; // 添加类别字段
    private InputStream image;
    String outputPath = "uploads/my_image.jpg";
    String webImgPath;


    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public InputStream getImage() { return image;}

    public void setImage(InputStream image) throws IOException {
        this.image = image;
        saveImageAsJPEG(image, id);
    }

    public void saveImageAsJPEG(InputStream inputStream, int productId) throws IOException {
        // 读取 InputStream 数据为 BufferedImage
        BufferedImage image = ImageIO.read(inputStream);

        if (image == null) {
            throw new IOException("无法读取图像数据。");
        }

        // 创建输出文件的路径
        String currentDir = System.getProperty("user.dir");
        System.out.println("当前工作目录: " + currentDir);
        File currentDirFile = new File(currentDir);
        File parentDirFile = currentDirFile.getParentFile();
        String parentDir = parentDirFile.getAbsolutePath();
        System.out.println("上级目录: " + parentDir);
        String outputPath = parentDir + "\\webapps\\demo_war\\img\\product_" + productId + ".jpeg";  // 使用产品 ID 生成文件名
        File outputFile = new File(outputPath);

        // 创建目录，如果不存在
        File parentDirAlt = outputFile.getParentFile();
        if (!parentDirAlt.exists()) {
            parentDirAlt.mkdirs();  // 创建父目录
        }

        // 将图像保存为 JPEG 格式
        ImageIO.write(image, "JPEG", outputFile);
        System.out.println("图像已成功保存为 JPEG 格式：" + outputPath);

    }

}
