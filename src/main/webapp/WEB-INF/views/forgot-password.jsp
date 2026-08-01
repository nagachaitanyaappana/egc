<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/global.css">
    <style>
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 4px;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            line-height: 0;
        }
        .toggle-password svg {
            width: 20px;
            height: 20px;
            display: block;
        }
        .toggle-password svg {
            pointer-events: none;
        }
        .wrap-input100 input.input100 {
            position: static !important;
            z-index: auto !important;
        }
        .toggle-password .eye-slash {
            display: none;
        }
        .toggle-password.showing .eye-slash {
            display: inline;
        }
    </style>
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
                        <input class="effect-19 input100" id="newPassword" type="text" name="newPassword" placeholder=" " required>
                        <label for="newPassword">New Password</label>
                        <span class="focus-border"><i></i></span>
                        <button type="button" class="toggle-password" data-target="newPassword" onmousedown="return false;">
                            <svg width="20" height="20" viewBox="0 0 16 16" fill="#0d6efd">
                                <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
                                <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
                                <line class="eye-slash" x1="2" y1="14" x2="14" y2="2" stroke="#0d6efd" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                        </button>
                    </div>
                    <div class="wrap-input100 position-relative">
                        <input class="effect-19 input100" id="confirmPassword" type="text" name="confirmPassword" placeholder=" " required>
                        <label for="confirmPassword">Confirm New Password</label>
                        <span class="focus-border"><i></i></span>
                        <button type="button" class="toggle-password" data-target="confirmPassword" onmousedown="return false;">
                            <svg width="20" height="20" viewBox="0 0 16 16" fill="#0d6efd">
                                <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
                                <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
                                <line class="eye-slash" x1="2" y1="14" x2="14" y2="2" stroke="#0d6efd" stroke-width="2" stroke-linecap="round"/>
                            </svg>
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
    $(document).ready(function(){
        $(".wrap-input100 .input100").focusout(function() {
            if($(this).val() != "") {
                $(this).addClass("has-content");
            }
            else {
                $(this).removeClass("has-content");
            }
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
            if (input.attr('type') === 'text') {
                input.attr('type', 'password');
                $(this).addClass('showing');
            } else {
                input.attr('type', 'text');
                $(this).removeClass('showing');
            }
        });
    });
</script>
</body>
</html>