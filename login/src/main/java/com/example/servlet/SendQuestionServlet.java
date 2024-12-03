package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.dao.CustomerQuestionsDao; // Ensure this is imported

import java.io.IOException;

//@WebServlet("/sendQuestion")
public class SendQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerId = (String) request.getSession().getAttribute("username");
        String question = request.getParameter("question");

        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (question == null || question.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Question cannot be empty.");
            response.sendRedirect("customerDashboard.jsp");
            return;
        }

        try {
            CustomerQuestionsDao dao = new CustomerQuestionsDao();
            dao.loadDriver();
            dao.addQuestion(customerId, question);
            request.getSession().setAttribute("successMessage", "Your question has been submitted successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "An error occurred while submitting your question. Please try again.");
        }

        response.sendRedirect("customerDashboard.jsp");
    }
}
