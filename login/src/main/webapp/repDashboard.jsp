<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dao.CustomerQuestionsDao" %>
<%@ page import="com.example.model.CustomerQuestions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Representative Dashboard</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/welcome.css">
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
    }
    .container {
        width: 90%;
        margin: 20px auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    h2 {
        font-size: 24px;
        margin-bottom: 20px;
        text-align: center;
        color: #333333;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    table th, table td {
        text-align: left;
        padding: 12px;
        border: 1px solid #dddddd;
    }
    table th {
        background-color: #f2f2f2;
        color: #333333;
    }
    table tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    table tr:hover {
        background-color: #f1f1f1;
    }
    textarea {
        width: 98%; /* Adjust width to fit within table cell */
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        resize: vertical;
    }
    button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 16px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
    }
    button:hover {
        background-color: #45a049;
    }
    .navbar {
        margin-bottom: 20px;
    }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/navbar.jsp" />

<div class="container">
    <h2>Pending Questions</h2>
    <table>
        <thead>
            <tr>
                <th>Question ID</th>
                <th>Customer</th>
                <th>Question</th>
                <th>Reply</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            CustomerQuestionsDao dao = new CustomerQuestionsDao();
            dao.loadDriver();
            List<CustomerQuestions> pendingQuestions = dao.getPendingQuestions();
            if (pendingQuestions != null && !pendingQuestions.isEmpty()) {
                for (CustomerQuestions q : pendingQuestions) {
        %>
        <tr>
            <td><%= q.getQuestionId() %></td>
            <td><%= q.getCustomerId() %></td>
            <td><%= q.getQuestion() %></td>
            <form action="replyQuestion" method="post">
                <td>
                    <textarea name="reply" placeholder="Write your reply here..." required></textarea>
                </td>
                <td>
                    <input type="hidden" name="questionId" value="<%= q.getQuestionId() %>">
                    <button type="submit">Submit Reply</button>
                </td>
            </form>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5" style="text-align: center;">No pending questions found.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
