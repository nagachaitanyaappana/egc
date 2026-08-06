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
    <a href="#main-content" class="skip-link">Skip to main content</a>
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
                    <div class="col-md-3">
                        <label for="divisionType" class="form-label">Division Type</label>
                        <select class="form-select" id="divisionType" name="divisionType">
                            <option value="">All Types</option>
                            <c:forEach var="type" items="${divisionTypes}">
                                <option value="${type}" ${selectedDivisionType == type ? 'selected' : ''}>
                                    <c:choose>
                                        <c:when test="${type == 'MANDAL'}">Mandal</c:when>
                                        <c:when test="${type == 'MUNICIPALITY'}">Municipality</c:when>
                                        <c:when test="${type == 'CORPORATION'}">Corporation</c:when>
                                        <c:when test="${type == 'NAGAR_PANCHAYAT'}">Nagar Panchayat</c:when>
                                        <c:otherwise><c:out value="${type}"/></c:otherwise>
                                    </c:choose>
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="status" class="form-label">Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="ALL" ${selectedStatus == 'ALL' ? 'selected' : ''}>All</option>
                            <option value="Active" ${selectedStatus == 'Active' ? 'selected' : ''}>Active</option>
                            <option value="Pending" ${selectedStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="No Reports" ${selectedStatus == 'No Reports' ? 'selected' : ''}>No Reports</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="search" class="form-label">Search</label>
                        <input type="text" class="form-control" id="search" name="search" value="${search != null ? search : ''}" placeholder="Division name or locality name..."/>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary me-2" id="searchLocalitiesBtn" onclick="setLoading('searchLocalitiesBtn', true)">
                            <i class="bi bi-search"></i> Search
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/localities" class="btn btn-secondary">
                            <i class="bi bi-arrow-counterclockwise"></i> Reset
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <c:set var="hasAnyDivisions" value="false"/>
        <c:forEach var="type" items="${divisionTypes}">
            <c:set var="divisions" value="${groupedDivisions[type]}"/>
            <c:if test="${not empty divisions}">
                <c:set var="hasAnyDivisions" value="true"/>
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

        <c:if test="${not hasAnyDivisions}">
            <div class="text-center py-5">
                <i class="bi bi-search" style="font-size:3rem; color:#ccc;"></i>
                <h4 class="mt-3 text-muted">No matching divisions found.</h4>
                <p class="text-muted">Try changing your filters.</p>
                <a href="${pageContext.request.contextPath}/admin/localities" class="btn btn-primary">
                    <i class="bi bi-arrow-counterclockwise"></i> Clear Filters
                </a>
            </div>
        </c:if>
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
