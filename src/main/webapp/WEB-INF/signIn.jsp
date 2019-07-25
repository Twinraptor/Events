<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
</head>
<body>
    <h1>Welcome</h1>
    <div>
		<h1>Register</h1>
    <p><form:errors path="user.*"/></p>
    <form:form method="POST" action="/registration" modelAttribute="user">
        <p>
            <form:label path="firstName">First Name:</form:label>
            <form:errors path="firstName" />
            <form:input path="firstName"/>
        </p>
        <p>
            <form:label path="lastName">Last Name:</form:label>
            <form:errors path="lastName" />
            <form:input path="LastName"/>
        </p>
        <p>
            <form:label path="location">Location:</form:label>
            <form:errors path="location" />
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
        <p>
            <form:label path="email">Email:</form:label>
            <form:errors path="email" />
            <form:input type="email" path="email"/>
        </p>
        <p>
            <form:label path="password">Password:</form:label>
            <form:errors path="password" />
            <form:password path="password"/>
        </p>
        <p>
            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
            <form:password path="passwordConfirmation"/>
        </p>
        <input type="submit" value="Register!"/>
    </form:form>
    </div>
    <div>
		<h1>Login</h1>
    		<p><c:out value="${error}" /></p>
    			<form method="post" action="/login">
        			<p>
            			<label for="email">Email</label>
            			<input type="text" id="email" name="email"/>
        			</p>
        			<p>
            			<label for="password">Password</label>
            			<input type="password" id="password" name="password"/>
        			</p>
        			<input type="submit" value="Login!"/>
    			</form>
	</div>
</body>
</html>
