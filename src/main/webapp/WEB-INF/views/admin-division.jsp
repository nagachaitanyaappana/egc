<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:out value="${division.name}"/></title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/global.css">
</head>
<body>
    <a href="#main-content" class="skip-link">Skip to main content</a>
<div class="page-wrap">
    <header class="app-header">
        <div class="header-inner">
            <div class="header-left"></div>
            <div class="header-center">
                <div class="brand-center">
                    <div class="brand">EGC Admin</div>
                    <div class="subtitle"><c:out value="${division.name}"/></div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports"><i class="bi bi-bar-chart"></i> Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/complaints"><i class="bi bi-file-earmark-text"></i> Complaints</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/localities" class="active"><i class="bi bi-geo-alt"></i> Localities</a></li>
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

    <div id="main-content" class="page-content container mt-4 mb-5">
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/localities"><i class="bi bi-geo-alt"></i> Localities</a></li>
                <li class="breadcrumb-item active" aria-current="page"><c:out value="${division.name}"/></li>
            </ol>
        </nav>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h1 class="section-title"><c:out value="${division.name}"/></h1>
                <p class="text-muted mb-0">
                    <span class="badge bg-secondary">${division.type}</span>
                    <span class="ms-2 text-muted">Division</span>
                </p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/division/${division.id}/export/excel" class="btn btn-success btn-sm me-2">
                    <i class="bi bi-file-earmark-excel"></i> Export Excel
                </a>
                <a href="${pageContext.request.contextPath}/admin/division/${division.id}/export/pdf" class="btn btn-danger btn-sm me-2">
                    <i class="bi bi-file-earmark-pdf"></i> Export PDF
                </a>
                <a href="${pageContext.request.contextPath}/admin/localities" class="btn btn-secondary btn-sm">&larr; Back</a>
            </div>
        </div>

        <div class="row g-4 mb-4" style="display:flex; flex-wrap:wrap;">
            <div class="col-6">
                <div class="stat-card" style="background:#2563eb; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-geo-alt"></i></div>
                    <div class="stat-value" style="color:#fff;">${totalLocalities}</div>
                    <div class="stat-label" style="color:#fff;">
                        <c:choose>
                            <c:when test="${division.type == 'MANDAL'}">Total Villages</c:when>
                            <c:when test="${division.type == 'MUNICIPALITY' || division.type == 'CORPORATION' || division.type == 'NAGAR_PANCHAYAT'}">Total Wards</c:when>
                            <c:otherwise>Total Localities</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div class="stat-card" style="background:#f97316; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-file-earmark-text"></i></div>
                    <div class="stat-value" style="color:#fff;">${totalComplaints}</div>
                    <div class="stat-label" style="color:#fff;">Total Complaints</div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4" style="display:flex; flex-wrap:wrap;">
            <div class="col-6">
                <div class="stat-card" style="background:#dc2626; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-exclamation-circle-fill"></i></div>
                    <div class="stat-value" style="color:#fff;">${pendingComplaints}</div>
                    <div class="stat-label" style="color:#fff;">Pending Complaints</div>
                </div>
            </div>
            <div class="col-6">
                <div class="stat-card" style="background:#7f1d1d; color:#fff; border-top:none;">
                    <div class="stat-icon" style="color:#fff;"><i class="bi bi-exclamation-octagon-fill"></i></div>
                    <div class="stat-value" style="color:#fff;">${criticalComplaints}</div>
                    <div class="stat-label" style="color:#fff;">Critical Complaints</div>
                </div>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <h3 class="section-title">
                    <c:choose>
                        <c:when test="${division.type == 'MANDAL'}">Villages</c:when>
                        <c:when test="${division.type == 'MUNICIPALITY' || division.type == 'CORPORATION' || division.type == 'NAGAR_PANCHAYAT'}">Wards</c:when>
                        <c:otherwise>Localities</c:otherwise>
                    </c:choose>
                </h3>
                <c:choose>
                    <c:when test="${empty localities}">
                        <div class="empty-state">
                                <span class="empty-state-icon"><i class="bi bi-geo-alt"></i></span>
                                <div class="empty-state-title">No localities found</div>
                                <div class="empty-state-text">This division does not have any localities registered yet.</div>
                            </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3" style="display:flex; flex-wrap:wrap;">
                            <c:forEach var="locality" items="${localities}" varStatus="loop">
                                <c:set var="lastSubmission" value="${lastSubmissionMap[locality.id]}"/>
                                <c:set var="status" value="${statusMap[locality.id]}"/>
                                <c:set var="locComplaints" value="${complaintCountMap[locality.id]}"/>
                                <div class="col-md-3 col-sm-4 col-6">
                                    <a href="${pageContext.request.contextPath}/admin/village/${locality.id}" class="text-decoration-none d-block">
                                        <div class="stat-card stat-color-${loop.index % 20}">
                                            <div class="stat-value" style="font-size:1.4rem;">${loop.index + 1}</div>
                                            <div class="stat-label"><c:out value="${locality.name}"/></div>
                                            <c:if test="${not empty lastSubmission}">
                                                <div class="small text-muted">
                                                    <i class="bi bi-clock"></i> <c:out value="${lastSubmission}"/>
                                                </div>
                                            </c:if>
                                            <c:if test="${empty lastSubmission}">
                                                <div class="small text-muted">No submissions yet</div>
                                            </c:if>
                                            <div class="small mt-1">
                                                <c:choose>
                                                    <c:when test="${status == 'Active'}">
                                                        <span class="locality-badge locality-active">Active</span>
                                                    </c:when>
                                                    <c:when test="${status == 'Pending'}">
                                                        <span class="locality-badge locality-pending">Pending</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="locality-badge locality-no-reports">No Reports</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span class="ms-2 text-muted">${locComplaints} complaints</span>
                                            </div>
                                            <div class="small mt-1">
                                                <span class="btn btn-sm btn-outline-primary" style="font-size:0.75rem; padding:0.25rem 0.5rem;">View Complaints</span>
                                            </div>
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
        EGC - Child Welfare Monitoring System<br>Government of Andhra Pradesh<br>Version 1.0 EGC - Child Welfare Monitoring System<br>Government of Andhra Pradesh<br>Version 1.0 &copy; 2025 EGC Administration. Government of Andhra Pradesh. All rights reserved.copy; 2026copy; 2026
    </footer>
</div>
    <div class="toast-container" id="toastContainer"></div>
    <script>
        function showToast(message, type) {
            type = type || 'info';
            const container = document.getElementById('toastContainer');
            if (!container) return;

            const iconMap = {
                success: 'bi-check-circle-fill',
                error: 'bi-exclamation-triangle-fill',
                warning: 'bi-exclamation-circle-fill',
                info: 'bi-info-circle-fill'
            };

            const toast = document.createElement('div');
            toast.className = 'toast ' + type;
            toast.innerHTML = '<i class="bi ' + iconMap[type] + '"></i>' +
                '<div class="toast-content">' + message + '</div>' +
                '<button class="toast-close" onclick="this.parentElement.remove()">&times;</button>';

            container.appendChild(toast);

            setTimeout(function() {
                toast.classList.add('hiding');
                setTimeout(function() {
                    if (toast.parentElement) {
                        toast.remove();
                    }
                }, 300);
            }, 4000);
        }

        function setLoading(buttonId, isLoading) {
            const btn = document.getElementById(buttonId);
            if (!btn) return;
            if (isLoading) {
                btn.classList.add('loading');
                btn.disabled = true;
            } else {
                btn.classList.remove('loading');
                btn.disabled = false;
            }
        }
    </script>
</body>
</html>
