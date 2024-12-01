<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dao.CustomerQuestionsDao" %>
<%@ page import="com.example.model.CustomerQuestions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Dashboard</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/welcome.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/navbar.jsp" />

<div class="container">
    <% 
        // Get customerId from session
        String customerId = (String) session.getAttribute("username");
        if (customerId == null) {
            // Redirect to login page if the user is not logged in
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve success or error messages from session
        String errorMessage = (String) session.getAttribute("errorMessage");
        String successMessage = (String) session.getAttribute("successMessage");
    %>

    <% if (errorMessage != null) { %>
        <div class="error-message"><%= errorMessage %></div>
        <% session.removeAttribute("errorMessage"); %>
    <% } %>
    <% if (successMessage != null) { %>
        <div class="success-message"><%= successMessage %></div>
        <% session.removeAttribute("successMessage"); %>
    <% } %>

    <h1>Welcome, <%= customerId %>!</h1>
    <p>This is your Customer Dashboard.</p>
    <a href="logout">Logout</a>

    <h2>Your Questions</h2>
    <table class="questions-table">
        <thead>
            <tr>
                <th>Question</th>
                <th>Reply</th>
                <th>Status</th>
                <th>Asked At</th>
                <th>Replied At</th>
            </tr>
        </thead>
        <tbody>
        <%
            // Initialize DAO and fetch questions
            CustomerQuestionsDao dao = new CustomerQuestionsDao();
            dao.loadDriver();
            List<CustomerQuestions> questions = null;

            try {
                questions = dao.getQuestionsByCustomer(customerId);
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error fetching questions. Please try again later.</td></tr>");
                e.printStackTrace(); // For debugging; remove in production
            }

            if (questions != null && !questions.isEmpty()) {
                for (CustomerQuestions q : questions) {
        %>
        <tr>
            <td><%= q.getQuestion() %></td>
            <td><%= q.getReply() != null ? q.getReply() : "No reply yet" %></td>
            <td><%= q.getStatus() %></td>
            <td><%= q.getCreatedAt() != null ? q.getCreatedAt() : "N/A" %></td>
            <td><%= q.getRepliedAt() != null ? q.getRepliedAt() : "N/A" %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">No questions found.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <h2>Ask a New Question</h2>
    <form action="sendQuestion" method="post">
        <label for="question">Your Question:</label><br>
        <textarea name="question" id="question" rows="4" cols="50" required></textarea><br><br>
        <button type="submit">Submit</button>
    </form>
</div>

</body>
</html>
