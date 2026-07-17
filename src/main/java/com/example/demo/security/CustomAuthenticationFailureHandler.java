package com.example.demo.security;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import java.io.IOException;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {
        String errorParam;
        if (exception instanceof DisabledException) {
            errorParam = "disabled";
        } else if (exception instanceof LockedException) {
            errorParam = "locked";
        } else if (exception instanceof BadCredentialsException) {
            errorParam = "credentials";
        } else {
            errorParam = "unknown";
        }
        response.sendRedirect(request.getContextPath() + "/login?error=" + errorParam);
    }
}
