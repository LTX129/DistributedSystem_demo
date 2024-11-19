package model;

import java.util.Date;
import java.util.List;

/**
 * Represents an order placed by a user, including order details such as the order ID,
 * user ID, order date, shipping address, payment method, and the items included in the order.
 */
public class Order {
    private int orderId;
    private int userId;
    private Date orderDate;
    private String shippingAddress;
    private String paymentMethod;
    private List<OrderItem> items;

    /**
     * Retrieves the order ID.
     *
     * @return The ID of the order.
     */
    public int getOrderId() {
        return orderId;
    }

    /**
     * Sets the order ID.
     *
     * @param orderId The ID to set for the order.
     */
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    /**
     * Retrieves the user ID associated with the order.
     *
     * @return The ID of the user who placed the order.
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID for the order.
     *
     * @param userId The user ID to set for the order.
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Retrieves the date when the order was placed.
     *
     * @return The order date.
     */
    public Date getOrderDate() {
        return orderDate;
    }

    /**
     * Sets the date when the order was placed.
     *
     * @param orderDate The order date to set.
     */
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    /**
     * Retrieves the shipping address for the order.
     *
     * @return The shipping address for the order.
     */
    public String getShippingAddress() {
        return shippingAddress;
    }

    /**
     * Sets the shipping address for the order.
     *
     * @param shippingAddress The shipping address to set for the order.
     */
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    /**
     * Retrieves the payment method used for the order.
     *
     * @return The payment method for the order.
     */
    public String getPaymentMethod() {
        return paymentMethod;
    }

    /**
     * Sets the payment method for the order.
     *
     * @param paymentMethod The payment method to set for the order.
     */
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    /**
     * Retrieves the list of items included in the order.
     *
     * @return A list of {@link OrderItem} objects representing the items in the order.
     */
    public List<OrderItem> getItems() {
        return items;
    }

    /**
     * Sets the list of items included in the order.
     *
     * @param items A list of {@link OrderItem} objects to set for the order.
     */
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
