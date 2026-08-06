<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint Details</title>
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
                    <div class="subtitle">Complaint Details</div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/complaint">Submit Complaint</a></li>
                    <li><a href="${pageContext.request.contextPath}/complaints/my" class="active">My Complaints</a></li>
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
            <h2 class="section-title"><i class="bi bi-file-earmark-text"></i> Complaint Details</h2>
            <a href="${pageContext.request.contextPath}/complaints/my" class="btn btn-secondary btn-sm">&larr; Back to My Complaints</a>
        </div>

        <div class="card form-card mb-4">
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <strong>Complaint ID:</strong> <c:out value="${complaint.id}"/>
                    </div>
                    <div class="col-md-6 text-end">
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
                    </div>
                </div>

                <div class="mb-3">
                    <strong>Complaint Type:</strong> <c:out value="${complaint.type}"/>
                    <c:if test="${not empty complaint.otherType}">
                        <span class="badge bg-secondary ms-2"><c:out value="${complaint.otherType}"/></span>
                    </c:if>
                </div>

                <div class="mb-3">
                    <strong>Locality:</strong> <c:out value="${complaint.user.village.name}"/>
                </div>

                <div class="mb-3">
                    <strong>Submitted By:</strong> <c:out value="${complaint.user.username}"/>
                </div>

                <div class="mb-3">
                    <strong>Description:</strong>
                    <div class="content-preview"><c:out value="${complaint.content}"/></div>
                </div>

                <div class="mb-3">
                    <strong>Created Date:</strong> <c:out value="${complaint.createdAt}"/>
                </div>

                <div class="mb-3">
                    <strong class="text-primary">Images:</strong>
                    <div class="d-flex flex-wrap mt-2">
                        <c:forEach var="photo" items="${complaint.photos}">
                            <img src="${pageContext.request.contextPath}/photos/${photo.id}"
                                 class="photo-thumb" alt="complaint photo"
                                 onclick="openLightbox(this.src)"/>
                        </c:forEach>
                        <c:if test="${empty complaint.photos}">None</c:if>
                    </div>
                </div>
            </div>
        </div>
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
