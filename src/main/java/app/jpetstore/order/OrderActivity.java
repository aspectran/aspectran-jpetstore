/**
 * Copyright 2010-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package app.jpetstore.order;

import app.jpetstore.account.domain.Account;
import app.jpetstore.cart.domain.Cart;
import app.jpetstore.common.user.UserSessionManager;
import app.jpetstore.common.validation.BeanValidator;
import app.jpetstore.order.domain.Order;
import app.jpetstore.order.service.OrderService;
import com.aspectran.core.activity.Translet;
import com.aspectran.core.component.bean.annotation.Action;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Dispatch;
import com.aspectran.core.component.bean.annotation.ParamItem;
import com.aspectran.core.component.bean.annotation.Redirect;
import com.aspectran.core.component.bean.annotation.Request;
import com.aspectran.core.component.bean.annotation.RequestToPost;
import com.aspectran.core.component.bean.annotation.Required;
import app.jpetstore.cart.service.CartService;

import java.util.List;

/**
 * The Class OrderActivity.
 *
 * @author Juho Jeong
 */
@Component
@Bean
public class OrderActivity {

    private final OrderService orderService;

    private final CartService cartService;

    private final UserSessionManager sessionManager;

    @Autowired
    public OrderActivity(OrderService orderService,
                         CartService cartService,
                         UserSessionManager sessionManager) {
        this.orderService = orderService;
        this.cartService = cartService;
        this.sessionManager = sessionManager;
    }

    /**
     * List orders.
     */
    @Request("/order/listOrders")
    @Dispatch("order/ListOrders")
    @Action("orderList")
    public List<Order> listOrders() {
        Account account = sessionManager.getUserSession().getAccount();
        return orderService.getOrdersByUsername(account.getUsername());
    }

    /**
     * New order form.
     */
    @Request("/order/newOrderForm")
    @Dispatch("order/NewOrderForm")
    @Action("order")
    public Order newOrderForm() {
        Account account = sessionManager.getUserSession().getAccount();
        Cart cart = cartService.getCart();
        if (cart != null && cart.getNumberOfItems() > 0) {
            Order order = new Order();
            order.initialize(account, cart);
            sessionManager.getUserSession().setOrder(order);
            return order;
        } else {
            return null;
        }
    }

    /**
     * New order.
     */
    @RequestToPost("/order/newOrder")
    public void newOrder(Translet translet,
                         Order order,
                         boolean paymentForm,
                         boolean billingForm,
                         boolean shippingForm,
                         boolean shippingAddressRequired,
                         boolean confirmed,
                         BeanValidator beanValidator
    ) {
        Order order2 = sessionManager.getUserSession().getOrder();
        if (order2 == null) {
            translet.redirect("/cart/viewCart");
            return;
        }
        order2.update(order);
        translet.setAttribute("order", order2);

        if (paymentForm) {
            beanValidator.validate(translet, order2, Order.Payment.class);
        }
        if (billingForm) {
            beanValidator.validate(translet, order2, Order.Billing.class);
        }
        if (shippingForm) {
            beanValidator.validate(translet, order2, Order.Shipping.class);
        }
        if (beanValidator.hasErrors()) {
            translet.setAttribute("errors", beanValidator.getErrors());
            if (shippingForm) {
                translet.dispatch("/order/ShippingForm");
            } else {
                translet.dispatch("/order/NewOrderForm");
            }
            return;
        }

        if (shippingAddressRequired) {
            translet.dispatch("order/ShippingForm");
        } else if (!confirmed) {
            translet.dispatch("order/ConfirmOrder");
        } else {
            sessionManager.getUserSession().clearOrder();
            translet.redirect("/cart/viewCart");
        }
    }

    /**
     * Submit order.
     */
    @RequestToPost("/order/submitOrder")
    @Redirect(
            path = "/order/viewOrder",
            parameters = {
                    @ParamItem(name = "orderId", value = "@{order^orderId}"),
                    @ParamItem(name = "submitted", value = "true")
            }
    )
    @Action("order")
    public Order submitOrder(Translet translet) {
        Order order = sessionManager.getUserSession().getOrder();
        if (order == null) {
            translet.redirect("/cart/viewCart");
            return null;
        }
        orderService.insertOrder(order);

        sessionManager.getUserSession().clearOrder();
        cartService.getCart().clear();

        return order;
    }

    /**
     * View order.
     */
    @Request("/order/viewOrder")
    @Dispatch("order/ViewOrder")
    @Action("order")
    public Order viewOrder(int orderId) {
        return orderService.getOrder(orderId);
    }

    /**
     * Delete order.
     */
    @Request("/order/deleteOrder/${orderId}")
    @Redirect("/order/listOrders")
    public void deleteOrder(@Required int orderId) {
        orderService.deleteOrder(orderId);
    }

}
