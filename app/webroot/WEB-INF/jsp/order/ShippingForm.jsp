<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
		<input type="hidden" name="shippingForm" value="true"/>

		<h3>Shipping Address</h3>
		<table>
			<colgroup>
				<col style="width: 25%"/>
				<col/>
			</colgroup>
			<tr>
				<td>First name:</td>
				<td><input type="text" name="shipToFirstName" value="${order.shipToFirstName}"/>
					<span class="error-msg">${errors.shipToFirstName}</span></td>
			</tr>
			<tr>
				<td>Last name:</td>
				<td><input type="text" name="shipToLastName" value="${order.shipToLastName}"/>
					<span class="error-msg">${errors.shipToLastName}</span></td>
			</tr>
			<tr>
				<td>Address 1:</td>
				<td><input type="text" name="shipAddress1" value="${order.shipAddress1}"/>
					<span class="error-msg">${errors.shipAddress1}</span></td>
			</tr>
			<tr>
				<td>Address 2:</td>
				<td><input type="text" name="shipAddress2" value="${order.shipAddress2}"/>
					<span class="error-msg">${errors.shipAddress2}</span></td>
			</tr>
			<tr>
				<td>City:</td>
				<td><input type="text" name="shipCity" value="${order.shipCity}"/>
					<span class="error-msg">${errors.shipCity}</span></td>
			</tr>
			<tr>
				<td>State:</td>
				<td><input type="text" name="shipState" value="${order.shipState}"/>
					<span class="error-msg">${errors.shipState}</span></td>
			</tr>
			<tr>
				<td>Zip:</td>
				<td><input type="text" name="shipZip" value="${order.shipZip}"/>
					<span class="error-msg">${errors.shipZip}</span></td>
			</tr>
			<tr>
				<td>Country:</td>
				<td><input type="text" name="shipCountry" value="${order.shipCountry}"/>
					<span class="error-msg">${errors.shipCountry}</span></td>
			</tr>
		</table>

		<div class="button-bar">
			<button type="submit" class="button">Continue</button>
			<button type="button" class="button" onclick="location.href='<aspectran:url value="/order/newOrderForm"/>';">Back</button>
		</div>

	</form>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
