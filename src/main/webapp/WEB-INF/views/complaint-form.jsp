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
            max-width: 800px;
            margin: auto;
            padding: 2rem;
        }
        .large-textarea {
            width: 100%;
            height: 150px;
            resize: vertical;
        }
    </style>
</head>
<body>
<div class="container complaint-container">
    <h2>Submit Your Complaint</h2>

    <c:if test="${not empty success}">
        <div class="alert alert-success">Complaint submitted successfully!</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/complaint" method="post" enctype="multipart/form-data">
        <div class="row g-3">
            <div class="col-12">
                <div class="mb-3">
                    <label for="complaintContent" class="form-label">Complaint Details</label>
                    <textarea class="form-control large-textarea" id="complaintContent" name="complaintContent" required></textarea>
                </div>
            </div>

            <div class="col-12">
                <div class="mb-3">
                    <label for="photos" class="form-label">Upload Supporting Photos (multiple)</label>
                    <input type="file" class="form-control" id="photos" name="photos" multiple accept="image/*" required/>
                </div>
            </div>

            <div class="col-12 d-grid">
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
