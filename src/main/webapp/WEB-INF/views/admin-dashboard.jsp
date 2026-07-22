<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Mandals</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .card-hover { transition: transform .2s ease; cursor: pointer; }
        .card-hover:hover { transform: translateY(-4px); box-shadow: 0 6px 20px rgba(0,0,0,.1); }
        .mandal-card-title { font-weight: 600; font-size: 1.1rem; }
        .badge-count { font-size: 0.85rem; }
    </style>
</head>
<body>
<div class="container mt-4">
    <h1>East Godavari Mandals</h1>
    <p class="text-muted">Click a mandal to view its villages and complaints.</p>

    <div class="row g-3">
        <c:forEach var="mandal" items="${mandals}" varStatus="loop">
            <div class="col-md-4 col-sm-6">
                <a href="${pageContext.request.contextPath}/admin/mandal/${mandal.id}"
                   class="text-decoration-none">
                    <div class="card card-hover h-100 border-0 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title village-card-title text-dark">
                                <c:out value="${mandal.name}"/>
                            </h5>
                            <p class="card-text text-muted small mb-2">${mandal.district}</p>
                            <span class="badge bg-primary badge-count">
                                ${loop.index + 1}
                            </span>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>

    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary mt-4">Back to Login</a>
</div>
</body>
</html>
