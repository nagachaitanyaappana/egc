<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint - Village</title>
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
                    <div class="subtitle">Public Complaint Submission Portal</div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/complaint" class="active">Complaint</a></li>
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

        <div class="card form-card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="section-title"><i class="bi bi-file-earmark-text"></i> Submit Your Complaint</h2>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary btn-sm">&larr; Back</a>
                </div>

                <div id="formAlert"></div>

                <form id="complaintForm">
                    <div class="complaint-split">
                        <div class="left-panel">
                            <label for="complaintContent">Complaint Details</label>
                            <textarea id="complaintContent" placeholder="Write your complaint here..." style="min-height: 220px;"></textarea>
                        </div>
                        <div class="right-panel">
                            <div class="upload-zone">
                                <i class="bi bi-cloud-upload" style="font-size: 32px; color: var(--text-secondary);"></i>
                                <div class="small text-muted mt-2">Upload Photos</div>
                                <input type="file" class="form-control form-control-sm mt-2" id="photos" name="photos" multiple accept="image/*"/>
                            </div>
                            <div class="preview-grid mt-2" id="previewGrid"></div>
                        </div>
                    </div>

                    <div class="mt-3 d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-send"></i> Submit Complaint
                        </button>
                    </div>
                </form>
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
    const fileInput = document.getElementById('photos');
    const previewGrid = document.getElementById('previewGrid');
    const form = document.getElementById('complaintForm');
    const formAlert = document.getElementById('formAlert');
    let selectedFiles = [];
    let objectUrls = new Set();

    fileInput.addEventListener('change', function () {
        const newFiles = Array.from(this.files).filter(f => f.type.startsWith('image/'));
        const existingNames = new Set(selectedFiles.map(f => f.name + '|' + f.size + '|' + f.lastModified));
        newFiles.forEach(f => {
            if (!existingNames.has(f.name + '|' + f.size + '|' + f.lastModified)) {
                selectedFiles.push(f);
            }
        });
        this.value = '';
        renderPreviews();
    });

    function renderPreviews() {
        previewGrid.innerHTML = '';
        selectedFiles.forEach((file, index) => {
            if (!file.type.startsWith('image/')) return;
            const url = URL.createObjectURL(file);

            const wrapper = document.createElement('div');
            wrapper.className = 'preview-item';
            wrapper.style.cssText = 'position:relative; display:inline-block;';

            const img = document.createElement('img');
            img.src = url;
            img.alt = file.name;
            img.style.cssText = 'width:80px; height:80px; object-fit:cover; border:1px solid var(--border); border-radius:0.5rem;';

            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'remove-btn';
            btn.innerHTML = '&times;';
            btn.title = 'Remove';
            btn.style.cssText = 'position:absolute; top:-6px; right:-6px; background:var(--danger); color:#fff; border:none; border-radius:50%; width:20px; height:20px; line-height:1; cursor:pointer;';
            btn.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                URL.revokeObjectURL(url);
                selectedFiles = selectedFiles.filter((_, i) => i !== index);
                renderPreviews();
            });

            wrapper.addEventListener('click', function (e) {
                if (e.target === btn || btn.contains(e.target)) return;
                openLightbox(url);
            });

            wrapper.appendChild(img);
            wrapper.appendChild(btn);
            previewGrid.appendChild(wrapper);
        });
    }

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

    // Read the CSRF token from the cookie set by Spring Security's CookieCsrfTokenRepository
    function getCsrfToken() {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const parts = cookies[i].trim().split('=');
            if (parts[0] === '_csrf') {
                return decodeURIComponent(parts[1]);
            }
        }
        return null;
    }

    const ctx = "${pageContext.request.contextPath}";
    const jwt = localStorage.getItem("jwt");

    form.addEventListener('submit', function (e) {
        e.preventDefault();

        if (!jwt) {
            formAlert.innerHTML = '<div class="alert alert-danger">Session expired. Please log in again.</div>';
            return;
        }

        const complaintContent = document.getElementById('complaintContent').value.trim();
        if (!complaintContent) {
            formAlert.innerHTML = '<div class="alert alert-danger">Please enter complaint details.</div>';
            return;
        }

        const filesToSubmit = selectedFiles.length > 0 ? selectedFiles : Array.from(fileInput.files);
        if (filesToSubmit.length === 0) {
            formAlert.innerHTML = '<div class="alert alert-danger">Please select at least one photo.</div>';
            return;
        }

        const formData = new FormData();
        formData.append('complaintContent', complaintContent);
        filesToSubmit.forEach(file => formData.append('photos', file));

        const headers = {};
        headers['Authorization'] = 'Bearer ' + jwt;

        const csrfToken = getCsrfToken();
        if (csrfToken) {
            headers['X-CSRF-TOKEN'] = csrfToken;
        }

        fetch(ctx + '/complaint', {
            method: 'POST',
            headers: headers,
            body: formData,
            credentials: 'same-origin'
        })
        .then(res => {
            if (!res.ok) {
                return res.text().then(text => {
                    throw new Error(text || 'Submission failed');
                });
            }
            return res.text();
        })
        .then(html => {
            formAlert.innerHTML = '<div class="alert alert-success">Complaint submitted successfully!</div>';
            form.reset();
            selectedFiles = [];
            previewGrid.innerHTML = '';
            document.getElementById('complaintContent').value = '';
        })
        .catch(err => {
            console.error(err);
            formAlert.innerHTML = '<div class="alert alert-danger">' + (err.message || 'Submission failed. Please try again.') + '</div>';
        });
    });
</script>
</body>
</html>
