<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/css/navbar.css">
</head>
<body>

<div class="navbar">
		<div class="navbar-left">
			<h1>
				Welcome,
				<%=session.getAttribute("username")%>!
			</h1>
		</div>
		<div class="navbar-right">
			<a href="welcome.jsp" class="nav-link">Home</a> <a href="logout"
				class="nav-link">Logout</a>
		</div>
	</div>

</body>
</html>