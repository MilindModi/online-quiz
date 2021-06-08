import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Demo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        response.setContentType("text/html");

        pw.close();
    }
}
