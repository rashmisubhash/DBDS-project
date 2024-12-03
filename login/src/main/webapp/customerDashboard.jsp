<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dao.CustomerQuestionsDao" %>
<%@ page import="com.example.model.CustomerQuestions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Dashboard</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/welcome.css">
<style>
    /* Same styles as in the provided code */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
    }
    .container {
        max-width: 900px;
        margin: 20px auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    h1, h2 {
        text-align: center;
        color: #444;
    }
    .navbar {
        background: #333;
        color: white;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
    }
    .navbar a {
        color: white;
        text-decoration: none;
        margin-left: 15px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    table th, table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }
    table th {
        background-color: #f4f4f4;
    }
    .error-message, .success-message {
        color: red;
        text-align: center;
        margin: 10px 0;
    }
    form {
        margin: 20px 0;
        text-align: center;
    }
    form input, form textarea {
        width: 80%;
        padding: 8px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    form button {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
    }
    form button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>

<div class="navbar">
    <div>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>!</div>
    <div>
        <a href="customerDashboard">Home</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1>Customer Dashboard</h1>

    <% 
        String customerId = (String) session.getAttribute("username");
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String errorMessage = (String) session.getAttribute("errorMessage");
        String successMessage = (String) session.getAttribute("successMessage");

        session.removeAttribute("errorMessage");
        session.removeAttribute("successMessage");
    %>

    <% if (errorMessage != null) { %>
        <div class="error-message"><%= errorMessage %></div>
    <% } %>
    <% if (successMessage != null) { %>
        <div class="success-message"><%= successMessage %></div>
    <% } %>

    <!-- User Questions Section -->
    <h2>Your Questions</h2>
    <table>
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
                CustomerQuestionsDao dao = new CustomerQuestionsDao();
                dao.loadDriver();
                List<CustomerQuestions> questions = null;

                try {
                    questions = dao.getQuestionsByCustomer(customerId);
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error fetching questions. Please try again later.</td></tr>");
                    e.printStackTrace();
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
            <% } %>
        </tbody>
    </table>

    <!-- Search Questions Section -->
    <h2>Search Questions</h2>
    <form action="searchQuestions" method="get">
        <input type="text" name="keyword" placeholder="Enter keyword to search..." required>
        <button type="submit">Search</button>
    </form>
    <table>
        <thead>
            <tr>
                <th>Question</th>
                <th>Answer</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<CustomerQuestions> searchedQuestions = null;
                Object searchedQuestionsObj = request.getAttribute("searchedQuestions");
                if (searchedQuestionsObj instanceof List<?>) {
                    searchedQuestions = (List<CustomerQuestions>) searchedQuestionsObj;
                }

                if (searchedQuestions != null && !searchedQuestions.isEmpty()) {
                    for (CustomerQuestions question : searchedQuestions) {
            %>
            <tr>
                <td><%= question.getQuestion() %></td>
                <td><%= question.getReply() != null ? question.getReply() : "No answer yet" %></td>
            </tr>
            <%
                    }
                } else if (searchedQuestions != null) {
            %>
            <tr>
                <td colspan="2">No results found for your search.</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Ask New Question Section -->
    <h2>Ask a New Question</h2>
    <form action="sendQuestion" method="post">
        <textarea name="question" rows="4" placeholder="Type your question here..." required></textarea>
        <button type="submit">Submit Question</button>
    </form>
</div>

</body>
</html>
