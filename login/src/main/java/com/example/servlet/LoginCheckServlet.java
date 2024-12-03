package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.example.model.Member;
import com.example.dao.loginDao;

public class LoginCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String uname = request.getParameter("uname");
		String password = request.getParameter("password");
		
		Member member = new Member(uname, password);
        loginDao rdao = new loginDao();

        String userType = rdao.checkLogin(member);
       
		
        if (userType != null) {
            // Successful login
            HttpSession session = request.getSession();
            session.setAttribute("username", uname);
            session.setAttribute("userType", userType);
            switch (userType) {
            case "customer":
                response.sendRedirect("customerDashboard.jsp");
                break;
            case "admin":
                response.sendRedirect("adminDashboard.jsp");
                break;
            case "customer_rep":
                response.sendRedirect("repDashboard.jsp");
                break;
            default:
                response.sendRedirect("login.jsp"); 
                break;
        }
            
//            response.sendRedirect("welcome.jsp");  
        } else {
            // Failed login
        	request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
	}

}
