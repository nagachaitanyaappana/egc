<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Village Report - ${village.name}</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"/>
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
                    <div class="subtitle">Village Report - <c:out value="${village.name}"/></div>
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

        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h1 class="section-title">Village Report</h1>
                <p class="text-muted mb-0">
                    <i class="bi bi-geo-alt"></i> District: <c:out value="${village.district}"/>
                    <span class="ms-2" style="background:var(--primary); color:#fff; font-size:0.8rem; padding:0.35rem 0.6rem; border-radius:0.25rem; font-weight:500;">Users: ${userCount}</span>
                    <span class="ms-2" style="background:var(--accent); color:#fff; font-size:0.8rem; padding:0.35rem 0.6rem; border-radius:0.25rem; font-weight:500;">Submissions: ${complaints.size()}</span>
                </p>
            </div>
            <div>
                <c:choose>
                    <c:when test="${not empty mandalId}">
                        <a href="${pageContext.request.contextPath}/admin/mandal/${mandalId}" class="btn btn-secondary btn-sm">&larr; Back</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary btn-sm">&larr; Back</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:forEach var="complaint" items="${complaints}">
            <div class="card form-card mb-3">
                <div class="card-body">
                    <h5 class="section-title">
                        <i class="bi bi-person-circle"></i> <c:out value="${complaint.user.username}"/>
                    </h5>
                    <p class="text-muted mb-2">
                        <strong>Submission:</strong>
                        <div class="content-preview"><c:out value="${complaint.content}"/></div>
                    </p>
                    <p class="small text-muted mb-2">Submitted on <c:out value="${complaint.createdAt}"/></p>
                    <div>
                        <strong class="text-primary">Photos:</strong>
                        <div class="d-flex flex-wrap mt-2">
                            <c:forEach var="photo" items="${complaint.photos}">
                                <img src="${pageContext.request.contextPath}/photos/${photo.id}"
                                     class="photo-thumb" alt="submission photo"
                                     onclick="openLightbox(this.src)"/>
                            </c:forEach>
                            <c:if test="${empty complaint.photos}">None</c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty complaints}">
            <div class="alert alert-info">No submissions yet.</div>
        </c:if>
    </div>

    <div class="lightbox" id="lightbox" onclick="closeLightbox()">
        <span class="lightbox-close">&times;</span>
        <img id="lightboxImg" src="" alt="Full size"/>
    </div>

    <footer class="app-footer" style="background:var(--accent); color:rgba(255,255,255,0.85); padding:1.2rem 0; text-align:center; font-size:0.85rem;">
        &copy; 2025 EGC Administration. Government of Andhra Pradesh. All rights reserved.
    </footer>
</div>

<script>
    function openLightbox(src) {
        const lightbox = document.getElementById('lightbox');
        const lightboxImg = document.getElementById('lightboxImg');
        lightboxImg.src = src;
        lightbox.classList.add('active');
    }

    function closeLightbox() {
        const lightbox = document.getElementById('lightbox');
        lightbox.classList.remove('active');
    }
</script>
</body>
</html>
