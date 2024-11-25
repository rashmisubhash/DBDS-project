<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/welcome.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/navbar.jsp" />
	<h1>Welcome, <%= session.getAttribute("username") %>!</h1>
    <p>This is the Customer Representative Dashboard.</p>
    <a href="logout">Logout</a>

</body>
</html>