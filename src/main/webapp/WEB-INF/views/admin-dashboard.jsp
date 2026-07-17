<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Complaints</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        .complaint-card {
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 1rem;
        }
        .photo-thumb {
            max-width: 150px;
            max-height: 150px;
            object-fit: cover;
            border: 1px solid #eee;
            margin-bottom: 0.5rem;
        }
        .content-preview {
            white-space: pre-wrap;
            background-color: #f5f5f5;
            padding: 0.5rem;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h1>Admin Complaint Dashboard</h1>
    <p><strong>Total Complaints:</strong> ${complaints.size()}</p>

    <c:forEach var="complaint" items="${complaints}">
        <div class="complaint-card card">
            <div class="card-body">
                <h5 class="card-title">From <c:out value="${complaint.user.username}"/> (Village: <c:out value="${complaint.user.villageName}"/>)</h5>
                <p class="card-text">
                    <strong>Complaint:</strong>
                    <div class="content-preview"><c:out value="${complaint.content}"/></div>
                </p>
                <p class="card-text"><small class="text-muted">Submitted on <c:out value="${complaint.createdAt}"/></small></p>
                <p>Photos:</p>
                <c:forEach var="photo" items="${complaint.photos}">
                    <div class="d-flex">
                        <img src="${pageContext.request.contextPath}/${photo.filePath}"
                             class="photo-thumb img-fluid rounded mb-2"
                             style="width: 100px; height: 100px; object-fit: cover;"/>
                    </div>
                </c:forEach>
                <c:if test="${empty complaint.photos}">None</c:if>
            </div>
        </div>
        <hr>
    </c:forEach>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary mt-3">Back to Login</a>
</div>
</body>
</html>