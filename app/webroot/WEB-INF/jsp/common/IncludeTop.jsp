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
<div id="Header">

	<div id="Logo">
		<div id="LogoContent">
			<a href="<aspectran:url value="/"/>"><img src="<aspectran:url value="/images/logo-topbar.gif"/>"/></a>
		</div>
	</div>

	<div id="Menu">
		<div id="MenuContent">
			<a href="<aspectran:url value="/cart/viewCart"/>">
				<img align="middle" name="img_cart" src="<aspectran:url value="/images/cart.gif"/>"/>
				${user.cart.numberOfItems}</a>
			<c:if test="${not user.authenticated}">
				<img align="middle" src="<aspectran:url value="/images/separator.gif"/>"/>
				<a href="<aspectran:url value="/account/signonForm"/>">Sign In</a>
				<img align="middle" src="<aspectran:url value="/images/separator.gif"/>"/>
				<a href="<aspectran:url value="/account/newAccountForm"/>">Sign Up</a>
			</c:if>
			<c:if test="${user.authenticated}">
				<img align="middle" src="<aspectran:url value="/images/separator.gif"/>"/>
				<a href="<aspectran:url value="/order/listOrders"/>">My Orders</a>
				<img align="middle" src="<aspectran:url value="/images/separator.gif"/>"/>
				<a href="<aspectran:url value="/account/editAccountForm"/>">My Account</a>
				<img align="middle" src="<aspectran:url value="/images/separator.gif"/>"/>
				<a href="<aspectran:url value="/account/signoff"/>">Sign Out</a>
			</c:if>
			<img align="middle" src="<aspectran:url value="/images/separator.gif"/>"/>
			<a href="<aspectran:url value="/help.html"/>">?</a>
		</div>
	</div>

	<div id="Search" data-hide-for="large">
		<div id="SearchContent">
			<form action="<aspectran:url value="/catalog/searchProducts"/>">
				<div class="input-group">
					<input class="input-group-field" type="text" name="keyword" placeholder="Product Search">
					<div class="input-group-button">
						<button type="submit" class="button">Search</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="QuickLinks">
	<c:forEach var="entry" items="${staticCodes.categories}">
		<a href="<aspectran:url value="/categories/${entry.key}"/>">${entry.value}</a>
	</c:forEach>
	</div>
</div>

<div id="Content">
