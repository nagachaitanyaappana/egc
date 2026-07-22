<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint - Village</title>
    <meta charset="UTF-8"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .complaint-container {
            max-width: 900px;
            margin: auto;
            padding: 2rem;
        }
        .large-textarea {
            width: 100%;
            height: 150px;
            resize: vertical;
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
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            overflow: hidden;
            background: #f8f9fa;
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
    </style>
</head>
<body>
<div class="container complaint-container">
    <h2>Submit Your Complaint</h2>

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

<div class="lightbox" id="lightbox" onclick="closeLightbox()">
    <span class="lightbox-close">&times;</span>
    <img id="lightboxImg" src="" alt="Full size"/>
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
