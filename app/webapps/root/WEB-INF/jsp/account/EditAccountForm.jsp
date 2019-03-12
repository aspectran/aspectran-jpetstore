<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<c:if test="${param.updated eq 'true'}">
	<div id="MessageBar">
		<p>Your account has been updated.</p>
	</div>
</c:if>

<div id="CenterForm">

	<form method="post" action="/account/editAccount">

		<h3>User Information</h3>
		<table>
			<colgroup>
				<col style="width: 25%"/>
				<col/>
			</colgroup>
			<tr>
				<td>User ID:</td>
				<td>${account.username}</td>
			</tr>
			<tr>
				<td>New password:</td>
				<td>
					<input type="password" name="password" value="${account.password}" autocomplete="off"/>
					<span class="error-msg">${errors.password}</span>
				</td>
			</tr>
			<tr>
				<td>Confirm password:</td>
				<td>
					<input type="password" name="repeatedPassword" value="${account.repeatedPassword}" autocomplete="off"/>
					<span class="error-msg">${errors.repeatedPassword}</span>
				</td>
			</tr>
		</table>

		<%@ include file="IncludeAccountFields.jsp" %>

		<div class="button-bar">
			<button type="submit" class="button">Save Account Information</button>
		</div>

	</form>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
