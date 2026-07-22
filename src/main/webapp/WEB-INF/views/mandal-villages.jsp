<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Villages - ${mandal.name}</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .card-hover { transition: transform .2s ease; cursor: pointer; }
        .card-hover:hover { transform: translateY(-4px); box-shadow: 0 6px 20px rgba(0,0,0,.1); }
        .village-card-title { font-weight: 600; font-size: 1.1rem; }
        .badge-complaints { font-size: 0.85rem; }
    </style>
</head>
<body>
<div class="container mt-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Mandal Dashboard</a></li>
            <li class="breadcrumb-item active" aria-current="page">${mandal.name}</li>
        </ol>
    </nav>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1>Villages in ${mandal.name}</h1>
            <p class="text-muted mb-0">District: <c:out value="${mandal.district}"/></p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">&larr; Back to Mandals</a>
    </div>

    <div class="row g-3">
        <c:forEach var="village" items="${villages}">
            <div class="col-md-4 col-sm-6">
                <a href="${pageContext.request.contextPath}/admin/village/${village.id}"
                   class="text-decoration-none">
                    <div class="card card-hover h-100 border-0 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title village-card-title text-dark">
                                <c:out value="${village.name}"/>
                            </h5>
                            <p class="card-text text-muted small mb-2">${village.district}</p>
                            <span class="badge bg-primary badge-complaints">
                                ${village.users.size()} Users
                            </span>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
        <c:if test="${empty villages}">
            <div class="col-12">
                <div class="alert alert-info">No villages with complaints found in this mandal.</div>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
