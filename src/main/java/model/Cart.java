package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;

    // 构造器
    public Cart() {
        items = new ArrayList<>();
    }

    // 添加商品到购物车
    public void addItem(CartItem item) {
        // 检查是否购物车已经存在该商品，若存在则更新数量
        for (CartItem cartItem : items) {
            if (cartItem.getProduct().getId() == item.getProduct().getId()) {
                cartItem.setQuantity(cartItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        // 如果购物车中没有该商品，添加新的购物车项
        items.add(item);
    }

    // 移除购物车中的商品
    public void removeItem(int productId) {
        items.removeIf(item -> item.getProduct().getId() == productId);
    }

    // 获取购物车所有商品
    public List<CartItem> getItems() {
        return items;
    }

}
