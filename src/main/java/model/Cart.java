package model;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents a shopping cart that contains a list of {@link CartItem}s.
 */
public class Cart {
    private List<CartItem> items;

    /**
     * Constructs a new empty shopping cart.
     */
    public Cart() {
        items = new ArrayList<>();
    }

    /**
     * Adds a {@link CartItem} to the shopping cart. If the product is already in the cart,
     * the quantity is updated.
     *
     * @param item The {@link CartItem} to be added to the cart.
     */
    public void addItem(CartItem item) {
        // Checks if the cart already contains the item, if so updates the quantity
        for (CartItem cartItem : items) {
            if (cartItem.getProduct().getId() == item.getProduct().getId()) {
                cartItem.setQuantity(cartItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        // If the cart does not contain the item, adds a new cart item
        items.add(item);
    }

    /**
     * Removes an item from the cart based on its product ID.
     *
     * @param productId The ID of the product to be removed.
     */
    public void removeItem(int productId) {
        items.removeIf(item -> item.getProduct().getId() == productId);
    }

    /**
     * Retrieves the list of items in the shopping cart.
     *
     * @return A list of {@link CartItem}s in the cart.
     */
    public List<CartItem> getItems() {
        return items;
    }
}
