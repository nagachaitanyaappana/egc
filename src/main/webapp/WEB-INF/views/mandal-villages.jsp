<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Villages - ${mandal.name}</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root {
            --gov-navy: #0d2b5e;
            --gov-blue: #1a4d8f;
            --gov-light: #f4f6fa;
            --gov-border: #dce3f0;
        }
        body {
            background-color: var(--gov-light);
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        .gov-header {
            background: linear-gradient(90deg, var(--gov-navy), var(--gov-blue));
            color: white;
            padding: 1.2rem 0;
            border-bottom: 4px solid #f1c40f;
        }
        .gov-header .site-title {
            font-weight: 700;
            font-size: 1.35rem;
            margin: 0;
        }
        .gov-header .site-subtitle {
            font-size: 0.9rem;
            opacity: 0.9;
            margin: 0;
        }
        .gov-card {
            border: 4px solid #1a4d8f !important;
            border-radius: 0 !important;
            transition: transform .2s ease, box-shadow .2s ease !important;
            background: white !important;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08) !important;
            height: 100%;
            text-decoration: none;
            color: inherit;
            overflow: hidden;
        }
        .gov-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 30px rgba(13,43,94,.15);
        }
        .gov-card-body {
            padding: 1.5rem 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            min-height: 180px;
        }
        .gov-card-title {
            font-weight: 600;
            font-size: 1.1rem;
            color: var(--gov-navy);
            margin-bottom: 0.5rem;
        }
        .gov-footer {
            background: var(--gov-navy);
            color: rgba(255,255,255,.85);
            padding: 1rem 0;
            margin-top: 2rem;
            font-size: 0.85rem;
        }
        .page-header-actions {
            border-bottom: 1px solid var(--gov-border);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
<header class="gov-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <div class="site-title">East Godavari District Administration</div>
            <div class="site-subtitle">Village Directory - <c:out value="${mandal.name}"/></div>
        </div>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</header>

<div class="container mt-4 mb-5">
    <div class="row mb-3">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${mandal.name}</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="page-header-actions d-flex justify-content-between align-items-end">
        <div>
            <h1 class="mb-1" style="font-weight:700; color:var(--gov-navy);">Villages in ${mandal.name}</h1>
            <p class="text-muted mb-0">
                <i class="bi bi-geo-alt"></i> District: <c:out value="${mandal.district}"/>
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary btn-sm">
            &larr; Back to Mandals
        </a>
    </div>

    <div class="row g-3">
        <c:forEach var="village" items="${villages}" varStatus="loop">
            <div class="col-md-3 col-sm-4 col-6">
                <a href="${pageContext.request.contextPath}/admin/village/${village.id}"
                   class="gov-card">
                    <div class="gov-card-body text-center">
                        <div class="mandal-index mx-auto mb-3" style="width:48px;height:48px;font-size:1.1rem;font-weight:600;">
                            ${loop.index + 1}
                        </div>
                        <div class="gov-card-title">
                            <c:out value="${village.name}"/>
                        </div>
                        <div class="text-muted small">
                            ${village.district}
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
        <c:if test="${empty villages}">
            <div class="col-12">
                <div class="alert alert-info">No villages found in this mandal.</div>
            </div>
        </c:if>
    </div>
</div>

<footer class="gov-footer">
    <div class="container text-center">
        &copy; 2025 East Godavari District Administration. Government of Andhra Pradesh. All rights reserved.
    </div>
</footer>
</body>
</html>
