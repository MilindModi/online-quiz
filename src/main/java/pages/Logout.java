package pages;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Logout extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        session.invalidate();

        res.setContentType("text/html");

        PrintWriter out = res.getWriter();

        out.println("<HEAD><TITLE> " + "Logout" + "</TITLE></HEAD><BODY>");
        out.println("<P>[<A HREF=\"index.html\">Login Page</A>]");
        out.println("<h2> Logged Out Successfully</h2>");
        out.close();
    }
}
