package db;

import java.sql.*;
import java.io.PrintWriter;
import javax.servlet.http.HttpSession;

import models.User;
import util.Util;
import models.questions.*;
import models.Score;
import java.util.*;

public class Database {
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/online-quiz";
	static final String USER = "root";
	static final String PASS = "";
	
	public static int[] getPerQuestionResult(String quesid) {
		System.out.println(quesid);
		int[] score = new int[2];
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			ResultSet rs = stmt.executeQuery("SELECT COUNT(CASE WHEN isCorrect = 0 then isCorrect end) as wrong, COUNT(CASE WHEN isCorrect = 1 then isCorrect end) as correct from scoreboard where questionid = '"+quesid+"'");
			while (rs.next()) {
				score[0] = rs.getInt("correct");
				score[1] = rs.getInt("wrong");
			}
			System.out.println(score[0]);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return score;
	}

	public static String getCorrectAnswer(String qid) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			ResultSet rs = stmt.executeQuery("SELECT correctanswer FROM questions WHERE questionid='" + qid + "'");
			if(rs.next()) return rs.getString("correctanswer");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static List<Score> getScoreboard(String quizid) {
		List<Score> scores = new ArrayList<>();
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			String sql = "SELECT s.username, SUM(s.isCorrect) AS score FROM quiz qu, scoreboard s WHERE qu.quizid='"
					+ quizid + "' and s.questionid IN(SELECT questionid FROM questions WHERE quizid='" + quizid
					+ "') GROUP BY username ORDER BY score DESC;";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String username = rs.getString("username");
				int score = rs.getInt("score");
				scores.add(new Score(username, score));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return scores;
	}

	public static void updateQuestion(String qid, Question q) {
		MCQ question = (MCQ) q;

		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			String[] answers = question.getAnswers();
			stmt.executeUpdate("UPDATE questions SET question='" + question.getQuestion() + "', option1='" + answers[0]
					+ "', option2='" + answers[1] + "', option3='" + answers[2] + "', option4='" + answers[3]
					+ "', correctanswer='" + question.getCorrectAnswer() + "' WHERE questionid='" + qid + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void deleteQuiz(String qid) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			stmt.executeUpdate("DELETE FROM quiz WHERE quizid='" + qid + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void deleteQuestion(String qid) {
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			stmt.executeUpdate("DELETE FROM questions WHERE questionid='" + qid + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void addQuestion(Question q, Integer quizid) {
		MCQ question = (MCQ) q;
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			String[] answers = question.getAnswers();
			stmt.executeUpdate(
					"INSERT INTO questions (questionid, question, quizid, option1, option2, option3, option4, correctanswer, type, correctPoints, minusPoints, timestamp) VALUES('"
							+ Util.getUniqueID(6) + "', '" + question.getQuestion() + "', '" + quizid + "', '"
							+ answers[0] + "', '" + answers[1] + "', '" + answers[2] + "', '" + answers[3] + "', '"
							+ question.getCorrectAnswer() + "', 'MCQ', '1', '0', '" + java.time.LocalDateTime.now()
							+ "')");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Integer getNumericId(String username, String quizname) {
		boolean unique = false;
		Integer quizid = Util.getNumericID(6);

		while (!unique) {
			quizid = Util.getNumericID(6);
			try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
					Statement stmt = conn.createStatement()) {
				ResultSet rs = stmt
						.executeQuery("SELECT COUNT(quizid) AS count FROM quiz WHERE quizid='" + quizid + "'");
				if (rs.next()) {
					int count = rs.getInt("count");
					if (count > 0)
						continue;
					else {
						unique = true;
					}
				}
				unique = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			int result = stmt.executeUpdate("INSERT INTO quiz (quizid, quizname, username, timestamp) VALUES(" + quizid
					+ ", '" + quizname + "', '" + username + "', '" + java.time.LocalDateTime.now() + "')");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return quizid;
	}

	public static User fetchUser(String username, String password, PrintWriter pw, HttpSession session) {
		String sql = "SELECT * FROM users WHERE username=\'" + username + "\' AND password=\'" + password + "\'";
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
				Statement stmt = conn.createStatement()) {
			Class.forName(JDBC_DRIVER);
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				String uname = rs.getString("username");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String passwd = rs.getString("password");

				if (username.equals(uname) && password.equals(passwd)) {

					session.setAttribute("username", uname);
					session.setAttribute("date", java.time.LocalDate.now());
					session.setAttribute("time", java.time.LocalTime.now());

					return new User(uname, name, email);
				}
				return null;
			}
			rs.close();
			return null;
		} catch (Exception e) {
			pw.println(e.getMessage());
			return null;
		}
	}

	public static boolean addUser(String username, String password, String name, String email, PrintWriter pw) {
		String sql = "INSERT INTO users (username, password, name, email) VALUES('" + username + "','" + password
				+ "', '" + name + "', '" + email + "')";
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
