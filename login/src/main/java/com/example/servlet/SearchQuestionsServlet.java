package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.dao.CustomerQuestionsDao;
import com.example.model.CustomerQuestions;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchQuestions")
public class SearchQuestionsServlet extends HttpServlet {
	private CustomerQuestionsDao dao = new CustomerQuestionsDao();

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.isEmpty()) {
            request.setAttribute("errorMessage", "Keyword cannot be empty.");
            request.getRequestDispatcher("/browseQuestions.jsp").forward(request, response);
            return;
        }

        dao.loadDriver();
        List<CustomerQuestions> questions = dao.searchQuestions(keyword);
        request.setAttribute("searchedQuestions", questions);
        request.getRequestDispatcher("/customerDashboard.jsp").forward(request, response);
    }
}
