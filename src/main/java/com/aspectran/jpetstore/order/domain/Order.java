/*
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
package com.aspectran.jpetstore.order.domain;

import com.aspectran.jpetstore.account.domain.Account;
import com.aspectran.jpetstore.cart.domain.Cart;
import com.aspectran.jpetstore.cart.domain.CartItem;
import com.aspectran.jpetstore.common.validation.NumericCharacters;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * The Class Order.
 *
 * @author Juho Jeong
 */
public class Order implements Serializable {

    @Serial
    private static final long serialVersionUID = 6321792448424424931L;

    private int orderId;
    private String username;
    private Date orderDate;

    @NotBlank(groups = Payment.class)
    @Size(max = 40, groups = Payment.class)
    private String cardType;

    @NotBlank(groups = Payment.class)
    @Size(max = 80, groups = Payment.class)
    @NumericCharacters(groups = Payment.class)
    private String creditCard;

    @NotBlank(groups = Payment.class)
    @Pattern(regexp = "^\\d{2}/\\d{4}$", groups = Payment.class)
    private String expiryDate;

    @NotBlank(groups = Billing.class)
    @Size(max = 40, groups = Billing.class)
    private String billToFirstName;

    @NotBlank(groups = Billing.class)
    @Size(max = 40, groups = Billing.class)
    private String billToLastName;

    @NotBlank(groups = Billing.class)
    @Size(max = 40, groups = Billing.class)
    private String billAddress1;

    @NotBlank(groups = Billing.class)
    @Size(max = 40, groups = Billing.class)
    private String billAddress2;

    @NotBlank(groups = Billing.class)
    @Size(max = 40, groups = Billing.class)
    private String billCity;

    @NotBlank(groups = Billing.class)
    @Size(max = 40, groups = Billing.class)
    private String billState;

    @NotBlank(groups = Billing.class)
    @Size(max = 20, groups = Billing.class)
    @NumericCharacters(groups = Billing.class)
    private String billZip;

    @NotBlank(groups = Billing.class)
    @Size(max = 20, groups = Billing.class)
    private String billCountry;

    @NotBlank(groups = Shipping.class)
    @Size(max = 40, groups = Shipping.class)
    private String shipToFirstName;

    @NotBlank(groups = Shipping.class)
    @Size(max = 40, groups = Shipping.class)
    private String shipToLastName;

    @NotBlank(groups = Shipping.class)
    @Size(max = 40, groups = Shipping.class)
    private String shipAddress1;

    @NotBlank(groups = Shipping.class)
    @Size(max = 40, groups = Shipping.class)
    private String shipAddress2;

    @NotBlank(groups = Shipping.class)
    @Size(max = 40, groups = Shipping.class)
    private String shipCity;

    @NotBlank(groups = Shipping.class)
    @Size(max = 40, groups = Shipping.class)
    private String shipState;

    @NotBlank(groups = Shipping.class)
    @Size(max = 20, groups = Shipping.class)
    @NumericCharacters(groups = Shipping.class)
    private String shipZip;

    @NotBlank(groups = Shipping.class)
    @Size(max = 20, groups = Shipping.class)
    private String shipCountry;

    private String courier;

    private BigDecimal totalPrice;

    private boolean shippingAddressRequired;

    private String locale;

    private String status;

    private List<LineItem> lineItems = new ArrayList<>();

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getShipAddress1() {
        return shipAddress1;
    }

    public void setShipAddress1(String shipAddress1) {
        this.shipAddress1 = shipAddress1;
    }

    public String getShipAddress2() {
        return shipAddress2;
    }

    public void setShipAddress2(String shipAddress2) {
        this.shipAddress2 = shipAddress2;
    }

    public String getShipCity() {
        return shipCity;
    }

    public void setShipCity(String shipCity) {
        this.shipCity = shipCity;
    }

    public String getShipState() {
        return shipState;
    }

    public void setShipState(String shipState) {
        this.shipState = shipState;
    }

    public String getShipZip() {
        return shipZip;
    }

    public void setShipZip(String shipZip) {
        this.shipZip = shipZip;
    }

    public String getShipCountry() {
        return shipCountry;
    }

    public void setShipCountry(String shipCountry) {
        this.shipCountry = shipCountry;
    }

    public String getBillAddress1() {
        return billAddress1;
    }

    public void setBillAddress1(String billAddress1) {
        this.billAddress1 = billAddress1;
    }

    public String getBillAddress2() {
        return billAddress2;
    }

    public void setBillAddress2(String billAddress2) {
        this.billAddress2 = billAddress2;
    }

    public String getBillCity() {
        return billCity;
    }

    public void setBillCity(String billCity) {
        this.billCity = billCity;
    }

    public String getBillState() {
        return billState;
    }

    public void setBillState(String billState) {
        this.billState = billState;
    }

    public String getBillZip() {
        return billZip;
    }

    public void setBillZip(String billZip) {
        this.billZip = billZip;
    }

    public String getBillCountry() {
        return billCountry;
    }

    public void setBillCountry(String billCountry) {
        this.billCountry = billCountry;
    }

    public String getCourier() {
        return courier;
    }

    public void setCourier(String courier) {
        this.courier = courier;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getBillToFirstName() {
        return billToFirstName;
    }

    public void setBillToFirstName(String billToFirstName) {
        this.billToFirstName = billToFirstName;
    }

    public String getBillToLastName() {
        return billToLastName;
    }

    public void setBillToLastName(String billToLastName) {
        this.billToLastName = billToLastName;
    }

    public String getShipToFirstName() {
        return shipToFirstName;
    }

    public void setShipToFirstName(String shipFoFirstName) {
        this.shipToFirstName = shipFoFirstName;
    }

    public String getShipToLastName() {
        return shipToLastName;
    }

    public void setShipToLastName(String shipToLastName) {
        this.shipToLastName = shipToLastName;
    }

    public String getCreditCard() {
        return creditCard;
    }

    public void setCreditCard(String creditCard) {
        this.creditCard = creditCard;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public boolean isShippingAddressRequired() {
        return shippingAddressRequired;
    }

    public void setShippingAddressRequired(boolean shippingAddressRequired) {
        this.shippingAddressRequired = shippingAddressRequired;
    }

    public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setLineItems(List<LineItem> lineItems) {
        this.lineItems = lineItems;
    }

    public List<LineItem> getLineItems() {
        return lineItems;
    }

    /**
     * Inits the order.
     *
     * @param account the account
     * @param cart the cart
     */
    public void initialize(Account account, Cart cart) {

        username = account.getUsername();
        orderDate = new Date();

        shipToFirstName = account.getFirstName();
        shipToLastName = account.getLastName();
        shipAddress1 = account.getAddress1();
        shipAddress2 = account.getAddress2();
        shipCity = account.getCity();
        shipState = account.getState();
        shipZip = account.getZip();
        shipCountry = account.getCountry();

        billToFirstName = account.getFirstName();
        billToLastName = account.getLastName();
        billAddress1 = account.getAddress1();
        billAddress2 = account.getAddress2();
        billCity = account.getCity();
        billState = account.getState();
        billZip = account.getZip();
        billCountry = account.getCountry();

        totalPrice = cart.getSubTotal();

        creditCard = "999999999999999";
        expiryDate = "12/2019";
        cardType = "Visa";
        courier = "UPS";
        locale = "CA";
        status = "P";

        lineItems.clear();
        Iterator<CartItem> i = cart.getAllCartItems();
        while (i.hasNext()) {
            CartItem cartItem = i.next();
            addLineItem(cartItem);
        }

    }

    public void addLineItem(CartItem cartItem) {
        LineItem lineItem = new LineItem(lineItems.size() + 1, cartItem);
        addLineItem(lineItem);
    }

    public void addLineItem(LineItem lineItem) {
        lineItems.add(lineItem);
    }

    public void update(Order order) {
        if (order.getShipAddress1() != null) {
            setShipAddress1(order.getShipAddress1());
        }
        if (order.getShipAddress2() != null) {
            setShipAddress2(order.getShipAddress2());
        }
        if (order.getShipCity() != null) {
            setShipCity(order.getShipCity());
        }
        if (order.getShipState() != null) {
            setShipState(order.getShipState());
        }
        if (order.getShipZip() != null) {
            setShipZip(order.getShipZip());
        }
        if (order.getShipCountry() != null) {
            setShipCountry(order.getShipCountry());
        }
        if (order.getBillAddress1() != null) {
            setBillAddress1(order.getBillAddress1());
        }
        if (order.getBillAddress2() != null) {
            setBillAddress2(order.getBillAddress2());
        }
        if (order.getBillCity() != null) {
            setBillCity(order.getBillCity());
        }
        if (order.getBillState() != null) {
            setBillState(order.getBillState());
        }
        if (order.getBillZip() != null) {
            setBillZip(order.getBillZip());
        }
        if (order.getBillCountry() != null) {
            setBillCountry(order.getBillCountry());
        }
        if (order.getBillToFirstName() != null) {
            setBillToFirstName(order.getBillToFirstName());
        }
        if (order.getBillToLastName() != null) {
            setBillToLastName(order.getBillToLastName());
        }
        if (order.getShipToFirstName() != null) {
            setShipToFirstName(order.getShipToFirstName());
        }
        if (order.getShipToLastName() != null) {
            setShipToLastName(order.getShipToLastName());
        }
    }

    public interface Payment {
    }

    public interface Billing {
    }

    public interface Shipping {
    }

}
