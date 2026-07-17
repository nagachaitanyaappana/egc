<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Villages</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-4">
    <h1>Admin Dashboard</h1>
    <p class="text-muted">Click a village to view its complaints and photos.</p>

    <table class="table table-bordered table-hover">
        <thead class="table-light">
        <tr>
            <th>#</th>
            <th>Village</th>
            <th>District</th>
            <th>Users</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="village" items="${villages}" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/village/${village.id}">
                        <c:out value="${village.name}"/>
                    </a>
                </td>
                <td><c:out value="${village.district}"/></td>
                <td>${village.users.size()}</td>
                <td>
                    <a class="btn btn-sm btn-primary"
                       href="${pageContext.request.contextPath}/admin/village/${village.id}">View Report</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty villages}">
            <tr><td colspan="5" class="text-center">No villages found.</td></tr>
        </c:if>
        </tbody>
    </table>

    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary mt-3">Back to Login</a>
</div>
</body>
</html>
