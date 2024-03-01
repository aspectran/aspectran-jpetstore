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
	<a href="<aspectran:url value="/catalog/products/${product.productId}"/>">Return to ${product.productId}</a>
</div>

<div id="CenterForm">

	<h3>${product.name}</h3>

	<table>
		<tr>
			<td>
				<img src="<aspectran:url value="${product.image}"/>"/>
				${product.description}
			</td>
		</tr>
		<tr>
			<td><strong>${item.itemId}</strong></td>
		</tr>
		<tr>
			<td><strong><small> ${item.attribute1}
			${item.attribute2} ${item.attribute3}
			${item.attribute4} ${item.attribute5}
			${product.name} </small></strong></td>
		</tr>
		<tr>
			<td>
				<c:if test="${item.quantity le 0}">Back ordered.</c:if>
				<c:if test="${item.quantity gt 0}">${item.quantity} in stock.</c:if>
			</td>
		</tr>
		<tr>
			<td><fmt:formatNumber value="${item.listPrice}" pattern="$#,##0.00"/></td>
		</tr>
	</table>
	<div class="button-bar">
		<a class="button" href="<aspectran:url value="/cart/addItemToCart?itemId=${item.itemId}"/>">Add to Cart</a>
	</div>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
