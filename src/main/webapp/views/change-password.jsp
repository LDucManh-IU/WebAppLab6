<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f5f5f5; }
        .navbar { background: #2c3e50; color: white; padding: 15px 30px; display:flex; justify-content:space-between; align-items:center; }
        .container { max-width: 600px; margin: 40px auto; padding: 20px; }
        .card { background: white; padding: 24px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .form-group { margin-bottom: 16px; }
        label { display:block; margin-bottom:6px; color:#333; font-weight:600; }
        input[type="password"] { width:100%; padding:12px; border:1px solid #ddd; border-radius:6px; }
        .btn { background:#3498db; color:white; padding:10px 18px; border:none; border-radius:6px; cursor:pointer; }
        .message { padding:12px; margin-bottom:14px; border-radius:6px; }
        .success { background:#d4edda; color:#155724; border:1px solid #c3e6cb; }
        .error { background:#f8d7da; color:#721c24; border:1px solid #f5c6cb; }
        .nav-right a { color:white; text-decoration:none; margin-left:14px; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>📚 Student Management System</h2>
        <div class="nav-right">
            <span style="margin-right:12px">${sessionScope.fullName}</span>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="card">
            <h3>Change Password</h3>
            <p>Use this form to change your account password.</p>

            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="message success">${success}</div>
            </c:if>

            <form method="post" action="change-password">
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required />
                </div>

                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required />
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required />
                </div>

                <div style="display:flex; gap:12px; align-items:center;">
                    <button type="submit" class="btn">Change Password</button>
                    <a href="dashboard" style="text-decoration:none; color:#3498db;">Back to Dashboard</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
