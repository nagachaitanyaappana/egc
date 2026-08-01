<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mandal Wise Reports</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/global.css">
</head>
<body>
<div class="page-wrap">
    <header class="app-header">
        <div class="header-inner">
            <div class="header-left"></div>
            <div class="header-center">
                <div class="brand-center">
                    <div class="brand">EGC Admin</div>
                    <div class="subtitle">Mandal Wise Reports</div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
                </ul>
            </div>
            <div class="header-right">
                <form method="post" action="${pageContext.request.contextPath}/api/auth/logout" style="display:inline;">
                    <button type="submit" class="btn btn-outline-light btn-sm">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </header>

    <div class="page-content container mt-4 mb-5">

        <div class="d-flex justify-content-between align-items-end mb-3">
            <div>
                <h1 class="section-title">Mandal Wise Reports</h1>
                <p class="text-muted mb-0">Select a mandal to view reports.</p>
            </div>
            <div class="text-end text-muted small">
                Total Mandals: <strong>${mandals.size()}</strong>
            </div>
        </div>

        <div class="row g-3" style="display:flex; flex-wrap:wrap;">
            <c:forEach var="mandal" items="${mandals}" varStatus="loop">
                <div class="col-md-3 col-sm-4 col-6">
                <a href="${pageContext.request.contextPath}/admin/mandal/${mandal.id}" class="text-decoration-none d-block">
                     <div class="stat-card stat-color-${loop.index % 20}">
                        <div class="stat-value">${loop.index + 1}</div>
                        <div class="stat-label">
                            <c:out value="${mandal.name}"/>
                        </div>
                        <div class="small text-muted">
                            <i class="bi bi-geo-alt"></i> <c:out value="${mandal.district}"/>
                        </div>
                    </div>
                </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer class="app-footer" style="background:var(--accent); color:rgba(255,255,255,0.85); padding:1.2rem 0; text-align:center; font-size:0.85rem;">
        &copy; 2025 EGC Administration. Government of Andhra Pradesh. All rights reserved.
    </footer>
</div>
</body>
</html>
