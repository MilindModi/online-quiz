<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Montserrat&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box
}

body {
	background-color: #333
}

.container {
	background-color: #555;
	color: #ddd;
	border-radius: 10px;
	padding: 20px;
	font-family: 'Montserrat', sans-serif;
	max-width: 700px
}

.container>p {
	font-size: 32px
}

.question {
	width: 75%
}

.options {
	position: relative;
	padding-left: 40px
}

#options label {
	display: block;
	margin-bottom: 15px;
	font-size: 14px;
	cursor: pointer
}

.options input {
	opacity: 0
}

.checkmark {
	position: absolute;
	top: -1px;
	left: 0;
	height: 25px;
	width: 25px;
	background-color: #555;
	border: 1px solid #ddd;
	border-radius: 50%
}

.options input:checked ~.checkmark:after {
	display: block
}

.options .checkmark:after {
	content: "";
	width: 10px;
	height: 10px;
	display: block;
	background: white;
	position: absolute;
	top: 50%;
	left: 50%;
	border-radius: 50%;
	transform: translate(-50%, -50%) scale(0);
	transition: 300ms ease-in-out 0s
}

.options input[type="radio"]:checked ~.checkmark {
	background: #21bf73;
	transition: 300ms ease-in-out 0s
}

.options input[type="radio"]:checked ~.checkmark:after {
	transform: translate(-50%, -50%) scale(1)
}

.btn-primary {
	background-color: #555;
	color: #ddd;
	border: 1px solid #ddd
}

.btn-primary:hover {
	background-color: #21bf73;
	border: 1px solid #21bf73
}

.btn-success {
	padding: 5px 25px;
	background-color: #21bf73
}

@media ( max-width :576px) {
	.question {
		width: 100%;
		word-spacing: 2px
	}
}
</style>
<%@page import="db.Database"%>
<script>
	var wsUrl;
	if (window.location.protocol == 'http:') {
		wsUrl = 'ws://';
	} else {
		wsUrl = 'wss://';
	}
	var ws = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/GetAnswer");

	ws.onmessage = function(event) {
		var mySpan = document.getElementById("crtans");
		mySpan.innerHTML = "<b>Correct Answer: " + event.data + "</b>";
	};

	ws.onerror = function(event) {
		console.log("Error ", event)
	}

	function sendMsg(val) {
		var qid = document.getElementById("id_" + val).value;
		var msg = qid;
		if (msg) {
			ws.send(msg);
		}
		document.getElementById("crtans").value = "";
	}

	function test(val, isLast=false) {
		/* var qid = document.getElementById("id_"+val).value;
		alert(qid);
		var loc = window.location;
		var newloc = loc + '&qid=' + qid;
		window.history.pushState({}, newloc, loc);
		alert("HERE"); */
		sendMsg(val);
		if(isLast) {
	var nextbtn = document.getElementById("nextqbtn");
		nextbtn.innerHTML = '<a href="Scoreboard" class="btn btn-success bb">Display Results</a>';
		}
	}

	function showQuestion(id) {
		document.getElementById('closeScoreboard').click();
		var questions = document.getElementsByName("questions");

		for (let i = 0; i < questions.length; i++) {
			let j = i + 1;
			if (questions[i].id === ('question_' + id)) {
				if (id < questions.length - 1) {
					var eyedee = String(document.getElementById("id_" + i).value);
					document.getElementById("nextbtn_" + i).innerHTML = "<div data-toggle='modal' data-target ='#scoreboard' class='ml-auto mr-sm-5'><button onclick='test("
							+ i
							+ ")' class='btn btn-success'>Next</button></div>";
					var nextbtn = document.getElementById("nextqbtn");
					nextbtn.innerHTML = '<input type="submit" name="submit" value="Next Question" class="btn btn-success bb" onclick="showQuestion('
							+ j + ')">';
				} else
					document.getElementById("finishbtn").style.display = "block";
				questions[i].style.display = 'block';
			} else
				questions[i].style.display = 'none';
		}
	}
</script>
</head>
<body>

	<jsp:include page="navbar.jsp" />
	<jsp:include page="scoreboard.jsp" />
	<%@page import="models.questions.*"%>
	<%@page import="java.util.*"%>
	<%@page import="java.sql.*, java.util.*"%>
	<%@page import="javax.servlet.*, javax.servlet.http.*"%>

	<%
	String quizid;
	quizid = request.getParameter("id");

	String username;
	Connection con;
	Statement stmt;
	ResultSet rs;

	HttpSession sess;
	sess = request.getSession();
	username = (String) sess.getAttribute("username");

	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/online-quiz", "root", "");
	stmt = con.createStatement();
	rs = stmt.executeQuery("SELECT * FROM questions WHERE quizid='" + quizid + "' ORDER BY timestamp");
	/*List<Question> questions = new ArrayList<>();*/

	int i = 0;
	while (rs.next()) {
		String qid = rs.getString("questionid");
		String question = rs.getString("question");
		String a = rs.getString("option1");
		String b = rs.getString("option2");
		String c = rs.getString("option3");
		String d = rs.getString("option4");
		int ca = Integer.parseInt(rs.getString("correctanswer"));
		String qType = rs.getString("type");

		/*questions.add(new MCQ(question, new String[] { a, b, c, d }, ca));*/
	%>
	<div class="container mt-sm-5 my-1" name="questions"
		id="question_<%=i%>" style="display: none;">
		<input type="hidden" id="id_<%=i%>" style="display: none;"
			value="<%=qid%>">
		<div class="question ml-sm-5 pl-sm-5 pt-2">
			<div class="py-2 h5">
				<b id="display_qname"><%=question%></b>
			</div>
			<div id="options">
				<label class="options" id="display_a">A) <%=a%>
				</label> <label class="options" id="display_b">B) <%=b%>
				</label> <label class="options" id="display_c">C) <%=c%>
				</label> <label class="options" id="display_d">D) <%=d%>
				</label>
			</div>
		</div>
		<div class="d-flex align-items-center pt-3" id="nextbtn_<%=i%>"></div>
	</div>
	<%
	i++;
	}
	%>
	<div
		style="display: none; padding-top: 10px; width: 100px; margin: 0 auto;"
		id="finishbtn">
		<a data-toggle='modal' data-target='#scoreboard'
			onclick="test(<%=i - 1%>, true)" class="btn btn-success">Finish</a>
	</div>
	<script>
		showQuestion(0);
	</script>

</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
</html>