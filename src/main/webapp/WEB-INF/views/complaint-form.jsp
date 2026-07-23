<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint - Village</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root {
            --gov-navy: #0d2b5e;
            --gov-blue: #1a4d8f;
            --gov-light: #f4f6fa;
            --gov-border: #dce3f0;
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
        .complaint-container {
            max-width: 900px;
            margin: auto;
            padding: 2rem;
        }
        .large-textarea {
            width: 100%;
            height: 150px;
            resize: vertical;
            border: 1px solid var(--gov-border);
        }
        .large-textarea:focus {
            border-color: var(--gov-blue);
            box-shadow: 0 0 0 0.2rem rgba(26,77,143,.25);
        }
        .gov-card {
            border: 4px solid #1a4d8f !important;
            border-radius: 0 !important;
            transition: transform .2s ease, box-shadow .2s ease !important;
            background: white !important;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08) !important;
        }
        .gov-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(13,43,94,.15);
        }
        .gov-card-body {
            padding: 1.5rem 2rem;
        }
        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
            gap: 0.75rem;
            margin-top: 0.5rem;
        }
        .preview-item {
            position: relative;
            width: 100%;
            padding-top: 100%;
            border: 1px solid var(--gov-border);
            border-radius: 0.375rem;
            overflow: hidden;
            background: #fff;
            cursor: pointer;
        }
        .preview-item img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .preview-item .remove-btn {
            position: absolute;
            top: 4px;
            right: 4px;
            background: #dc3545;
            color: #fff;
            border: none;
            border-radius: 50%;
            width: 22px;
            height: 22px;
            line-height: 18px;
            text-align: center;
            font-size: 14px;
            cursor: pointer;
            padding: 0;
        }
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
        .form-label {
            font-weight: 600;
            color: var(--gov-navy);
        }
        .btn-primary {
            background: var(--gov-blue);
            border-color: var(--gov-blue);
        }
        .btn-primary:hover {
            background: var(--gov-navy);
            border-color: var(--gov-navy);
        }
    </style>
</head>
<body>
<header class="gov-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <div class="site-title">East Godavari District Administration</div>
            <div class="site-subtitle">Public Complaint Submission Portal</div>
        </div>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</header>

<div class="container complaint-container">
    <div class="row mb-3">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/login">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Submit Complaint</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="gov-card mb-4">
        <div class="gov-card-body">
            <h2 class="mb-3" style="font-weight:700; color:var(--gov-navy);">
                <i class="bi bi-file-earmark-text"></i> Submit Your Complaint
            </h2>

            <div id="formAlert"></div>

            <form id="complaintForm">
                <div class="row g-3">
                    <div class="col-12">
                        <div class="mb-3">
                            <label for="complaintContent" class="form-label">Complaint Details</label>
                            <textarea class="form-control large-textarea" id="complaintContent" name="complaintContent"></textarea>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="mb-3">
                            <label for="photos" class="form-label">Upload Supporting Photos (multiple)</label>
                            <input type="file" class="form-control" id="photos" name="photos" multiple accept="image/*"/>
                        </div>
                        <div class="preview-grid" id="previewGrid"></div>
                    </div>

                    <div class="col-12 d-grid">
                        <button type="submit" class="btn btn-primary">Submit Complaint</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="lightbox" id="lightbox" onclick="closeLightbox()">
    <span class="lightbox-close">&times;</span>
    <img id="lightboxImg" src="" alt="Full size"/>
</div>

<footer class="gov-footer">
    <div class="container text-center">
        &copy; 2025 East Godavari District Administration. Government of Andhra Pradesh. All rights reserved.
    </div>
</footer>

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

            const img = document.createElement('img');
            img.src = url;
            img.alt = file.name;

            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'remove-btn';
            btn.innerHTML = '&times;';
            btn.title = 'Remove';
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

    form.addEventListener('submit', function (e) {
        e.preventDefault();

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

        fetch('${pageContext.request.contextPath}/complaint', {
            method: 'POST',
            body: formData,
            credentials: 'same-origin'
        })
        .then(res => res.text())
        .then(html => {
            formAlert.innerHTML = '<div class="alert alert-success">Complaint submitted successfully!</div>';
            form.reset();
            selectedFiles = [];
            previewGrid.innerHTML = '';
            document.getElementById('complaintContent').value = '';
        })
        .catch(err => {
            console.error(err);
            formAlert.innerHTML = '<div class="alert alert-danger">Submission failed. Please try again.</div>';
        });
    });
</script>
</body>
</html>
