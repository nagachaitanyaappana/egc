<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Administrative Divisions</title>
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
                    <div class="subtitle">Administrative Divisions</div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/complaints">Complaints</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/localities" class="active">Localities</a></li>
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
        <div class="text-center mb-4">
            <h1 class="section-title">Administrative Divisions</h1>
            <p class="text-muted mb-0">Browse Mandals, Municipalities, Corporation and Nagar Panchayats in Kakinada District.</p>
        </div>

        <div class="row g-3 mb-4" style="display:flex; flex-wrap:wrap;">
            <div class="col-6 col-md-3">
                <div class="stat-card" style="background:#2563eb; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-map"></i></div>
                    <div class="stat-value" style="color:#fff;">${mandalCount}</div>
                    <div class="stat-label" style="color:#fff;">Mandals</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card" style="background:#f97316; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-building"></i></div>
                    <div class="stat-value" style="color:#fff;">${municipalityCount}</div>
                    <div class="stat-label" style="color:#fff;">Municipalities</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card" style="background:#dc2626; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-building-fill"></i></div>
                    <div class="stat-value" style="color:#fff;">${corporationCount}</div>
                    <div class="stat-label" style="color:#fff;">Corporation</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card" style="background:#7c3aed; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-house-fill"></i></div>
                    <div class="stat-value" style="color:#fff;">${nagarPanchayatCount}</div>
                    <div class="stat-label" style="color:#fff;">Nagar Panchayat</div>
                </div>
            </div>
        </div>

        <div class="card form-card mb-4">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/admin/localities" class="row g-3">
                    <div class="col-md-8">
                        <label for="search" class="form-label">Search Divisions or Localities</label>
                        <input type="text" class="form-control" id="search" name="search" value="${search != null ? search : ''}" placeholder="e.g. Karapa or Vakada"/>
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary me-2">
                            <i class="bi bi-search"></i> Search
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/localities" class="btn btn-secondary">
                            <i class="bi bi-arrow-counterclockwise"></i> Reset
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <c:forEach var="type" items="${divisionTypes}">
            <c:set var="divisions" value="${groupedDivisions[type]}"/>
            <c:if test="${not empty divisions}">
                <h3 class="section-title mb-3">
                    <c:choose>
                        <c:when test="${type == 'MANDAL'}">Mandals</c:when>
                        <c:when test="${type == 'MUNICIPALITY'}">Municipalities</c:when>
                        <c:when test="${type == 'CORPORATION'}">Corporation</c:when>
                        <c:when test="${type == 'NAGAR_PANCHAYAT'}">Nagar Panchayat</c:when>
                        <c:otherwise><c:out value="${type}"/></c:otherwise>
                    </c:choose>
                </h3>
                <div class="row g-3 mb-4" style="display:flex; flex-wrap:wrap;">
                    <c:forEach var="division" items="${divisions}" varStatus="loop">
                        <div class="col-md-3 col-sm-4 col-6">
                            <a href="${pageContext.request.contextPath}/admin/division/${division.id}" class="text-decoration-none d-block">
                                <div class="stat-card stat-color-${loop.index % 20}">
                                    <div class="stat-value" style="font-size:1.4rem;">${division.localities.size()}</div>
                                    <div class="stat-label"><c:out value="${division.name}"/></div>
                                    <div class="small">
                                        <span class="badge bg-secondary">${type}</span>
                                    </div>
                                    <div class="small text-muted mt-1">
                                        <c:out value="${divisionStats[division.id]}"/> Complaints
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <footer class="app-footer" style="background:var(--accent); color:rgba(255,255,255,0.85); padding:1.2rem 0; text-align:center; font-size:0.85rem;">
        &copy; 2025 EGC Administration. Government of Andhra Pradesh. All rights reserved.
    </footer>
</div>
</body>
</html>
