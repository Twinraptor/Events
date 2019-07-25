<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Event Page</title>
</head>
<body>
	<a href="/events">Back to all events</a>
	<h1>Edit your event <c:out value="${event1.name}"/>, <c:out value="${userId.firstName}" /></h1>
	<div>
		<h2>Edit Event</h2>
	    <p><c:out value="${error}" /></p>
	<form:form action="/events/${event.id}" method="post" modelAttribute="event">
	<input type="hidden" name="_method" value="put">
    <form:input type="hidden" path="id" value="${event.id}" />
    <form:input type="hidden" path="user" value="${userId.id}" />
    <p>
        <form:label path="name">Name:</form:label>
        <form:errors path="name"/>
        <form:input path="name" value="${event.name}"/>
    </p>
    <p>
        <form:label path="edate">Date:</form:label>
        <form:input type="date" path="edate" format="mm/dd/yyyy" value="${event.edate}"/>
    </p>
    <p>
        <form:label path="location">Location:</form:label>
        <form:errors path="location"/>
        <form:input path="location" value="${event.location}"/>
    </p>
    <p>      
            <form:select path="state" value="${event.state}">
            	<form:option value="CA"/>
            	<form:option value="TX"/>
            	<form:option value="NY"/>
            	<form:option value="WA"/>
            	<form:option value="OR"/>
            	<form:option value="NV"/>
            </form:select>	
    </p>    
    <input type="submit" value="Edit"/>
</form:form>
	</div>
</body>
</html>