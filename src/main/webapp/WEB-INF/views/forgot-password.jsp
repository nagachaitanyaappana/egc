<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - Child Protection System</title>
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
        .box {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 400px;
        }
        .box h2 {
            margin-top: 0;
            text-align: center;
        }
        .btn-primary { width: 100%; }
    </style>
</head>
<body>
<div class="box">
    <h2>Forgot Password</h2>

    <c:if test="${notFound != null}">
        <div class="alert alert-danger">No account found with that username or email.</div>
    </c:if>

    <c:if test="${token != null}">
        <div class="alert alert-success">
            <p>A password reset token has been generated:</p>
            <code>${token}</code>
            <p class="mt-2 mb-0">Use this token on the reset page to set a new password.</p>
        </div>
        <a href="${pageContext.request.contextPath}/reset-password?token=${token}" class="btn btn-outline-primary w-100 mb-2">Continue to Reset Password</a>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="mb-3">
            <label for="identifier" class="form-label">Username or Email</label>
            <input type="text" class="form-control" id="identifier" name="identifier" required autofocus/>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    <p style="font-size:0.9rem; text-align:center; color:#6c757d; margin-top:1rem;">
        <a href="${pageContext.request.contextPath}/login">Back to Login</a>
    </p>
</div>
</body>
</html>
