import java.sql.*;
import java.io.PrintWriter;
import javax.servlet.http.HttpSession;

public class DatabaseConnect {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/company";
    static final String USER = "root";
    static final String PASS = "";

    // public static void main(String[] args) {
    // boolean state = ValidateUser("pradip", "pradip");
    // System.out.println(state);
    // }

    public static void ValidateUser(String username, String password, PrintWriter pw, HttpSession session) {

        String sql = "select * from employees where name=\'" + username + "\' AND password=\'" + password + "\'";
        int count = 0;
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                Statement stmt = conn.createStatement();) {
            Class.forName(JDBC_DRIVER);
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String name = rs.getString("name");
                session.setAttribute("name", name);
                session.setAttribute("date", java.time.LocalDate.now());
                session.setAttribute("time", java.time.LocalTime.now());
            }
            rs.close();
        } catch (Exception e) {
            pw.println(e.getMessage());
        }
    }
    
    public static int RegisterUser(String username, String password, PrintWriter pw) {
    	String sql = "insert into employees values('"+ username +"','"+ password +"')";
    	int res = 0;
    	try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                Statement stmt = conn.createStatement();) {
    		Class.forName(JDBC_DRIVER);
    		res = stmt.executeUpdate(sql);
    	} catch (Exception e) {
    		pw.println(e.getMessage());
    	}
    	
    	return res;
    }
}
