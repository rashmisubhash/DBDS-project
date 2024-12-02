package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.example.dao.RegisterDao;
import com.example.model.Member;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String uname = request.getParameter("uname");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String first_name = request.getParameter("first_name");
		String last_name = request.getParameter("last_name");
		String user_type = "customer";

		Member member = new Member(uname, password, email, first_name, last_name, user_type);
		RegisterDao rdao = new RegisterDao();
		String result = rdao.insert(member);
		
		if ("Data Entered Successfully".equals(result)) {
	        request.getSession().setAttribute("successMessage", "Registration completed successfully!");
	        response.sendRedirect("login.jsp"); 
	    } else {
	        request.setAttribute("errorMessage", "Registration failed. Please try again.");
	        request.getRequestDispatcher("memberRegister.jsp").forward(request, response);
	    }

	}

}
