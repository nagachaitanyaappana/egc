<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/global.css">
</head>
<body>
    <a href="#main-content" class="skip-link">Skip to main content</a>
<div class="page-wrap">
    <header class="app-header">
        <div class="header-inner">
            <div class="header-left"></div>
            <div class="header-center">
                <div class="brand-center">
                    <div class="brand">Admin Dashboard</div>
                    <div class="subtitle">Welcome, Admin</div>
                </div>
                <ul class="nav-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports"><i class="bi bi-bar-chart"></i> Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/complaints"><i class="bi bi-file-earmark-text"></i> Complaints</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/localities"><i class="bi bi-geo-alt"></i> Localities</a></li>
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

    <div id="main-content" class="page-content container mt-4 mb-5">
        <div class="text-center mb-5">
            <h1 class="display-4 fw-bold" style="margin-top: 2rem; margin-bottom: 1rem;">Welcome, Admin</h1>
            <p class="lead text-muted mb-0" style="font-size: 1.1rem;">
                Government Child Welfare Monitoring System
            </p>
            <p class="text-muted" style="max-width: 600px; margin: 1rem auto 0;">
                Monitor complaints, locality reports and district activity from one place.
            </p>
        </div>

        <div class="row g-4 justify-content-center">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/reports" class="text-decoration-none d-block">
                    <div class="stat-card" style="background:#2563eb; color:#fff; border-top:none; text-align:center; padding:2.5rem;">
                        <i class="bi bi-bar-chart" style="font-size:2.5rem; color:#fff;"></i>
                        <div class="stat-label" style="color:#fff; font-size:1.2rem; margin-top:0.75rem; font-weight:600;">View Reports</div>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/complaints" class="text-decoration-none d-block">
                    <div class="stat-card" style="background:#dc2626; color:#fff; border-top:none; text-align:center; padding:2.5rem;">
                        <i class="bi bi-file-earmark-text" style="font-size:2.5rem; color:#fff;"></i>
                        <div class="stat-label" style="color:#fff; font-size:1.2rem; margin-top:0.75rem; font-weight:600;">View Complaints</div>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/localities" class="text-decoration-none d-block">
                    <div class="stat-card" style="background:#f97316; color:#fff; border-top:none; text-align:center; padding:2.5rem;">
                        <i class="bi bi-geo-alt" style="font-size:2.5rem; color:#fff;"></i>
                        <div class="stat-label" style="color:#fff; font-size:1.2rem; margin-top:0.75rem; font-weight:600;">View Localities</div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <footer class="app-footer" style="background:var(--accent); color:rgba(255,255,255,0.85); padding:1.2rem 0; text-align:center; font-size:0.85rem;">
    </footer>
</div>
    <script>
        function showToast(message, type) {
            type = type || 'info';
            const container = document.getElementById('toastContainer');
            if (!container) return;

            const iconMap = {
                success: 'bi-check-circle-fill',
                error: 'bi-exclamation-triangle-fill',
                warning: 'bi-exclamation-circle-fill',
                info: 'bi-info-circle-fill'
            };

            const toast = document.createElement('div');
            toast.className = 'toast ' + type;
            toast.innerHTML = '<i class="bi ' + iconMap[type] + '"></i>' +
                '<div class="toast-content">' + message + '</div>' +
                '<button class="toast-close" onclick="this.parentElement.remove()">&times;</button>';

            container.appendChild(toast);

            setTimeout(function() {
                toast.classList.add('hiding');
                setTimeout(function() {
                    if (toast.parentElement) {
                        toast.remove();
                    }
                }, 300);
            }, 4000);
        }

        function setLoading(buttonId, isLoading) {
            const btn = document.getElementById(buttonId);
            if (!btn) return;
            if (isLoading) {
                btn.classList.add('loading');
                btn.disabled = true;
            } else {
                btn.classList.remove('loading');
                btn.disabled = false;
            }
        }
    </script>
    <footer class="app-footer">
        Child Welfare Monitoring System<br>
        Government of Andhra Pradesh<br>
        Version 1.0 &copy; 2026
    </footer>
    <div class="toast-container" id="toastContainer"></div>
</body>
</html>