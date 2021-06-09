package db;

import java.sql.*;
import java.io.PrintWriter;
import javax.servlet.http.HttpSession;

import models.User;
import models.UserType;

public class Database {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/online-quiz";
	static final String USER = "root";
	static final String PASS = "";

	// public static void main(String[] args) {
	// boolean state = ValidateUser("pradip", "pradip");
	// System.out.println(state);
	// }

	public static User fetchUser(String username, String password, PrintWriter pw, HttpSession session) {
		String sql = "SELECT * FROM users WHERE username=\'" + username + "\' AND password=\'" + password + "\'";
		int count = 0;
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			Class.forName(JDBC_DRIVER);
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				String uname = rs.getString("username");
				String name = rs.getString("name");
				String type = rs.getString("type");

				session.setAttribute("username", uname);
				session.setAttribute("date", java.time.LocalDate.now());
				session.setAttribute("time", java.time.LocalTime.now());

				return new User(uname, name, type == "A" ? UserType.Attendee : UserType.Presenter);
			}
			rs.close();
			return null;
		} catch (Exception e) {
			pw.println(e.getMessage());
			return null;
		}
	}

	public static boolean addUser(String username, String password, PrintWriter pw) {
		String sql = "INSERT INTO users VALUES('" + username + "','" + password + "')";
		int res = 0;
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			Class.forName(JDBC_DRIVER);
			res = stmt.executeUpdate(sql);
		} catch (Exception e) {
			pw.println(e.getMessage());
		}

		return res >= 0;
	}
}
