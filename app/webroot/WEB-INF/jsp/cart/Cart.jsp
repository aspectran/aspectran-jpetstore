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
<%@ include file="../common/IncludeTop.jsp"%>

<div id="BackLink">
	<a href="<aspectran:url value="/"/>">Return to Main Menu</a>
</div>

<div id="Catalog">

	<div id="Cart">

		<h3>Shopping Cart</h3>

		<form method="post" hx-post="<aspectran:url value="/cart/updateCartQuantities"/>" hx-target="#window">
			<table>
				<tr>
					<th><b>Item ID</b></th>
					<th><b>Product ID</b></th>
					<th><b>Description</b></th>
					<th><b>In Stock?</b></th>
					<th><b>Quantity</b></th>
					<th><b>List Price</b></th>
					<th><b>Total Cost</b></th>
					<th>&nbsp;</th>
				</tr>
				<c:if test="${cart.numberOfItems eq 0}">
					<tr>
						<td colspan="8">Your cart is empty.</td>
					</tr>
				</c:if>
				<c:forEach var="cartItem" items="${cart.cartItems}">
					<tr>
						<td>
							<a href="<aspectran:url value="/products/${cartItem.item.product.productId}/items/${cartItem.item.itemId}"/>">${cartItem.item.itemId}</a>
						</td>
						<td>${cartItem.item.product.productId}</td>
						<td align="left">
							${cartItem.item.attribute1} ${cartItem.item.attribute2}
							${cartItem.item.attribute3} ${cartItem.item.attribute4}
							${cartItem.item.attribute5} ${cartItem.item.product.name}
						</td>
						<td>${cartItem.inStock}</td>
						<td><input type="number" name="${cartItem.item.itemId}" size="3" maxlength="3" value="${cartItem.quantity}"/></td>
						<td><fmt:formatNumber value="${cartItem.item.listPrice}" pattern="$#,##0.00"/></td>
						<td><fmt:formatNumber value="${cartItem.total}" pattern="$#,##0.00"/></td>
						<td>
							<a class="button" hx-post="<aspectran:url value="/cart/removeItemFromCart?cartItem=${cartItem.item.itemId}"/>" hx-target="#window">Remove</a>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="4"></td>
					<td>
						<c:if test="${cart.numberOfItems gt 0}">
							<button class="button" type="submit">Update Cart</button>
						</c:if>
					</td>
					<td><strong>Sub Total:</strong></td>
					<td><strong><fmt:formatNumber value="${cart.subTotal}" pattern="$#,##0.00"/></strong></td>
					<td>
						<c:if test="${cart.numberOfItems gt 0}">
							<a class="button" hx-post="<aspectran:url value="/cart/removeAllItemsFromCart"/>" hx-target="#window">Remove All</a>
						</c:if>
					</td>
				</tr>
			</table>

		</form>

		<c:if test="${cart.numberOfItems gt 0}">
			<a href="<aspectran:url value="/order/newOrderForm"/>" class="button">Proceed to Checkout</a>
		</c:if>
	</div>

	<div id="MyList">
		<c:if test="${not empty user.account}">
			<c:if test="${!empty user.account.listOption}">
				<%@ include file="IncludeMyList.jsp"%>
			</c:if>
		</c:if>
	</div>

	<div id="Separator">&nbsp;</div>
</div>

<%@ include file="../common/IncludeBottom.jsp"%>
