/**
 * Copyright 2010-2018 the original author or authors.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package app.jpetstore.cart.domain;

import app.jpetstore.order.domain.Item;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * The Class Cart.
 *
 * @author Juho Jeong
 */
public class Cart implements Serializable {

    @Serial
    private static final long serialVersionUID = 8329559983943337176L;

    private final Map<String, CartItem> itemMap = new LinkedHashMap<>();

    public synchronized Iterator<CartItem> getCartItems() {
        return itemMap.values().iterator();
    }

    public synchronized List<CartItem> getCartItemList() {
        return new ArrayList<>(itemMap.values());
    }

    public synchronized int getNumberOfItems() {
        return itemMap.size();
    }

    public synchronized Iterator<CartItem> getAllCartItems() {
        return itemMap.values().iterator();
    }

    public synchronized boolean containsItemId(String itemId) {
        return (itemId != null && itemMap.containsKey(itemId));
    }

    /**
     * Adds an item to the cart.
     * @param item the item to be added to the cart; must not be null
     * @param isInStock a flag indicating whether the item is in stock
     */
    public synchronized void addItem(Item item, boolean isInStock) {
        if (item == null) {
            return;
        }
        CartItem cartItem = itemMap.get(item.getItemId());
        if (cartItem == null) {
            cartItem = new CartItem();
            cartItem.setItem(item);
            cartItem.setQuantity(0);
            cartItem.setInStock(isInStock);
            itemMap.put(item.getItemId(), cartItem);
        }
        cartItem.incrementQuantity();
    }

    /**
     * Removes the item by id.
     * @param itemId the item id
     * @return the item
     */
    public synchronized Item removeItemById(String itemId) {
        if (itemId == null) {
            return null;
        }
        CartItem cartItem = itemMap.remove(itemId);
        return (cartItem != null ? cartItem.getItem() : null);
    }

    /**
     * Increment quantity by item id.
     * @param itemId the item id
     */
    public synchronized void incrementQuantityByItemId(String itemId) {
        if (itemId == null) {
            return;
        }
        CartItem cartItem = itemMap.get(itemId);
        if (cartItem != null) {
            cartItem.incrementQuantity();
        }
    }

    public synchronized void setQuantityByItemId(String itemId, int quantity) {
        if (itemId == null) {
            return;
        }
        CartItem cartItem = itemMap.get(itemId);
        if (cartItem != null) {
            cartItem.setQuantity(quantity);
        }
    }

    /**
     * Gets the sub total.
     * @return the sub total
     */
    public synchronized BigDecimal getSubTotal() {
        return itemMap.values().stream()
                .map(cartItem -> cartItem.getItem().getListPrice().multiply(new BigDecimal(cartItem.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public synchronized void clear() {
        itemMap.clear();
    }

}
