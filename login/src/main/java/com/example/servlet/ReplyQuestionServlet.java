package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.example.dao.CustomerQuestionsDao;

@WebServlet("/replyQuestion")
public class ReplyQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        String reply = request.getParameter("reply");

        CustomerQuestionsDao dao = new CustomerQuestionsDao();
        dao.addReply(questionId, reply);

        response.sendRedirect("repDashboard.jsp"); // Redirect back to the representative's dashboard
    }
}
