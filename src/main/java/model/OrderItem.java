package model;

/**
 * Represents an item within an order, including the order item ID, associated order ID,
 * the product, and the quantity of the product.
 */
public class OrderItem {
    private int orderItemId;
    private int orderId;
    private Product product;
    private int quantity;

    /**
     * Retrieves the order item ID.
     *
     * @return The ID of the order item.
     */
    public int getOrderItemId() {
        return orderItemId;
    }

    /**
     * Sets the order item ID.
     *
     * @param orderItemId The ID to set for the order item.
     */
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    /**
     * Retrieves the order ID associated with the order item.
     *
     * @return The ID of the order that this item belongs to.
     */
    public int getOrderId() {
        return orderId;
    }

    /**
     * Sets the order ID for the order item.
     *
     * @param orderId The order ID to set for the order item.
     */
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    /**
     * Retrieves the product associated with the order item.
     *
     * @return The product for this order item.
     */
    public Product getProduct() {
        return product;
    }

    /**
     * Sets the product for the order item.
     *
     * @param product The product to set for the order item.
     */
    public void setProduct(Product product) {
        this.product = product;
    }

    /**
     * Retrieves the quantity of the product for this order item.
     *
     * @return The quantity of the product in the order item.
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity of the product for the order item.
     *
     * @param quantity The quantity to set for the product in the order item.
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
