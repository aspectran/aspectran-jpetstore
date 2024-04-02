<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<div id="CenterForm">

	<form method="post" action="<aspectran:url value="/order/newOrder"/>">
		<input type="hidden" name="paymentForm" value="true"/>
		<input type="hidden" name="billingForm" value="true"/>

		<h3>Payment Details</h3>
		<table>
			<colgroup>
				<col style="width: 25%"/>
				<col/>
			</colgroup>
			<tr>
				<td>Card Type:</td>
				<td>
					<select name="cardType">
						<c:forEach items="${staticCodes.creditCardTypes}" var="item">
							<option value="${item.key}"<c:if test="${order.cardType eq item.key}"> selected</c:if>>${item.value}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>Card Number:</td>
				<td>
					* Use a fake number!
					<input type="text" name="creditCard" value="${order.creditCard}"/>
					<span class="error-msg">${errors.creditCard}</span>
				</td>
			</tr>
			<tr>
				<td>Expiry Date (MM/YYYY):</td>
				<td><input type="text" name="expiryDate" value="${order.expiryDate}"/>
					<span class="error-msg">${errors.expiryDate}</span></td>
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
				<td><input type="text" name="billToFirstName" value="${order.billToFirstName}"/>
					<span class="error-msg">${errors.billToFirstName}</span></td>
			</tr>
			<tr>
				<td>Last name:</td>
				<td><input type="text" name="billToLastName" value="${order.billToLastName}"/>
					<span class="error-msg">${errors.billToLastName}</span></td>
			</tr>
			<tr>
				<td>Address 1:</td>
				<td><input type="text" name="billAddress1" value="${order.billAddress1}"/>
					<span class="error-msg">${errors.billAddress1}</span></td>
			</tr>
			<tr>
				<td>Address 2:</td>
				<td><input type="text" name="billAddress2" value="${order.billAddress2}"/>
					<span class="error-msg">${errors.billAddress2}</span></td>
			</tr>
			<tr>
				<td>City:</td>
				<td><input type="text" name="billCity" value="${order.billCity}"/>
					<span class="error-msg">${errors.billCity}</span></td>
			</tr>
			<tr>
				<td>State:</td>
				<td><input type="text" name="billState" value="${order.billState}"/>
					<span class="error-msg">${errors.billState}</span></td>
			</tr>
			<tr>
				<td>Zip:</td>
				<td><input type="text" name="billZip" value="${order.billZip}"/>
					<span class="error-msg">${errors.billZip}</span></td>
			</tr>
			<tr>
				<td>Country:</td>
				<td><input type="text" name="billCountry" value="${order.billCountry}"/>
					<span class="error-msg">${errors.billCountry}</span></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="checkbox" name="shippingAddressRequired" value="true" <c:if test="${order.shippingAddressRequired}">checked</c:if>/>
					Ship to different address...
				</td>
			</tr>
		</table>

		<c:if test="${not empty order}">
		<div class="button-bar">
			<button type="submit" class="button">Continue</button>
			<button type="button" class="button" onclick="location.href='<aspectran:url value="/cart/viewCart"/>';">Cancel</button>
		</div>
		</c:if>

	</form>

</div>

<c:if test="${empty order}">
<script>
	alert("An order could not be created because a cart could not be found.");
	location.href = "<aspectran:url value="/"/>";
</script>
</c:if>

<%@ include file="../common/IncludeBottom.jsp"%>
