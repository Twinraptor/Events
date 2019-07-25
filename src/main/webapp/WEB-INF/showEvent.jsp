<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<a href="/events">Back to all events</a>
	<h1><c:out value="${event.name}" /></h1>
	<p>Host: <c:out value="${event.user.firstName}" /> <c:out value="${event.user.lastName}" /></p>
	<p>Date: <c:out value="${event.edate}" /></p>
	<p>Date: <c:out value="${event.location}" />, <c:out value="${event.state}" /></p>
	<p>People who are attending this event:
	<table>
		<tr>
			<th>Name</th>
			<th>Location</th>
		</tr>
		<c:forEach items="${event.attendingUsers}" var="u">
		<tr>
			<td><c:out value="${u.firstName}" /> <c:out value="${u.lastName}" /></td>
			<td><c:out value="${u.location}" /> - <c:out value="${u.state}" /></td>
		</tr>
		</c:forEach>
	</table>
	<br>
	<h2>Message Wall</h2>
		<c:forEach items="${messages}" var="m">
		<p><c:out value="${m.message}"/> - <c:out value="${m.writer}" /></p>
		</c:forEach>
	<br>
	<h2>Add a comment</h2>
	<form:form action="/events/${event.id}/message/add" method="post" modelAttribute="message">
	<form:input type="hidden" path="event" value="${event.id}" />
	<form:input type="hidden" path="writer" value='${userId.firstName} ${userId.lastName}' />
	<p>
        <form:label path="message">Message</form:label>
        <form:errors path="message"/>     
        <form:textarea path="Message"/>
    </p>
    <input type="submit" value="Add Message"/> 
	</form:form>
</body>
</html>