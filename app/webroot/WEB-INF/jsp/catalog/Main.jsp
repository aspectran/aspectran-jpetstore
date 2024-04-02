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

<div id="Welcome">
	<div id="WelcomeContent">
		<c:if test="${not empty user.account}">
			<aspectran:message code='welcome' arguments="${user.account.firstName}" htmlEscape="true" javaScriptEscape="true"/>
		</c:if>
	</div>
</div>

<div id="Main">
	<div id="Sidebar">
		<div id="SidebarContent">
			<a href="<aspectran:url value="/categories/FISH"/>">Fish</a><br/>
			Saltwater, Freshwater<br />
			<a href="<aspectran:url value="/categories/DOGS"/>">Dogs</a><br/>
			Various Breeds<br />
			<a href="<aspectran:url value="/categories/CATS"/>">Cats</a><br/>
			Various Breeds, Exotic Varieties<br />
			<a href="<aspectran:url value="/categories/REPTILES"/>">Reptiles</a><br/>
			Lizards, Turtles, Snakes<br />
			<a href="<aspectran:url value="/categories/BIRDS"/>">Birds</a><br/>
			Exotic Varieties<br />
		</div>
	</div>
	<div id="MainImage">
		<div id="MainImageContent">
		  <map name="estoremap">
			<area alt="Birds" coords="72,2,280,250"
				href="<aspectran:url value="/categories/BIRDS"/>" shape="RECT"/>
			<area alt="Fish" coords="2,180,72,250"
				href="<aspectran:url value="/categories/FISH"/>" shape="RECT"/>
			<area alt="Dogs" coords="60,250,130,320"
				href="<aspectran:url value="/categories/DOGS"/>" shape="RECT"/>
			<area alt="Reptiles" coords="140,270,210,340"
				href="<aspectran:url value="/categories/REPTILES"/>" shape="RECT"/>
			<area alt="Cats" coords="225,240,295,310"
				href="<aspectran:url value="/categories/CATS"/>" shape="RECT"/>
			<area alt="Birds" coords="280,180,350,250"
				href="<aspectran:url value="/categories/BIRDS"/>" shape="RECT"/>
		  </map>
		  <img height="355" src="<aspectran:url value="/images/splash.gif"/>" align="middle" usemap="#estoremap" width="350"/>
		</div>
	</div>
	<div id="RightSidebar">
		<div id="MyList">
			<c:if test="${not empty user.account}">
				<c:if test="${!empty user.account.listOption}">
					<%@ include file="../cart/IncludeMyList.jsp"%>
				</c:if>
			</c:if>
		</div>
	</div>

	<div id="Separator">&nbsp;</div>
</div>

<%@ include file="../common/IncludeBottom.jsp"%>
