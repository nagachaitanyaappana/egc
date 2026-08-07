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
    <a href="#main-content" class="skip-link">Skip to main content</a>
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
                                                  <c:set var="daysDiff" value="${daysSinceMap[village.id]}"/>
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
    </footer>
</div>
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
    <footer class="app-footer">
        Child Welfare Monitoring System<br>
        Government of Andhra Pradesh<br>
        Version 1.0 &copy; 2026
    </footer>
    <div class="toast-container" id="toastContainer"></div>
</body>
</html>