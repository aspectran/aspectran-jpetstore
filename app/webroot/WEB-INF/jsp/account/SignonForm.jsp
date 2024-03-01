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

<c:if test="${param.created eq 'true'}">
	<div id="MessageBar">
		<p>Your account has been created. Please try login.</p>
	</div>
</c:if>

<div id="Signon">

	<form method="post" action="<aspectran:url value="/account/signon"/>">
		<input type="hidden" name="referer" value="${param.referer}"/>

		<div class="panel">
			<h5>Please enter your username and password.</h5>
			<label>Username: <input type="text" name="username" value="j2ee"/></label>
			<label>Password: <input type="password" name="password" value="j2ee"/></label>
			<div class="button-bar">
				<button type="submit" class="button">Login</button>
			</div>
			<c:if test="${param.retry eq 'true'}">
				<div class="panel failed">
					Invalid username or password.  Signon failed.
				</div>
			</c:if>
		</div>

	</form>

	<div class="panel register">
		Need a username and password?
		<a href="<aspectran:url value="/account/newAccountForm"/>">Register Now!</a>
	</div>

</div>

<%@ include file="../common/IncludeBottom.jsp"%>
