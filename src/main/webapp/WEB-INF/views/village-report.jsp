<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Village Report - ${village.name}</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root {
            --gov-navy: #0d2b5e;
            --gov-blue: #1a4d8f;
            --gov-light: #f4f6fa;
            --gov-border: #dce3f0;
            --gov-accent: #f1c40f;
        }
        body {
            background-color: var(--gov-light);
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        .gov-header {
            background: linear-gradient(90deg, var(--gov-navy), var(--gov-blue));
            color: white;
            padding: 1.2rem 0;
            border-bottom: 4px solid #f1c40f;
        }
        .gov-header .site-title {
            font-weight: 700;
            font-size: 1.35rem;
            margin: 0;
        }
        .gov-header .site-subtitle {
            font-size: 0.9rem;
            opacity: 0.9;
            margin: 0;
        }
        .gov-card {
            border: 4px solid #1a4d8f !important;
            border-radius: 0 !important;
            transition: transform .2s ease, box-shadow .2s ease !important;
            background: white !important;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08) !important;
        }
        .gov-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 30px rgba(13,43,94,.15);
        }
        .gov-card-body {
            padding: 1.5rem 2rem;
        }
        .gov-card .card-title {
            font-weight: 600;
            color: var(--gov-navy);
        }
        .photo-thumb {
            width: 120px; height: 120px; object-fit: cover;
            border: 1px solid #eee; border-radius: 4px; margin: 0 0.5rem 0.5rem 0;
            cursor: pointer;
            transition: transform .2s ease;
        }
        .photo-thumb:hover { transform: scale(1.05); }
        .content-preview { white-space: pre-wrap; background:#f5f5f5; padding:0.5rem; border-left:3px solid var(--gov-blue); }
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
        .gov-footer {
            background: var(--gov-navy);
            color: rgba(255,255,255,.85);
            padding: 1rem 0;
            margin-top: 2rem;
            font-size: 0.85rem;
        }
        .gov-badge {
            background: var(--gov-blue);
            color: white;
            font-size: 0.8rem;
            padding: 0.35rem 0.6rem;
            border-radius: 0;
        }
        .page-header-actions {
            border-bottom: 1px solid var(--gov-border);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
<header class="gov-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <div class="site-title">East Godavari District Administration</div>
            <div class="site-subtitle">Village Report - <c:out value="${village.name}"/></div>
        </div>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</header>

<div class="container mt-4 mb-5">
    <div class="row mb-3">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Home</a></li>
                    <c:choose>
                        <c:when test="${not empty mandalId}">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/mandal/${mandalId}">Mandal</a></li>
                        </c:when>
                    </c:choose>
                    <li class="breadcrumb-item active" aria-current="page">${village.name}</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="page-header-actions d-flex justify-content-between align-items-end">
        <div>
            <h1 class="mb-1" style="font-weight:700; color:var(--gov-navy);">Village Report</h1>
            <p class="text-muted mb-0">
                <i class="bi bi-geo-alt"></i> District: <c:out value="${village.district}"/>
                <span class="gov-badge ms-2">Users: ${userCount}</span>
                <span class="gov-badge ms-2">Complaints: ${complaints.size()}</span>
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

    <c:forEach var="complaint" items="${complaints}" varStatus="loop">
        <div class="gov-card mb-3">
            <div class="gov-card-body text-center">
                <div class="mandal-index mx-auto mb-3" style="width:48px;height:48px;font-size:1.1rem;font-weight:600;">
                    ${loop.index + 1}
                </div>
                <div class="gov-card-title" style="font-size:1.1rem;">
                    <i class="bi bi-person-circle"></i> <c:out value="${complaint.user.username}"/>
                </div>
                <div class="content-preview text-start mt-2" style="width:100%;">
                    <c:out value="${complaint.content}"/>
                </div>
                <div class="d-flex flex-wrap mt-3">
                    <c:forEach var="photo" items="${complaint.photos}">
                        <img src="${pageContext.request.contextPath}/${photo.filePath}"
                             class="photo-thumb" alt="complaint photo"
                             onclick="openLightbox(this.src)"/>
                    </c:forEach>
                    <c:if test="${empty complaint.photos}">None</c:if>
                </div>
                <small class="text-muted mt-2">Submitted on <c:out value="${complaint.createdAt}"/></small>
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

<footer class="gov-footer">
    <div class="container text-center">
        &copy; 2025 East Godavari District Administration. Government of Andhra Pradesh. All rights reserved.
    </div>
</footer>
</body>
</html>
