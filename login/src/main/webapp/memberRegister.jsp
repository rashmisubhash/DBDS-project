<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="register-container">
        <h2>Register</h2>
        <form action="Register" method="post">
            <label for="uname">User Name</label>
            <input type="text" id="uname" name="uname" required><br><br>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required><br><br>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required><br><br>

            <label for="first_name">First Name</label>
            <input type="text" id="first_name" name="first_name" required><br><br>
            
            <label for="last_name">Last Name</label>
            <input type="text" id="last_name" name="last_name" required><br><br>

            <button type="submit">Register</button>
        </form>

        <!-- Error message placeholder (if needed) -->
        <div class="error-message">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </div>
    </div>
</body>
</html>
