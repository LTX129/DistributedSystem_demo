package model;

import java.math.BigDecimal;

public class CartItem {
    private Product product;
    private int quantity;

    // 构造器
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // 获取商品
    public Product getProduct() {
        return product;
    }

    // 设置商品
    public void setProduct(Product product) {
        this.product = product;
    }

    // 获取数量
    public int getQuantity() {
        return quantity;
    }

    // 设置数量
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // 计算单个商品的总价
    public BigDecimal getTotalPrice() {
        return product.getPrice().multiply(new BigDecimal(quantity));
    }
}
