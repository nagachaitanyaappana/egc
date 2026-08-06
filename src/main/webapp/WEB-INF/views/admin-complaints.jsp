<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaints</title>
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
                    <div class="subtitle">Complaints</div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/complaints" class="active">Complaints</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/localities">Localities</a></li>
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
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="section-title"><i class="bi bi-file-earmark-text"></i> All Complaints</h2>
        </div>

        <div class="card form-card mb-4">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/admin/complaints" class="row g-3">
                    <div class="col-md-3">
                        <label for="search" class="form-label">Search</label>
                        <input type="text" class="form-control" id="search" name="search" value="${search != null ? search : ''}" placeholder="ID, type, locality..."/>
                    </div>
                    <div class="col-md-3">
                        <label for="priority" class="form-label">Priority</label>
                        <select class="form-select" id="priority" name="priority">
                            <option value="">All Priorities</option>
                            <option value="LOW" ${selectedPriority == 'LOW' ? 'selected' : ''}>Low</option>
                            <option value="MEDIUM" ${selectedPriority == 'MEDIUM' ? 'selected' : ''}>Medium</option>
                            <option value="HIGH" ${selectedPriority == 'HIGH' ? 'selected' : ''}>High</option>
                            <option value="CRITICAL" ${selectedPriority == 'CRITICAL' ? 'selected' : ''}>Critical</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="type" class="form-label">Complaint Type</label>
                        <select class="form-select" id="type" name="type">
                            <option value="">All Types</option>
                            <c:forEach var="t" items="${complaintTypes}">
                                <option value="${t}" ${selectedType == t ? 'selected' : ''}>${t}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="villageId" class="form-label">Locality</label>
                        <select class="form-select" id="villageId" name="villageId">
                            <option value="">All Localities</option>
                            <c:forEach var="village" items="${villages}">
                                <option value="${village.id}" ${selectedVillageId == village.id ? 'selected' : ''}>${village.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-12 d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary me-2">
                            <i class="bi bi-search"></i> Search
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/complaints" class="btn btn-secondary">
                            <i class="bi bi-arrow-counterclockwise"></i> Reset
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <div class="card form-card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty complaints}">
                        <div class="page-alert page-alert-info show">No complaints found.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Type</th>
                                        <th>Locality</th>
                                        <th>Submitted By</th>
                                        <th>Priority</th>
                                        <th>Created Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="complaint" items="${complaints}">
                                        <tr>
                                            <td>${complaint.id}</td>
                                            <td><c:out value="${complaint.type}"/></td>
                                            <td><c:out value="${complaint.user.village.name}"/></td>
                                            <td><c:out value="${complaint.user.username}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${complaint.priority == 'LOW'}">
                                                        <span class="priority-badge priority-low">Low</span>
                                                    </c:when>
                                                    <c:when test="${complaint.priority == 'MEDIUM'}">
                                                        <span class="priority-badge priority-medium">Medium</span>
                                                    </c:when>
                                                    <c:when test="${complaint.priority == 'HIGH'}">
                                                        <span class="priority-badge priority-high">High</span>
                                                    </c:when>
                                                    <c:when test="${complaint.priority == 'CRITICAL'}">
                                                        <span class="priority-badge priority-critical">Critical</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="priority-badge priority-medium">Medium</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><c:out value="${complaint.createdAt}"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/complaints/${complaint.id}" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-eye"></i> View Details
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
