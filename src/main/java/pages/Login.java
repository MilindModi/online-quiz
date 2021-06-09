package pages;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import db.Database;
import models.User;

@WebServlet({ "/Login", "/Login/" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		PrintWriter pw = response.getWriter();
		HttpSession session = request.getSession();
		response.setContentType("text/html");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = Database.fetchUser(username, password, pw, session);

		if (session.getAttribute("username") == null || user == null) {
			pw.println("Login Failed");
			pw.println("<a HREF=\"index.html\">Login Page</a>");
		} else {
			/*
			 * pw.println("<h2>User Name : " + session.getAttribute("username") + "</h2>");
			 * pw.println("<h2>Date : " + session.getAttribute("date") + "</h2>");
			 * pw.println("<h2>Time : " + session.getAttribute("time") + "</h2>");
			 * pw.print("<a href=\"Logout\">Logout</a>");
			 */
			response.sendRedirect("dashboard.jsp");
		}
		pw.close();
	}
}