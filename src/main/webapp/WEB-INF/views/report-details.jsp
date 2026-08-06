<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:out value="${pageTitle}"/></title>
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
                    <div class="subtitle"><c:out value="${pageTitle}"/></div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports" class="active">Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/complaints">Complaints</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/localities">Localities</a></li>
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
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="section-title"><c:out value="${pageTitle}"/></h2>
            <div>
                <a href="${pageContext.request.contextPath}/admin/reports/export/details/excel?type=${reportType}&division=${selectedDivisionId != null ? selectedDivisionId : ''}&locality=${selectedVillageId != null ? selectedVillageId : ''}&complaintType=${selectedType != null ? selectedType : ''}&priority=${selectedPriority != null ? selectedPriority : ''}&dateFrom=${dateFrom != null ? dateFrom : ''}&dateTo=${dateTo != null ? dateTo : ''}" class="btn btn-success btn-sm me-2">
                    <i class="bi bi-file-earmark-excel"></i> Export Excel
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports/export/details/pdf?type=${reportType}&division=${selectedDivisionId != null ? selectedDivisionId : ''}&locality=${selectedVillageId != null ? selectedVillageId : ''}&complaintType=${selectedType != null ? selectedType : ''}&priority=${selectedPriority != null ? selectedPriority : ''}&dateFrom=${dateFrom != null ? dateFrom : ''}&dateTo=${dateTo != null ? dateTo : ''}" class="btn btn-danger btn-sm me-2">
                    <i class="bi bi-file-earmark-pdf"></i> Export PDF
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="btn btn-secondary btn-sm">
                    <i class="bi bi-arrow-left"></i> Back
                </a>
            </div>
        </div>

        <div class="card form-card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty complaints}">
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Complaint ID</th>
                                        <th>Complaint Type</th>
                                        <th>Locality Name</th>
                                        <th>Mandal Name</th>
                                        <th>Submitted By</th>
                                        <th>Priority</th>
                                        <th>Created Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="complaint" items="${complaints}">
                                        <tr>
                                            <td>${complaint.id}</td>
                                            <td><c:out value="${complaint.type}"/></td>
                                            <td>
                                                <c:out value="${complaint.user.village.name}"/>
                                            </td>
                                            <td>
                                                <c:out value="${complaint.user.village.mandal != null ? complaint.user.village.mandal.name : 'N/A'}"/>
                                            </td>
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
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>

                    <c:when test="${not empty pendingVillages}">
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Locality Name</th>
                                        <th>Mandal Name</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="village" items="${pendingVillages}">
                                        <tr>
                                            <td><c:out value="${village.name}"/></td>
                                            <td>
                                                <c:out value="${village.mandal != null ? village.mandal.name : 'N/A'}"/>
                                            </td>
                                            <td>
                                                <span class="locality-badge locality-no-reports">No Reports</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>

                    <c:when test="${not empty pendingLocalities}">
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Locality Name</th>
                                        <th>Mandal Name</th>
                                        <th>Last Report Date</th>
                                        <th>Days Since Last Report</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${pendingLocalities}">
                                        <c:set var="village" value="${row.village}"/>
                                        <c:set var="status" value="${row.status}"/>
                                        <tr>
                                            <td><c:out value="${village.name}"/></td>
                                            <td>
                                                <c:out value="${village.mandal != null ? village.mandal.name : 'N/A'}"/>
                                            </td>
                                            <td>
                                                <c:out value="${row.lastReportDate != null ? row.lastReportDate : 'N/A'}"/>
                                            </td>
                                            <td>
                                                <c:out value="${row.daysSince != null ? row.daysSince : 'N/A'}"/>
                                            </td>
                                            <td>
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
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="page-alert page-alert-info show">No data available for this report.</div>
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
