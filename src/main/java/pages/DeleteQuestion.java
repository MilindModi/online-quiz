package pages;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Database;

@WebServlet("/DeleteQuestion")
public class DeleteQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteQuestion() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String questionid = request.getParameter("id");
		Database.deleteQuestion(questionid);
		String referer = request.getHeader("referer");
		int index = referer.indexOf("quiz.jsp");
		response.sendRedirect(referer.substring(index));
	}

}
