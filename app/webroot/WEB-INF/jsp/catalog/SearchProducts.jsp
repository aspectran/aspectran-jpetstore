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

<div id="BackLink">
	<a href="<aspectran:url value="/catalog/"/>">Return to Main Menu</a>
</div>

<div id="Catalog">

	<h3>Search Results for "${param.keyword}"</h3>

	<table>
		<colgroup>
			<col style="width: 20%"/>
			<col style="width: 30%"/>
			<col/>
		</colgroup>
		<tr>
			<th>Product ID</th>
			<th>Name</th>
			<th>Description</th>
		</tr>
		<c:forEach var="product" items="${productList}">
			<tr>
				<td>
					<strong><a href="<aspectran:url value="/catalog/products/${product.productId}"/>">${product.productId}</a></strong>
				</td>
				<td>${product.name}</td>
				<td style="text-align: left">
					<a href="<aspectran:url value="/catalog/products/${product.productId}"/>">${product.description}</a>
				</td>
			</tr>
		</c:forEach>
	</table>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
