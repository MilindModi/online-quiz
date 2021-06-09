package pages;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet({ "/Logout", "/Logout/" })
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        session.invalidate();

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

//        out.println("<HEAD><TITLE> " + "Logout" + "</TITLE></HEAD><BODY>");
//        out.println("<P>[<A HREF=\"index.html\">Login Page</A>]");
//        out.println("<h2> Logged Out Successfully</h2>");
        
        response.sendRedirect("index.jsp");
        out.close();
    }
}
