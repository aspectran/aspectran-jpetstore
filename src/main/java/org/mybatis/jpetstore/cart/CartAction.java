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
package org.mybatis.jpetstore.cart;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.component.bean.annotation.Action;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Dispatch;
import com.aspectran.core.component.bean.annotation.Redirect;
import com.aspectran.core.component.bean.annotation.Request;
import com.aspectran.core.component.bean.annotation.Required;
import org.mybatis.jpetstore.cart.domain.Cart;
import org.mybatis.jpetstore.cart.domain.CartItem;
import org.mybatis.jpetstore.cart.service.CartService;

import java.util.Iterator;

/**
 * The Class CartAction.
 *
 * @author Eduardo Macarron
 */
@Component
@Bean("cartAction")
public class CartAction {

    /**
     * Adds the item to cart.
     */
    @Request("/cart/addItemToCart")
    @Redirect("/cart/viewCart")
    @Action("cart")
    public Cart addItemToCart(Translet translet, @Required String itemId) {
        CartService cartService = translet.getBean("cartService");
        cartService.addItemToCart(itemId);
        return cartService.getCart();
    }

    /**
     * Removes the item from cart.
     */
    @Request("/cart/removeItemFromCart")
    @Redirect("/cart/viewCart")
    @Action("cart")
    public Cart removeItemFromCart(Translet translet, @Required String cartItem) {
        CartService cartService = translet.getBean("cartService");
        cartService.removeItemFromCart(cartItem);
        return cartService.getCart();
    }

    /**
     * Update cart quantities.
     */
    @Request("/cart/updateCartQuantities")
    @Redirect("/cart/viewCart")
    @Action("cart")
    public Cart updateCartQuantities(Translet translet) {
        CartService cartService = translet.getBean("cartService");
        Iterator<CartItem> cartItems = cartService.getAllCartItems();
        while (cartItems.hasNext()) {
            CartItem cartItem = cartItems.next();
            String itemId = cartItem.getItem().getItemId();
            try {
                int quantity = Integer.parseInt(translet.getParameter(itemId));
                cartService.setQuantityByItemId(itemId, quantity);
                if (quantity < 1) {
                    cartItems.remove();
                }
            } catch (Exception e) {
                // ignore parse exceptions on purpose
            }
        }
        return cartService.getCart();
    }

    @Request("/cart/viewCart")
    @Dispatch("cart/Cart")
    @Action("cart")
    public Cart viewCart(Translet translet) {
        CartService cartService = translet.getBean("cartService");
        return cartService.getCart();
    }

    @Request("/cart/checkOut")
    @Dispatch("cart/Checkout")
    public Cart checkOut(Translet translet) {
        return viewCart(translet);
    }

}