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

<div id="Catalog">

	<h3>My Orders</h3>
	<table>
		<tr>
			<th>Order ID</th>
			<th>Date</th>
			<th>Total Price</th>
		</tr>
		<c:forEach var="order" items="${orderList}">
			<tr>
				<td>
					<a href="<aspectran:url value="/order/viewOrder?orderId=${order.orderId}"/>">${order.orderId}</a>
				</td>
				<td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatNumber value="${order.totalPrice}" pattern="$#,##0.00"/></td>
			</tr>
		</c:forEach>
		<c:if test="${empty orderList}">
			<tr>
				<td colspan="3">
					You have placed no orders.
				</td>
			</tr>
		</c:if>
	</table>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
