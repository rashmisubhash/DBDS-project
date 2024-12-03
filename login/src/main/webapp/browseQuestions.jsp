<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.CustomerQuestions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Browse Questions</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/navbar.jsp" />

<div class="container">
    <% 
        // Retrieve errorMessage if present
        String errorMessage = (String) request.getAttribute("errorMessage");

        // Safely retrieve and cast searchedQuestions
        List<CustomerQuestions> searchedQuestions = null;
        Object searchedQuestionsObj = request.getAttribute("searchedQuestions");
        if (searchedQuestionsObj instanceof List<?>) {
            try {
                @SuppressWarnings("unchecked")
                List<CustomerQuestions> tempList = (List<CustomerQuestions>) searchedQuestionsObj;
                searchedQuestions = tempList;
            } catch (ClassCastException e) {
                out.println("<div class='error-message'>Error: Unable to cast searched questions.</div>");
            }
        }
    %>

    <% if (errorMessage != null) { %>
        <div class="error-message"><%= errorMessage %></div>
    <% } %>

    <h1>Browse Questions</h1>

    <!-- Search Form -->
    <div class="search-section">
        <h2>Search Questions</h2>
        <form action="searchQuestions" method="get">
            <label for="keyword">Search Keyword:</label>
            <input type="text" name="keyword" id="keyword" placeholder="Enter keyword" required>
            <button type="submit">Search</button>
        </form>
    </div>

    <!-- Display Search Results -->
    <div class="results-section">
        <h2>Search Results</h2>
        <table class="questions-table">
            <thead>
                <tr>
                    <th>Question</th>
                    <th>Answer</th>
                </tr>
            </thead>
            <tbody>
                <% if (searchedQuestions != null && !searchedQuestions.isEmpty()) { 
                    for (CustomerQuestions question : searchedQuestions) { %>
                        <tr>
                            <td><%= question.getQuestion() %></td>
                            <td><%= question.getReply() != null ? question.getReply() : "No answer yet" %></td>
                        </tr>
                <%   } 
                   } else if (searchedQuestions != null) { %>
                        <tr>
                            <td colspan="2">No results found for your search.</td>
                        </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <div class="ask-question-section">
        <h2>Ask a New Question</h2>
        <form action="sendQuestion" method="post">
            <label for="question">Your Question:</label><br>
            <textarea name="question" id="question" rows="4" cols="50" placeholder="Type your question here..." required></textarea><br>
            <button type="submit">Submit</button>
        </form>
    </div>
</div>

</body>
</html>
