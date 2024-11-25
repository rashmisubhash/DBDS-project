<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/style.css">
</head>
<body>

<%-- Display success message if available --%>
<%
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
%>
    <div class="success-message">
        <%= successMessage %>
    </div>
    <%
        session.removeAttribute("successMessage"); // Clear message after displaying it
    }
%>

	<div class="login-container">
		<h2>Login</h2>
		<form action="loginCheck" method="post">
			<label for="uname">Username:</label> <input type="text" id="uname"
				name="uname" required><br> <br> <label
				for="password">Password:</label> <input type="password"
				id="password" name="password" required><br> <br>

			<button type="submit">Login</button>
		</form>

		<!-- Error message placeholder (if needed) -->
		<div class="error-message">
			<%=request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : ""%>
		</div>
	</div>
</body>
</html>