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
<h3>Account Information</h3>
<table>
	<colgroup>
		<col style="width: 25%"/>
		<col/>
	</colgroup>
	<tr>
		<td>First name:</td>
		<td>
			<input type="text" name="firstName" value="<c:out value="${account.firstName}" escapeXml="true"/>"/>
			<span class="error-msg">${errors.firstName}</span>
		</td>
	</tr>
	<tr>
		<td>Last name:</td>
		<td>
			<input type="text" name="lastName" value="<c:out value="${account.lastName}" escapeXml="true"/>"/>
			<span class="error-msg">${errors.lastName}</span>
		</td>
	</tr>
	<tr>
		<td>Email:</td>
		<td>
			<input type="text" name="email" value="${account.email}"/>
			<span class="error-msg">${errors.email}</span>
		</td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td>
			<input type="text" name="phone" value="${account.phone}"/>
			<span class="error-msg">${errors.phone}</span>
		</td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td>
			<input type="text" name="address1" value="${account.address1}"/>
			<span class="error-msg">${errors.address1}</span>
		</td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td>
			<input type="text" name="address2" value="${account.address2}"/>
			<span class="error-msg">${errors.address2}</span>
		</td>
	</tr>
	<tr>
		<td>City:</td>
		<td>
			<input type="text" name="city" value="${account.city}"/>
			<span class="error-msg">${errors.city}</span>
		</td>
	</tr>
	<tr>
		<td>State:</td>
		<td>
			<input type="text" name="state" value="${account.state}"/>
			<span class="error-msg">${errors.state}</span>
		</td>
	</tr>
	<tr>
		<td>Zip:</td>
		<td>
			<input type="text" name="zip" value="${account.zip}"/>
			<span class="error-msg">${errors.zip}</span>
		</td>
	</tr>
	<tr>
		<td>Country:</td>
		<td>
			<input type="text" name="country" value="${account.country}"/>
			<span class="error-msg">${errors.country}</span>
		</td>
	</tr>
</table>

<h3>Profile Information</h3>
<table>
	<colgroup>
		<col style="width: 25%"/>
		<col/>
	</colgroup>
	<tr>
		<td>Language Preference:</td>
		<td>
			<select name="languagePreference">
				<c:forEach items="${staticCodes.languages}" var="item">
					<option value="${item.key}"<c:if test="${account.languagePreference eq item.key}"> selected</c:if>>${item.value}</option>
				</c:forEach>
			</select>
			<span class="error-msg">${errors.languagePreference}</span>
		</td>
	</tr>
	<tr>
		<td>Favourite Category:</td>
		<td>
			<select name="favouriteCategoryId">
				<c:forEach items="${staticCodes.categories}" var="item">
					<option value="${item.key}"<c:if test="${account.favouriteCategoryId eq item.key}"> selected</c:if>>${item.value}</option>
				</c:forEach>
			</select>
			<span class="error-msg">${errors.favouriteCategoryId}</span>
		</td>
	</tr>
	<tr>
		<td>Enable MyList</td>
		<td>
			<input type="checkbox" name="listOption" value="true"<c:if test="${account.listOption}"> checked</c:if>/>
		</td>
	</tr>
	<tr>
		<td>Enable MyBanner</td>
		<td>
			<input type="checkbox" name="bannerOption" value="true"<c:if test="${account.bannerOption}"> checked</c:if>/>
		</td>
	</tr>
</table>
