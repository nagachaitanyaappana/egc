<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/global.css">
</head>
<body>
<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <div class="login-title">EGC Administration</div>

            <c:if test="${notFound != null}">
                <div class="alert alert-danger shake">No account found with that email address.</div>
            </c:if>

            <c:if test="${otpSent != null}">
                <div class="alert alert-success">
                    <p class="mb-1">A verification code has been sent to <strong>${email}</strong></p>
                    <p class="mb-0 small mt-1">Please check your email and enter the code below.</p>
                </div>
            </c:if>

            <%-- Step 1: request OTP — posts to /forgot-password --%>
            <c:if test="${step2 == null}">
                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <div class="wrap-input100">
                        <input class="effect-19 input100" id="email" type="email" name="email" placeholder=" " required autofocus>
                        <label for="email">Email Address</label>
                        <span class="focus-border"><i></i></span>
                    </div>
                    <button type="submit" class="login100-form-btn">Send Verification Code</button>
                </form>
            </c:if>

            <%-- Step 2: enter OTP + new password — posts to /reset-password --%>
            <c:if test="${step2 != null}">
                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <input type="hidden" name="email" value="${email}"/>
                    <div class="wrap-input100">
                        <input class="effect-19 input100" id="otp" type="text" name="otp" placeholder=" " required autofocus>
                        <label for="otp">Verification Code</label>
                        <span class="focus-border"><i></i></span>
                    </div>
                    <div class="wrap-input100">
                        <input class="effect-19 input100" id="newPassword" type="password" name="newPassword" placeholder=" " required>
                        <label for="newPassword">New Password</label>
                        <span class="focus-border"><i></i></span>
                    </div>
                    <div class="wrap-input100">
                        <input class="effect-19 input100" id="confirmPassword" type="password" name="confirmPassword" placeholder=" " required>
                        <label for="confirmPassword">Confirm New Password</label>
                        <span class="focus-border"><i></i></span>
                    </div>
                    <button type="submit" class="login100-form-btn">Reset Password</button>
                </form>
            </c:if>

            <div class="login-footer">
                <a href="${pageContext.request.contextPath}/login" class="txt2 hov1">Back to Login</a>
            </div>
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

    // Shake animation for error alerts
    function shakeAlert() {
        $('.alert-danger').each(function() {
            $(this).css({
                'animation': 'shake 0.4s ease-in-out'
            });
        });
    }
    shakeAlert();
</script>
</body>
</html>
