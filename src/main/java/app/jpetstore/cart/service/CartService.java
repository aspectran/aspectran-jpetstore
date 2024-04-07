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
package app.jpetstore.cart.service;

import app.jpetstore.cart.domain.Cart;
import app.jpetstore.cart.domain.CartItem;
import app.jpetstore.catalog.service.CatalogService;
import app.jpetstore.order.domain.Item;
import app.jpetstore.user.UserSessionManager;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;

import java.util.Iterator;

/**
 * The Class CartService.
 *
 * @author Juho Jeong
 */
@Component
@Bean("cartService")
public class CartService {

    private final CatalogService catalogService;

    private final UserSessionManager sessionManager;

    @Autowired
    public CartService(CatalogService catalogService, UserSessionManager sessionManager) {
        this.catalogService = catalogService;
        this.sessionManager = sessionManager;
    }

    public Cart getCart() {
        return sessionManager.getUserSession().getCart();
    }

    public void addItemToCart(String itemId) {
        if (getCart().containsItemId(itemId)) {
            getCart().incrementQuantityByItemId(itemId);
        } else {
            // isInStock is a "real-time" property that must be updated
            // every time an item is added to the cart, even if other
            // item details are cached.
            boolean isInStock = catalogService.isItemInStock(itemId);
            Item item = catalogService.getItem(itemId);
            getCart().addItem(item, isInStock);
        }
    }

    public void removeItemFromCart(String itemId) {
        getCart().removeItemById(itemId);
    }

    public void removeAllItemsFormCart() {
        getCart().clear();
    }

    public Iterator<CartItem> getAllCartItems() {
        return getCart().getAllCartItems();
    }

    public void setQuantityByItemId(String itemId, int quantity) {
        getCart().setQuantityByItemId(itemId, quantity);
    }

}
