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
                <div class="page-alert page-alert-error show">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <span>No account found with that username or email.</span>
                </div>
            </c:if>

            <c:if test="${otpSent != null}">
                <div class="page-alert page-alert-success show">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>A verification code has been sent to <strong>${maskedEmail}</strong>. Please check your email and enter the code below.</span>
                </div>
            </c:if>

            <c:if test="${error != null}">
                <div class="page-alert page-alert-error show">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <%-- Step 1: request OTP --%>
            <c:if test="${step2 == null}">
                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <div class="wrap-input100">
                        <input class="effect-19 input100" id="loginIdentifier" type="text" name="loginIdentifier" placeholder=" " required autofocus>
                        <label for="loginIdentifier">Username or Email</label>
                        <span class="focus-border"><i></i></span>
                    </div>
                    <button type="submit" class="login100-form-btn">Send Verification Code</button>
                </form>
            </c:if>

            <%-- Step 2: enter OTP + new password --%>
            <c:if test="${step2 != null}">
                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <input type="hidden" name="email" value="${email}"/>
                    <div class="wrap-input100">
                        <input class="effect-19 input100" id="otp" type="text" name="otp" placeholder=" " required autofocus>
                        <label for="otp">Verification Code</label>
                        <span class="focus-border"><i></i></span>
                    </div>
                    <div class="wrap-input100 position-relative">
                        <input class="effect-19 input100" id="newPassword" type="password" name="newPassword" placeholder=" " required>
                        <label for="newPassword">New Password</label>
                        <span class="focus-border"><i></i></span>
                        <button type="button" class="toggle-password" data-target="newPassword" style="position:absolute; right:12px; top:50%; transform:translateY(-50%); background:#0d6efd; border:none; cursor:pointer; padding:8px; border-radius:6px; display:flex; align-items:center; justify-content:center; box-shadow:0 2px 6px rgba(13,110,253,0.4);">
                            <i class="bi bi-eye" id="newPasswordIcon" style="color:#fff; font-size:16px;"></i>
                        </button>
                    </div>
                    <div class="wrap-input100 position-relative">
                        <input class="effect-19 input100" id="confirmPassword" type="password" name="confirmPassword" placeholder=" " required>
                        <label for="confirmPassword">Confirm New Password</label>
                        <span class="focus-border"><i></i></span>
                        <button type="button" class="toggle-password" data-target="confirmPassword" style="position:absolute; right:12px; top:50%; transform:translateY(-50%); background:#0d6efd; border:none; cursor:pointer; padding:8px; border-radius:6px; display:flex; align-items:center; justify-content:center; box-shadow:0 2px 6px rgba(13,110,253,0.4);">
                            <i class="bi bi-eye" id="confirmPasswordIcon" style="color:#fff; font-size:16px;"></i>
                        </button>
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

    function shakeAlert() {
        $('.alert-danger').each(function() {
            $(this).css({
                'animation': 'shake 0.4s ease-in-out'
            });
        });
    }
    shakeAlert();

    $('.toggle-password').on('click', function() {
        var targetId = $(this).data('target');
        var input = $('#' + targetId);
        var icon = $('#' + targetId + 'Icon');
        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            icon.removeClass('bi-eye').addClass('bi-eye-slash');
        } else {
            input.attr('type', 'password');
            icon.removeClass('bi-eye-slash').addClass('bi-eye');
        }
    });
</script>
</body>
</html>
