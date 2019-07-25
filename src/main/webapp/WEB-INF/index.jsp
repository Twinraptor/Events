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
	<h1>Welcome, <c:out value="${userId.firstName}" /> <c:out value="${userId.state}" /></h1>
	<a href="/logout">Logout</a>
	<div>
		<p>Here are some of the events in your state:</p>
		<table>
			<thead>
				<tr>
					<th>Name</th>
					<th>Date</th>
					<th>Location</th>
					<th>State</th>
					<th>Host</th>
					<th>Action / Status</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${events}" var="e">
				<c:if test="${userId.state == e.state}" >
				<tr>
					<td><a href="/events/${e.id}"><c:out value="${e.name}" /></a></td>
					<td><c:out value="${e.edate}" /></td>
					<td><c:out value="${e.location}" /></td>
					<td><c:out value="${e.state}" /></td>
					<td><c:out value="${e.user.firstName}" /></td>
					<td><c:if test="${userId.id == e.user.id}"><a href="/events/${e.id}/edit"><button>Edit</button></a> | <form:form action="/events/${e.id}" method="post"><input type="hidden" name="_method" value="delete">
    					<button type="submit">Delete</button>
					</form:form></c:if>
					<c:if test="${userId.id != e.user.id}">
						<c:choose>
						<c:when test="${e.attendingUsers.contains(userId)}" >
							<p>Joined</p> | <form:form action="/events/${e.id}/${userId.id}" method="post">
						<input type="hidden" name="_method" value="delete">
						<button>Cancel</button></form:form></td>
						</c:when>
						<c:otherwise>
						<form:form action="/events/${e.id}/${userId.id}" method="post" modelAttribute="newEventUser">
							<form:input type="hidden" path="event" value="${e.id}" />
							<form:input type="hidden" path="user" value="${userId.id}" />
							<button type="submit">Join</button>
						</form:form>
						</c:otherwise>
						</c:choose>
					</c:if>
				</tr>
				</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<p>Here are some of the events in other states:</p>
		<table>
			<thead>
				<tr>
					<th>Name</th>
					<th>Date</th>
					<th>Location</th>
					<th>State</th>
					<th>Host</th>
					<th>Action / Status</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${events}" var="e">
				<c:if test="${userId.state != e.state}" >
				<tr>
					<td><a href="/events/${e.id}"><c:out value="${e.name}" /></a></td>
					<td><c:out value="${e.edate}" /></td>
					<td><c:out value="${e.location}" /></td>
					<td><c:out value="${e.state}" /></td>
					<td><c:out value="${e.user.firstName}" /></td>
					<td><c:if test="${userId.id == e.user.id}"><a href="/events/${e.id}/edit"><button>Edit</button></a> | <form:form action="/events/${e.id}" method="post"><input type="hidden" name="_method" value="delete">
    					<button type="submit">Delete</button>
					</form:form></c:if>
					<c:if test="${userId.id != e.user.id}">
						<c:choose>
						<c:when test="${e.attendingUsers.contains(userId)}" >
							<p>Joined</p> | <form:form action="/events/${e.id}/${userId.id}" method="post">
						<input type="hidden" name="_method" value="delete">
						<button>Cancel</button></form:form>
						</c:when>
						<c:otherwise>
						<form:form action="/events/${e.id}/${userId.id}" method="post" modelAttribute="newEventUser">
							<form:input type="hidden" path="event" value="${e.id}" />
							<form:input type="hidden" path="user" value="${userId.id}" />
							<button type="submit">Join</button>
						</form:form>
						</c:otherwise>
						</c:choose>
					</c:if></td>		</tr>
				</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<h2>Create an Event</h2>
	    <p><c:out value="${error}" /></p>
	<form:form action="/events/add" method="post" modelAttribute="event">
    <p>
    	<form:input type="hidden" path="user" value="${userId.id}" />
    </p>
    <p>
        <form:label path="name">Name:</form:label>
        <form:errors path="name"/>
        <form:input path="name"/>
    </p>
    <p>
        <form:label path="edate">Date:</form:label>
        <form:input type="date" path="edate"/>
    </p>
    <p>
        <form:label path="location">Location:</form:label>
        <form:errors path="location"/>
        <form:input path="location"/>
    </p>
    <p>      
            <form:select path="state">
            	<form:option value="CA"/>
            	<form:option value="TX"/>
            	<form:option value="NY"/>
            	<form:option value="WA"/>
            	<form:option value="OR"/>
            	<form:option value="NV"/>
            </form:select>	
    </p>    
    <input type="submit" value="Create"/>
</form:form>
	</div>
	
</body>
</html>