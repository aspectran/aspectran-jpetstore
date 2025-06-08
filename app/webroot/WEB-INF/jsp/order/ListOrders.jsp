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

	<h3>My Orders (<fmt:formatNumber value="${pageInfo.totalElements}"/>)</h3>
	<table>
		<tr>
			<th>Order ID</th>
			<th>Date</th>
			<th>Total Price</th>
			<th>Courier</th>
			<th>Status</th>
		</tr>
		<c:forEach var="order" items="${orderList}">
			<tr>
				<td>
					<a href="<aspectran:url value="/order/viewOrder?orderId=${order.orderId}"/>">${order.orderId}</a>
				</td>
				<td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatNumber value="${order.totalPrice}" pattern="$#,##0.00"/></td>
				<td>${order.courier}</td>
				<td>${order.status}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty orderList}">
			<tr>
				<td colspan="5">
					You have placed no orders.
				</td>
			</tr>
		</c:if>
	</table>

	<c:if test="${pageInfo.totalPages > 1}">
	<nav aria-label="Page navigation">
		<ul class="pagination text-center">
			<li class="<c:if test="${pageInfo.number <= 1}">disabled</c:if>">
				<c:if test="${pageInfo.number > 1}">
				<a href="<aspectran:url value="/order/listOrders?page=1"/>" title="First" aria-label="First page">First</a>
				</c:if>
				<c:if test="${pageInfo.number <= 1}">
				<span title="First" aria-label="First page">First</span>
				</c:if>
			</li>
			<li class="<c:if test="${pageInfo.number <= 5}">disabled</c:if>">
				<c:if test="${pageInfo.number > 5 and pageInfo.number % 5 == 1}">
				<a href="<aspectran:url value="/order/listOrders?page={pageNumber}"><aspectran:param name="pageNumber" value="${pageInfo.number - 1}"/></aspectran:url>" title="Previous" aria-label="Previous page">&laquo;</a>
				</c:if>
				<c:if test="${pageInfo.number > 5 and pageInfo.number % 5 > 1}">
				<a href="<aspectran:url value="/order/listOrders?page={pageNumber}"><aspectran:param name="pageNumber" value="${pageInfo.number - 5}"/></aspectran:url>" title="Previous" aria-label="Previous page">&laquo;</a>
				</c:if>
				<c:if test="${pageInfo.number <= 5}">
				<span title="Previous" aria-label="Previous page">&laquo;</span>
				</c:if>
			</li>
			<c:forEach var="i" begin="${pageInfo.number - (pageInfo.number - 1) % 5}" end="${pageInfo.number - (pageInfo.number - 1) % 5 + 4}">
			<c:if test="${i <= pageInfo.totalPages}">
			<li class="<c:if test="${pageInfo.number == i}">current</c:if>">
				<c:if test="${pageInfo.number != i}">
				<a href="<aspectran:url value="/order/listOrders?page={pageNumber}"><aspectran:param name="pageNumber" value="${i}"/></aspectran:url>" aria-label="Page ${i}">${i}</a>
				</c:if>
				<c:if test="${pageInfo.number == i}">
				<span class="show-for-sr">You're on page</span> ${i}
				</c:if>
			</li>
			</c:if>
			</c:forEach>
			<li class="<c:if test="${pageInfo.number >= pageInfo.totalPages - (pageInfo.totalPages - 1) % 5}">disabled</c:if>">
				<c:if test="${pageInfo.number < pageInfo.totalPages - (pageInfo.totalPages - 1) % 5}">
					<c:if test="${pageInfo.number < pageInfo.totalPages - 5 and pageInfo.number % 5 == 0}">
					<a href="<aspectran:url value="/order/listOrders?page={pageNumber}"><aspectran:param name="pageNumber" value="${pageInfo.number + 1}"/></aspectran:url>" title="Next" aria-label="Next page">&raquo;</a>
					</c:if>
					<c:if test="${pageInfo.number < pageInfo.totalPages - 5 and pageInfo.number % 5 > 0}">
					<a href="<aspectran:url value="/order/listOrders?page={pageNumber}"><aspectran:param name="pageNumber" value="${pageInfo.number + 5}"/></aspectran:url>" title="Next" aria-label="Next page">&raquo;</a>
					</c:if>
					<c:if test="${pageInfo.totalPages > 5 and pageInfo.number >= pageInfo.totalPages - 5}">
					<a href="<aspectran:url value="/order/listOrders?page={pageNumber}"><aspectran:param name="pageNumber" value="${pageInfo.totalPages}"/></aspectran:url>" title="Next" aria-label="Next page">&raquo;</a>
					</c:if>
				</c:if>
				<c:if test="${pageInfo.number >= pageInfo.totalPages - (pageInfo.totalPages - 1) % 5}">
				<span title="Next" aria-label="Next page">&raquo;</span>
				</c:if>
			</li>
			<li class="<c:if test="${pageInfo.number >= pageInfo.totalPages}">disabled</c:if>">
				<c:if test="${pageInfo.number < pageInfo.totalPages}">
				<a href="<aspectran:url value="/order/listOrders?page={pageNumber}"><aspectran:param name="pageNumber" value="${pageInfo.totalPages}"/></aspectran:url>" title="Last" aria-label="Last page">Last</a>
				</c:if>
				<c:if test="${pageInfo.number >= pageInfo.totalPages}">
				<span title="Last" aria-label="Last page">Last</span>
				</c:if>
			</li>
		</ul>
	</nav>
	</c:if>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
