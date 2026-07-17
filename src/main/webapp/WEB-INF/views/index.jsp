<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>EGC Website - Users</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-4">
    <h1>Welcome to EGC Website</h1>
    <h2>Users</h2>
    <table class="table" <c:if test="${empty users}">style="display:none"</c:if>>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Created At</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
            <tr>
                <td><c:out value="${user.id}"/></td>
                <td><c:out value="${user.username}"/></td>
                <td><c:out value="${user.email}"/></td>
                <td><c:out value="${user.createdAt}"/></td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <h3>Add New User</h3>
    <form action="${pageContext.request.contextPath}/users" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required/>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required/>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required/>
        </div>
        <div class="mb-3">
            <label for="villageName" class="form-label">Village Name</label>
            <input type="text" class="form-control" id="villageName" name="villageName" required/>
        </div>
        <button type="submit" class="btn btn-primary">Add User</button>
    </form>
</div>
</body>
</html>
