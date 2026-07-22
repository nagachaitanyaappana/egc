<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Village Report - ${village.name}</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .photo-thumb {
            width: 120px; height: 120px; object-fit: cover;
            border: 1px solid #eee; border-radius: 4px; margin: 0 0.5rem 0.5rem 0;
            cursor: pointer;
            transition: transform .2s ease;
        }
        .photo-thumb:hover { transform: scale(1.05); }
        .content-preview { white-space: pre-wrap; background:#f5f5f5; padding:0.5rem; }
        .lightbox {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.85);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        .lightbox.active { display: flex; }
        .lightbox img {
            max-width: 90%;
            max-height: 90%;
            border-radius: 4px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.5);
        }
        .lightbox-close {
            position: absolute;
            top: 20px;
            right: 30px;
            color: #fff;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
            line-height: 1;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <c:choose>
    <c:when test="${not empty mandalId}">
        <a href="${pageContext.request.contextPath}/admin/mandal/${mandalId}" class="btn btn-link">&larr; Back</a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-link">&larr; Back</a>
    </c:otherwise>
</c:choose>

    <h1>Village Report: <c:out value="${village.name}"/></h1>
    <p class="text-muted">
        District: <c:out value="${village.district}"/> &nbsp;|&nbsp; Registered Users: ${userCount}
        &nbsp;|&nbsp; Complaints: ${complaints.size()}
    </p>

    <c:forEach var="complaint" items="${complaints}">
        <div class="card mb-3">
            <div class="card-body">
                <h5 class="card-title">From <c:out value="${complaint.user.username}"/></h5>
                <p class="card-text">
                    <strong>Complaint:</strong>
                    <div class="content-preview"><c:out value="${complaint.content}"/></div>
                </p>
                <p class="card-text">
                    <small class="text-muted">Submitted on <c:out value="${complaint.createdAt}"/></small>
                </p>
                <div>
                    <strong>Photos:</strong>
                    <div class="d-flex flex-wrap mt-2">
                        <c:forEach var="photo" items="${complaint.photos}">
                            <img src="${pageContext.request.contextPath}/${photo.filePath}"
                                 class="photo-thumb" alt="complaint photo"
                                 onclick="openLightbox(this.src)"/>
                        </c:forEach>
                        <c:if test="${empty complaint.photos}">None</c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty complaints}">
        <div class="alert alert-info">No complaints submitted by this village yet.</div>
    </c:if>
</div>

<div class="lightbox" id="lightbox" onclick="closeLightbox()">
    <span class="lightbox-close">&times;</span>
    <img id="lightboxImg" src="" alt="Full size"/>
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
