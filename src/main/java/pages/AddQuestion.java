package pages;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Database;
import models.questions.*;

@WebServlet("/AddQuestion")
public class AddQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddQuestion() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] answers = {request.getParameter("a"), request.getParameter("b"), request.getParameter("c"), request.getParameter("d")};
		MCQ q = new MCQ(request.getParameter("q"), answers, Integer.parseInt(request.getParameter("ca")));
		Database.addQuestion(q, Integer.parseInt(request.getParameter("id")));
		String referer = request.getHeader("referer");
		int index = referer.indexOf("quiz.jsp");
		response.sendRedirect(referer.substring(index));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}