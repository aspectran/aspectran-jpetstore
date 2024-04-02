<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://aspectran.com/tags" prefix="aspectran" %>
<%--

       Copyright 2010-2016 the original author or authors.

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.

--%>
<%@ include file="../common/IncludeTop.jsp" %>

<c:if test="${param.submitted eq 'true'}">
    <div id="MessageBar">
        <p>Thank you, your order has been submitted.</p>
    </div>
</c:if>

<div id="BackLink">
    <a href="<aspectran:url value="/"/>">Return to Main Menu</a>
</div>

<div id="CenterForm">

    <h3>Order</h3>
    <table>
        <colgroup>
            <col style="width: 25%"/>
            <col/>
        </colgroup>
        <tr>
            <td>Order No.</td>
            <td>#${order.orderId}</td>
        </tr>
        <tr>
            <td>Order Date</td>
            <td>
                <fmt:formatDate value="${order.orderDate}" pattern="yyyy/MM/dd hh:mm:ss"/>
            </td>
        </tr>
    </table>

    <h3>Payment Details</h3>
    <table>
        <colgroup>
            <col style="width: 25%"/>
            <col/>
        </colgroup>
        <tr>
            <td>Card Type:</td>
            <td><c:out value="${order.cardType}"/></td>
        </tr>
        <tr>
            <td>Card Number:</td>
            <td>
                <c:out value="${order.creditCard}"/>
                * Fake number!
            </td>
        </tr>
        <tr>
            <td>Expiry Date (MM/YYYY):</td>
            <td><c:out value="${order.expiryDate}"/></td>
        </tr>
    </table>

    <h3>Billing Address</h3>
    <table>
        <colgroup>
            <col style="width: 25%"/>
            <col/>
        </colgroup>
        <tr>
            <td>First name:</td>
            <td><c:out value="${order.billToFirstName}"/></td>
        </tr>
        <tr>
            <td>Last name:</td>
            <td><c:out value="${order.billToLastName}"/></td>
        </tr>
        <tr>
            <td>Address 1:</td>
            <td><c:out value="${order.billAddress1}"/></td>
        </tr>
        <tr>
            <td>Address 2:</td>
            <td><c:out value="${order.billAddress2}"/></td>
        </tr>
        <tr>
            <td>City:</td>
            <td><c:out value="${order.billCity}"/></td>
        </tr>
        <tr>
            <td>State:</td>
            <td><c:out value="${order.billState}"/></td>
        </tr>
        <tr>
            <td>Zip:</td>
            <td><c:out value="${order.billZip}"/></td>
        </tr>
        <tr>
            <td>Country:</td>
            <td><c:out value="${order.billCountry}"/></td>
        </tr>
    </table>

    <h3>Shipping Address</h3>
    <table>
        <colgroup>
            <col style="width: 25%"/>
            <col/>
        </colgroup>
        <tr>
            <td>First name:</td>
            <td><c:out value="${order.shipToFirstName}"/></td>
        </tr>
        <tr>
            <td>Last name:</td>
            <td><c:out value="${order.shipToLastName}"/></td>
        </tr>
        <tr>
            <td>Address 1:</td>
            <td><c:out value="${order.shipAddress1}"/></td>
        </tr>
        <tr>
            <td>Address 2:</td>
            <td><c:out value="${order.shipAddress2}"/></td>
        </tr>
        <tr>
            <td>City:</td>
            <td><c:out value="${order.shipCity}"/></td>
        </tr>
        <tr>
            <td>State:</td>
            <td><c:out value="${order.shipState}"/></td>
        </tr>
        <tr>
            <td>Zip:</td>
            <td><c:out value="${order.shipZip}"/></td>
        </tr>
        <tr>
            <td>Country:</td>
            <td><c:out value="${order.shipCountry}"/></td>
        </tr>
        <tr>
            <td>Courier:</td>
            <td><c:out value="${order.courier}"/></td>
        </tr>
        <tr>
            <td>Status:</td>
            <td><c:out value="${order.status}"/></td>
        </tr>
    </table>

    <table>
        <tr>
            <th>Item ID</th>
            <th>Description</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total Cost</th>
        </tr>
        <c:forEach var="lineItem" items="${order.lineItems}">
            <tr>
                <td align="center">
                    <a href="<aspectran:url value="/products/${lineItem.item.product.productId}/items/${lineItem.item.itemId}"/>">${lineItem.item.itemId}</a>
                </td>
                <td>
                    <c:if test="${not empty lineItem.item}">
                        ${lineItem.item.attribute1}
                        ${lineItem.item.attribute2}
                        ${lineItem.item.attribute3}
                        ${lineItem.item.attribute4}
                        ${lineItem.item.attribute5}
                        ${lineItem.item.product.name}
                    </c:if>
                    <c:if test="${empty lineItem.item}">
                        <i>{description unavailable}</i>
                    </c:if>
                </td>
                <td align="center">${lineItem.quantity}</td>
                <td align="center"><fmt:formatNumber value="${lineItem.unitPrice}" pattern="$#,##0.00"/></td>
                <td align="center"><fmt:formatNumber value="${lineItem.total}" pattern="$#,##0.00"/></td>
            </tr>
        </c:forEach>
        <tr>
            <th colspan="3"></th>
            <th>Total</th>
            <th>
                <fmt:formatNumber value="${order.totalPrice}" pattern="$#,##0.00"/>
            </th>
        </tr>
    </table>

    <div class="button-bar">
        <button type="button" class="button"
                onclick="location.href='<aspectran:url value="/order/deleteOrder/${order.orderId}"/>';">Delete Order
        </button>
    </div>

</div>

<%@ include file="../common/IncludeBottom.jsp" %>
