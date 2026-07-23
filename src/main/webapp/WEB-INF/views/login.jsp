<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - East Godavari District</title>
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
            min-height: 100vh;
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
        .login-wrapper {
            min-height: calc(100vh - 73px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        .login-box {
            background-color: white;
            border: 1px solid var(--gov-border);
            border-top: 5px solid var(--gov-navy);
            padding: 2rem;
            border-radius: 0;
            box-shadow: 0 4px 18px rgba(13,43,94,.12);
            width: 100%;
            max-width: 400px;
        }
        .login-box h2 {
            margin-top: 0;
            text-align: center;
            color: var(--gov-navy);
            font-weight: 700;
        }
        .form-label {
            font-weight: 600;
            color: var(--gov-navy);
        }
        .form-control {
            border: 1px solid var(--gov-border);
        }
        .form-control:focus {
            border-color: var(--gov-blue);
            box-shadow: 0 0 0 0.2rem rgba(26,77,143,.25);
        }
        .btn-primary {
            background: var(--gov-blue);
            border-color: var(--gov-blue);
        }
        .btn-primary:hover {
            background: var(--gov-navy);
            border-color: var(--gov-navy);
        }
        .gov-footer {
            background: var(--gov-navy);
            color: rgba(255,255,255,.85);
            padding: 1rem 0;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
<header class="gov-header">
    <div class="container">
        <div class="site-title">East Godavari District Administration</div>
        <div class="site-subtitle">Government of Andhra Pradesh</div>
    </div>
</header>

<div class="login-wrapper">
    <div class="login-box">
        <h2>Official Login</h2>
        <div id="errorBox" class="alert alert-danger d-none" role="alert"></div>
        <form id="loginForm">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required autofocus/>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" required/>
                    <button class="btn btn-outline-secondary" type="button" id="togglePassword" aria-label="Show password">
                        <svg id="eyeOpen" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                            <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
                            <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 4.5a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9z"/>
                        </svg>
                        <svg id="eyeClosed" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16" style="display:none;">
                            <path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7.028 7.028 0 0 0-2.79.588l.77.771A5.944 5.944 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.777C13.604 8.594 11.969 10.5 8 10.5c-.727 0-1.42-.122-2.07-.347l-.77.771A7.028 7.028 0 0 0 8 13.5C13 13.5 16 8 16 8s-.939-1.721-2.641-3.262z"/>
                            <path d="M11.297 9.352a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.828 2.828l.822.822zm-4.353-2.06a2.5 2.5 0 0 1 2.828 2.828l-.822-.822a2.5 2.5 0 0 0-2.006-2.006L6.944 7.29z"/>
                            <path d="M3.22 9.222 1.5 11.5l1.06 1.06 1.77-2.06a5.944 5.944 0 0 0 2.06.944l-.823-.823a4.5 4.5 0 0 1-3.067-3.067L1.5 4.5 2.56 3.44l1.66 1.66A7.03 7.03 0 0 1 8 2.5c.79 0 1.547.13 2.254.366l-.823-.823A7.03 7.03 0 0 0 8 1.5C3 1.5 0 8 0 8c.94 1.72 2.641 3.262 4.703 4.222z"/>
                        </svg>
                    </button>
                </div>
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-shield-lock"></i> Secure Login
                </button>
            </div>
        </form>
        <p style="font-size:0.85rem; text-align:center; color:#6c757d; margin-top:1.25rem;">
            Authorized access only. Government of Andhra Pradesh.
        </p>
    </div>
</div>

<footer class="gov-footer">
    <div class="container text-center">
        &copy; 2025 East Godavari District Administration. Government of Andhra Pradesh. All rights reserved.
    </div>
</footer>

<script>
    const ctx = "${pageContext.request.contextPath}";
    document.getElementById("loginForm").addEventListener("submit", async function (e) {
        e.preventDefault();
        const errorBox = document.getElementById("errorBox");
        errorBox.classList.add("d-none");
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;
        try {
            const res = await fetch(ctx + "/api/auth/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ username, password })
            });
            if (!res.ok) {
                const msg = await res.text();
                errorBox.textContent = msg || "Invalid username or password";
                errorBox.classList.remove("d-none");
                return;
            }
            const data = await res.json();
            localStorage.setItem("jwt", data.token);
            let landing = ctx + "/complaint";
            try {
                const payload = JSON.parse(atob(data.token.split(".")[1]));
                if (Array.isArray(payload.roles) && payload.roles.includes("ROLE_ADMIN")) {
                    landing = ctx + "/admin/dashboard";
                }
            } catch (e) { /* default to complaint form */ }
            window.location.href = landing;
        } catch (err) {
            errorBox.textContent = "Login request failed";
            errorBox.classList.remove("d-none");
        }
    });

    const toggleBtn = document.getElementById("togglePassword");
    const pwd = document.getElementById("password");
    const eyeOpen = document.getElementById("eyeOpen");
    const eyeClosed = document.getElementById("eyeClosed");
    toggleBtn.addEventListener("click", function () {
        const isHidden = pwd.type === "password";
        pwd.type = isHidden ? "text" : "password";
        eyeOpen.style.display = isHidden ? "none" : "inline";
        eyeClosed.style.display = isHidden ? "inline" : "none";
    });
</script>
</body>
</html>
