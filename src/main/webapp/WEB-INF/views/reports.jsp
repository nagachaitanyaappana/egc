<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Overall Reports</title>
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
                    <div class="subtitle">Overall Reports</div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports" class="active">Reports</a></li>
                </ul>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </div>
        </div>
    </header>

    <div class="page-content container mt-4 mb-5">

        <h1 class="section-title mb-4">Overall Reports</h1>

        <div class="row g-4 mb-4" style="display:flex; flex-wrap:wrap;">
            <div class="col-6">
                <div class="stat-card stat-success" onclick="toggleTable('submittedTable')">
                    <div class="stat-icon" style="color:#ffffff;"><i class="bi bi-check-circle-fill"></i></div>
                    <div class="stat-value">${submittedVillages}</div>
                    <div class="stat-label">Total Villages Submitted</div>
                </div>
            </div>
            <div class="col-6">
                <div class="stat-card stat-danger" onclick="toggleTable('pendingTable')">
                    <div class="stat-icon" style="color:#ffffff;"><i class="bi bi-exclamation-circle-fill"></i></div>
                    <div class="stat-value">${pendingVillages}</div>
                    <div class="stat-label">Villages Not Submitted</div>
                </div>
            </div>
        </div>

        <div id="submittedTable" class="detail-table">
            <div class="card form-card mb-3">
                <div class="card-body">
                    <h5 class="section-title"><i class="bi bi-check-circle-fill" style="color:#065f46;"></i> Submitted Villages</h5>
                    <div class="mb-3">
                        <a href="${pageContext.request.contextPath}/admin/reports/export/excel?type=submitted" class="btn btn-secondary btn-sm me-2">
                            <i class="bi bi-file-earmark-excel"></i> Export Excel
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/reports/export/pdf?type=submitted" class="btn btn-secondary btn-sm" style="color:#c81e1e; border-color:#c81e1e;">
                            <i class="bi bi-file-earmark-pdf"></i> Export PDF
                        </a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Village Name</th>
                                    <th>Mandal Name</th>
                                    <th>Submitted Date</th>
                                    <th>Submitted Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${submittedDetails}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td><c:out value="${item.villageName}"/></td>
                                        <td><c:out value="${item.mandalName}"/></td>
                                        <td><c:out value="${item.submittedDate}"/></td>
                                        <td><c:out value="${item.submittedTime}"/></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty submittedDetails}">
                                    <tr>
                                        <td colspan="5" class="text-center">No villages have submitted yet.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="pendingTable" class="detail-table">
            <div class="card form-card mb-3">
                <div class="card-body">
                    <h5 class="section-title"><i class="bi bi-exclamation-circle-fill" style="color:#991b1b;"></i> Pending Villages</h5>
                    <div class="mb-3">
                        <a href="${pageContext.request.contextPath}/admin/reports/export/excel?type=pending" class="btn btn-secondary btn-sm me-2">
                            <i class="bi bi-file-earmark-excel"></i> Export Excel
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/reports/export/pdf?type=pending" class="btn btn-secondary btn-sm" style="color:#c81e1e; border-color:#c81e1e;">
                            <i class="bi bi-file-earmark-pdf"></i> Export PDF
                        </a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Village Name</th>
                                    <th>Mandal Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${pendingDetails}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td><c:out value="${item.villageName}"/></td>
                                        <td><c:out value="${item.mandalName}"/></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty pendingDetails}">
                                    <tr>
                                        <td colspan="3" class="text-center">All villages have submitted.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="app-footer" style="background:var(--accent); color:rgba(255,255,255,0.85); padding:1.2rem 0; text-align:center; font-size:0.85rem;">
        &copy; 2025 EGC Administration. Government of Andhra Pradesh. All rights reserved.
    </footer>
</div>

<script>
    function toggleTable(tableId) {
        const table = document.getElementById(tableId);
        table.classList.toggle('active');
    }
</script>
</body>
</html>
