<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Villages - ${mandal.name}</title>
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
                    <div class="subtitle">Village Directory - <c:out value="${mandal.name}"/></div>
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

        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h1 class="section-title">Villages in ${mandal.name}</h1>
                <p class="text-muted mb-0">
                    <i class="bi bi-geo-alt"></i> District: <c:out value="${mandal.district}"/>
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary btn-sm">&larr; Back to Mandals</a>
        </div>

        <div class="row mb-4">
            <div class="col-12">
                <h3 class="section-title"><i class="bi bi-check-circle-fill" style="color:#2563eb;"></i> Submitted Villages</h3>
                <c:choose>
                    <c:when test="${empty submitted}">
                        <div class="page-alert page-alert-error show">No villages have submitted yet.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3" style="display:flex; flex-wrap:wrap;">
                            <c:forEach var="village" items="${submitted}" varStatus="loop">
                                <c:set var="lastSubmission" value="${lastSubmissionMap[village.id]}"/>
                                <div class="col-md-3 col-sm-4 col-6">
                                    <a href="${pageContext.request.contextPath}/admin/village/${village.id}" class="text-decoration-none d-block">
                                         <div class="stat-card stat-color-${loop.index % 20}">
                                             <div class="stat-value" style="font-size:1.4rem;">${loop.index + 1}</div>
                                             <div class="stat-label"><c:out value="${village.name}"/></div>
                                             <div class="small"><i class="bi bi-geo-alt"></i> ${village.district}</div>
                                             <c:if test="${not empty lastSubmission}">
                                                 <c:set var="daysDiff" value="${T(java.time.temporal.ChronoUnit.DAYS).between(lastSubmission.toLocalDate(), T(java.time.LocalDate).now())}"/>
                                                 <c:choose>
                                                     <c:when test="${daysDiff <= 14}">
                                                         <span class="locality-badge locality-active">Active</span>
                                                     </c:when>
                                                     <c:otherwise>
                                                         <span class="locality-badge locality-pending">Pending</span>
                                                     </c:otherwise>
                                                 </c:choose>
                                             </c:if>
                                         </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <h3 class="section-title"><i class="bi bi-exclamation-circle-fill" style="color:#dc2626;"></i> Not Submitted Villages</h3>
                <c:choose>
                    <c:when test="${empty notSubmitted}">
                        <div class="page-alert page-alert-success show">All villages have submitted.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="village" items="${notSubmitted}" varStatus="loop">
                                <div class="col-md-3 col-sm-4 col-6">
                                    <a href="${pageContext.request.contextPath}/admin/village/${village.id}" class="text-decoration-none d-block">
                                         <div class="stat-card stat-color-${loop.index % 20}">
                                             <div class="stat-value" style="font-size:1.4rem;">${loop.index + 1}</div>
                                             <div class="stat-label"><c:out value="${village.name}"/></div>
                                             <div class="small"><i class="bi bi-geo-alt"></i> ${village.district}</div>
                                             <span class="locality-badge locality-no-reports">No Reports</span>
                                         </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <footer class="app-footer" style="background:var(--accent); color:rgba(255,255,255,0.85); padding:1.2rem 0; text-align:center; font-size:0.85rem;">
        &copy; 2025 EGC Administration. Government of Andhra Pradesh. All rights reserved.
    </footer>
</div>
</body>
</html>
