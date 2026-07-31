<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"/>
</head>
<body>

<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <form class="login100-form" id="loginForm">
                <span class="login100-form-title">
                    EGC Administration
                </span>

                <div id="errorBox" class="login-error-box" role="alert">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <span id="errorText"></span>
                </div>

                <div class="wrap-input100">
                    <input class="effect-19 input100" id="username" type="text" placeholder="" autocomplete="off" required autofocus>
                    <label for="username">Username</label>
                    <span class="focus-border">
                        <i></i>
                    </span>
                </div>

                <div class="wrap-input100">
                    <input class="effect-19 input100" id="password" type="password" placeholder="" autocomplete="off" required>
                    <label for="password">Password</label>
                    <span class="focus-border">
                        <i></i>
                    </span>
                </div>

                <div class="show-pass txt1">
                    <input type="checkbox" id="show-pass" onclick="myFunction()"> Show Password
                </div>

                <div class="container-login100-form-btn m-t-20">
                    <button type="submit" class="login100-form-btn">Sign in</button>
                </div>

                <div class="text-center p-t-25 p-b-5">
                    <span class="txt1">Forgot</span>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="txt2 hov1">Username / Password</a><span class="txt1">?</span>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script>
    $(window).ready(function(){
        $(".wrap-input100 .input100").focusout(function() {
            if($(this).val() != "") {
                $(this).addClass("has-content");
            }
            else {
                $(this).removeClass("has-content");
            }
        })
    });

    function myFunction() {
        var x = document.getElementById("password");
        if (x.type === "password") {
            x.type = "text";
        } else {
            x.type = "password";
        }
    }

    const ctx = "${pageContext.request.contextPath}";
    document.getElementById("loginForm").addEventListener("submit", async function (e) {
        e.preventDefault();
        const errorBox = document.getElementById("errorBox");
        const errorText = document.getElementById("errorText");
        errorBox.classList.remove("show");
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;
        try {
            const res = await fetch(ctx + "/api/auth/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ username, password })
            });
            if (!res.ok) {
                const text = await res.text();
                let msg = text;
                try {
                    const json = JSON.parse(text);
                    msg = json.error || json.message || text;
                } catch (e) {}
                errorText.textContent = msg || "Invalid username or password";
                errorBox.classList.add("show");
                document.querySelector('.login100-form').classList.add('has-error');
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
            } catch (e) {}
            window.location.href = landing;
        } catch (err) {
            errorText.textContent = "Login request failed";
            errorBox.classList.add("show");
            document.querySelector('.login100-form').classList.add('has-error');
        }
    });

    (function handleResetToken() {
        const params = new URLSearchParams(window.location.search);
        const token = params.get("token");
        if (!token) return;
        localStorage.setItem("jwt", token);
        let landing = ctx + "/complaint";
        try {
            const payload = JSON.parse(atob(token.split(".")[1]));
            if (Array.isArray(payload.roles) && payload.roles.includes("ROLE_ADMIN")) {
                landing = ctx + "/admin/dashboard";
            }
        } catch (e) {}
        window.location.replace(landing);
    })();
</script>
</body>
</html>
