package model;

import java.math.BigDecimal;

/**
 * Represents an item in the shopping cart, including the product and its quantity.
 */
public class CartItem {
    private Product product;
    private int quantity;

    /**
     * Constructs a {@link CartItem} with a specified product and quantity.
     *
     * @param product  The product for this cart item.
     * @param quantity The quantity of the product in the cart.
     */
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    /**
     * Retrieves the product associated with this cart item.
     *
     * @return The {@link Product} for this cart item.
     */
    public Product getProduct() {
        return product;
    }

    /**
     * Sets the product for this cart item.
     *
     * @param product The product to set.
     */
    public void setProduct(Product product) {
        this.product = product;
    }

    /**
     * Retrieves the quantity of the product in this cart item.
     *
     * @return The quantity of the product.
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity of the product in this cart item.
     *
     * @param quantity The quantity to set.
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * Calculates the total price for this cart item by multiplying the product's price
     * by the quantity.
     *
     * @return The total price for this cart item.
     */
    public BigDecimal getTotalPrice() {
        return product.getPrice().multiply(new BigDecimal(quantity));
    }
}
