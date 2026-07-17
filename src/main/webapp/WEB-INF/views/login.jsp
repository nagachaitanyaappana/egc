<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Child Protection System</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .login-box {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 350px;
        }
        .login-box h2 {
            margin-top: 0;
            text-align: center;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Login</h2>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger">Invalid username or password</div>
    </c:if>
    <c:if test="${param.logout != null}">
        <div class="alert alert-success">You have been logged out</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required autofocus/>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required/>
        </div>
        <button type="submit" class="btn btn-primary">Sign In</button>
    </form>
    <p style="font-size:0.9rem; text-align:center; color:#6c757d; margin-top:1rem;">
        &copy; 2025 Child Protection System
    </p>
</div>
</body>
</html>
