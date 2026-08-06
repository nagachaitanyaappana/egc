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
                    <c:choose>
                        <c:when test="${not empty complaint.photos}">
                            <div class="evidence-gallery">
                                <div class="gallery-preview" onclick="openGalleryModal(0)">
                                    <img id="galleryPreviewImg" src="${pageContext.request.contextPath}/photos/${complaint.photos[0].id}" alt="Preview"/>
                                    <div class="gallery-controls">
                                        <span class="gallery-counter" id="galleryCounter">1 of ${complaint.photos.size()}</span>
                                    </div>
                                </div>
                                <div class="gallery-thumbnails">
                                    <c:forEach var="photo" items="${complaint.photos}" varStatus="loop">
                                        <img src="${pageContext.request.contextPath}/photos/${photo.id}"
                                             class="gallery-thumb ${loop.index == 0 ? 'active' : ''}"
                                             alt="Thumbnail ${loop.index + 1}"
                                             onclick="selectImage(${loop.index}, this)"/>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="gallery-empty">
                                <span class="gallery-empty-icon">🖼️</span>
                                <p>No evidence images uploaded.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <div class="gallery-modal" id="galleryModal">
        <div class="modal-content">
            <div class="modal-image-wrapper">
                <img id="modalImg" src="" alt="Full size"/>
                <div class="modal-toolbar">
                    <button class="modal-toolbar-btn" onclick="zoomIn()" title="Zoom In">
                        <i class="bi bi-zoom-in"></i>
                    </button>
                    <button class="modal-toolbar-btn" onclick="zoomOut()" title="Zoom Out">
                        <i class="bi bi-zoom-out"></i>
                    </button>
                    <button class="modal-toolbar-btn" onclick="resetZoom()" title="Reset Zoom">
                        <i class="bi bi-arrows-angle-contract"></i>
                    </button>
                    <button class="modal-toolbar-btn" onclick="downloadImage()" title="Download">
                        <i class="bi bi-download"></i> Download
                    </button>
                </div>
                <button class="modal-close" onclick="closeGalleryModal()">&times;</button>
                <button class="modal-nav prev" onclick="prevImage()">&#10094;</button>
                <button class="modal-nav next" onclick="nextImage()">&#10095;</button>
            </div>
            <div class="modal-footer">
                <span class="modal-counter" id="modalCounter">1 of 1</span>
                <span class="modal-zoom-info" id="zoomInfo">100%</span>
            </div>
        </div>
    </div>

    <footer class="app-footer" style="background:var(--accent); color:rgba(255,255,255,0.85); padding:1.2rem 0; text-align:center; font-size:0.85rem;">
        &copy; 2025 EGC Administration. Government of Andhra Pradesh. All rights reserved.
    </footer>
</div>

<script>
    const photoUrls = [
        <c:forEach var="photo" items="${complaint.photos}" varStatus="loop">
            "${pageContext.request.contextPath}/photos/${photo.id}"<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];
    let currentIndex = 0;
    let currentZoom = 1;

    function selectImage(index, thumb) {
        currentIndex = index;
        currentZoom = 1;
        const preview = document.getElementById('galleryPreviewImg');
        preview.style.transform = 'scale(1)';
        preview.src = photoUrls[index];
        document.querySelectorAll('.gallery-thumb').forEach(t => t.classList.remove('active'));
        if (thumb) thumb.classList.add('active');
        document.getElementById('galleryCounter').textContent = (index + 1) + ' of ' + photoUrls.length;
    }

    function openGalleryModal(index) {
        currentIndex = index;
        currentZoom = 1;
        const modal = document.getElementById('galleryModal');
        const img = document.getElementById('modalImg');
        img.src = photoUrls[index];
        img.style.transform = 'scale(1)';
        document.getElementById('modalCounter').textContent = (index + 1) + ' of ' + photoUrls.length;
        document.getElementById('zoomInfo').textContent = '100%';
        modal.classList.add('active');
        document.addEventListener('keydown', handleKeyDown);
    }

    function closeGalleryModal() {
        document.getElementById('galleryModal').classList.remove('active');
        document.removeEventListener('keydown', handleKeyDown);
        resetZoom();
    }

    function prevImage() {
        if (photoUrls.length === 0) return;
        currentIndex = (currentIndex - 1 + photoUrls.length) % photoUrls.length;
        currentZoom = 1;
        updateModalImage();
    }

    function nextImage() {
        if (photoUrls.length === 0) return;
        currentIndex = (currentIndex + 1) % photoUrls.length;
        currentZoom = 1;
        updateModalImage();
    }

    function updateModalImage() {
        const img = document.getElementById('modalImg');
        img.style.opacity = '0';
        setTimeout(() => {
            img.src = photoUrls[currentIndex];
            img.style.transform = 'scale(1)';
            img.style.opacity = '1';
        }, 200);
        document.getElementById('modalCounter').textContent = (currentIndex + 1) + ' of ' + photoUrls.length;
        document.getElementById('zoomInfo').textContent = '100%';
    }

    function handleKeyDown(e) {
        const modal = document.getElementById('galleryModal');
        if (!modal.classList.contains('active')) return;
        if (e.key === 'Escape') closeGalleryModal();
        if (e.key === 'ArrowLeft') prevImage();
        if (e.key === 'ArrowRight') nextImage();
    }

    function zoomIn() {
        currentZoom = Math.min(currentZoom + 0.25, 3);
        applyZoom();
    }

    function zoomOut() {
        currentZoom = Math.max(currentZoom - 0.25, 0.5);
        applyZoom();
    }

    function resetZoom() {
        currentZoom = 1;
        applyZoom();
    }

    function applyZoom() {
        const img = document.getElementById('modalImg');
        img.style.transform = 'scale(' + currentZoom + ')';
        document.getElementById('zoomInfo').textContent = Math.round(currentZoom * 100) + '%';
    }

    function downloadImage() {
        const url = photoUrls[currentIndex];
        fetch(url)
            .then(res => res.blob())
            .then(blob => {
                const blobUrl = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = blobUrl;
                a.download = 'evidence_' + (currentIndex + 1) + '.jpg';
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                URL.revokeObjectURL(blobUrl);
            })
            .catch(() => {
                window.open(url, '_blank');
            });
    }
</script>
</body>
</html>
