package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.example.dao.CustomerQuestionsDao;

//@WebServlet("/replyQuestion")
public class ReplyQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int questionId = Integer.parseInt(request.getParameter("questionId"));
            String reply = request.getParameter("reply");

            CustomerQuestionsDao dao = new CustomerQuestionsDao();
            dao.addReply(questionId, reply);

            response.sendRedirect("repDashboard.jsp");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Question ID.");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing the request.");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        }
    }
}
