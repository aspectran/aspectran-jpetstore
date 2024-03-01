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

<div id="MessageBar">
	<p>Please confirm the information below and then press continue...</p>
</div>

<div id="BackLink">
	<a href="<aspectran:url value="/catalog/"/>">Return to Main Menu</a>
</div>

<div id="CenterForm">
	<form method="post" action="<aspectran:url value="/order/submitOrder"/>">
		<input type="hidden" name="confirmed" value="true"/>

		<h3>Order</h3>
		<table>
			<colgroup>
				<col style="width: 25%"/>
				<col/>
			</colgroup>
			<tr>
				<td>Order Date</td>
				<td>
					<fmt:formatDate value="${user.order.orderDate}" pattern="yyyy/MM/dd hh:mm:ss"/>
				</td>
			</tr>
		</table>

		<h3>Billing Address</h3>
		<table>
			<colgroup>
				<col style="width: 25%;"/>
				<col/>
			</colgroup>
			<tr>
				<td>First name:</td>
				<td><c:out value="${user.order.billToFirstName}"/></td>
			</tr>
			<tr>
				<td>Last name:</td>
				<td><c:out value="${user.order.billToLastName}"/></td>
			</tr>
			<tr>
				<td>Address 1:</td>
				<td><c:out value="${user.order.billAddress1}"/></td>
			</tr>
			<tr>
				<td>Address 2:</td>
				<td><c:out value="${user.order.billAddress2}"/></td>
			</tr>
			<tr>
				<td>City:</td>
				<td><c:out value="${user.order.billCity}"/></td>
			</tr>
			<tr>
				<td>State:</td>
				<td><c:out value="${user.order.billState}"/></td>
			</tr>
			<tr>
				<td>Zip:</td>
				<td><c:out value="${user.order.billZip}"/></td>
			</tr>
			<tr>
				<td>Country:</td>
				<td><c:out value="${user.order.billCountry}"/></td>
			</tr>
		</table>

		<h3>Shipping Address</h3>
		<table>
			<colgroup>
				<col style="width: 25%;"/>
				<col/>
			</colgroup>
			<tr>
				<td>First name:</td>
				<td><c:out value="${user.order.shipToFirstName}"/></td>
			</tr>
			<tr>
				<td>Last name:</td>
				<td><c:out value="${user.order.shipToLastName}"/></td>
			</tr>
			<tr>
				<td>Address 1:</td>
				<td><c:out value="${user.order.shipAddress1}"/></td>
			</tr>
			<tr>
				<td>Address 2:</td>
				<td><c:out value="${user.order.shipAddress2}"/></td>
			</tr>
			<tr>
				<td>City:</td>
				<td><c:out value="${user.order.shipCity}"/></td>
			</tr>
			<tr>
				<td>State:</td>
				<td><c:out value="${user.order.shipState}"/></td>
			</tr>
			<tr>
				<td>Zip:</td>
				<td><c:out value="${user.order.shipZip}"/></td>
			</tr>
			<tr>
				<td>Country:</td>
				<td><c:out value="${user.order.shipCountry}"/></td>
			</tr>
		</table>

		<div class="button-bar">
			<button type="submit" class="button">Confirm</button>
			<button type="button" class="button" onclick="location.href='/order/newOrderForm';">Back</button>
		</div>
	</form>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
