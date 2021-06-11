<jsp:include page="header.jsp" />
<jsp:include page="auth.jsp" />
<title>Participate</title>
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
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
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

.container-question {
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
<script type="text/javascript">
	var quizid =
<%=request.getParameter("id")%>
	;
	console.log(quizid);
	var wsUrl;
	if (window.location.protocol == 'http:') {
		wsUrl = 'ws://';
	} else {
		wsUrl = 'wss://';
	}
	var ws = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/SendQuestion");
	var ws5 = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/SubmitAnswer");
	var currentQuestion;

	ws.onmessage = function(event) {
		if (event.data.indexOf("nextquestion") > -1) {
			var strs = event.data.split(",");
			if (strs[1] == quizid) {
				$("#scoreboard").modal("hide");
				document.getElementById("smbtn").disabled = false;
				document.getElementById("loading").style.display = "none";
				var btns = document.getElementsByName("radio");
				for (let i = 0; i < btns.length; i++) {
					if (btns[i].checked) {
						btns[i].checked = false;
					}
				}
			}
			return;
		}

		if (event.data.indexOf("scoreboard") > -1) {
			var strs = event.data.split(",");
			if (strs[1] == quizid) {
				$("#scoreboard").modal("show");
			}
			return;
		}

		const question = JSON.parse(event.data);
		currentQuestion = question;

		if (question['quizid'] == quizid) {
			document.getElementById("startpt").style.display = 'none';
			document.getElementById("qdata").style.display = 'block';
			document.getElementById("disp_qname").innerHTML = question['qname'];
			document.getElementById("disp_a").innerHTML = question['a'];
			document.getElementById("disp_b").innerHTML = question['b'];
			document.getElementById("disp_c").innerHTML = question['c'];
			document.getElementById("disp_d").innerHTML = question['d'];
		}
	};

	ws.onerror = function(event) {
		console.log("Error ", event)
	}
	
	ws5.onerror = function(event) {
		console.log("Error ", event)
	}

	function sendMsg(msg) {
		if (msg) {
			ws.send(msg);
		}
	}

	function submitAnswer() {
		document.getElementById("smbtn").disabled = true;
		document.getElementById("loading").style.display = "block";
		var selectedValue = 0;
		var btns = document.getElementsByName("radio");
		for (let i = 0; i < btns.length; i++) {
			if (btns[i].checked) {
				selectedValue = i + 1;
			}
		}
		<%String uname = (String) session.getAttribute("username");%>
		var isCorrect = selectedValue == currentQuestion['ca'] ? 1: 0;
		var msg = currentQuestion['qid'] + "," + "<%=uname%>" + "," + selectedValue + "," + isCorrect;
		console.log("MSG: " + msg);
		ws5.send(msg);
	}
</script>
</head>
<body onload="sendMsg('')">
	<jsp:include page="navbar.jsp" />
	<jsp:include page="scoreboard.jsp" />
	<script>
		document.getElementById("nextqbtn").innerHTML = '<div style="text-align: center;" class="alert alert-info" role="alert">Waiting for next question...</div>';
	</script>

	<%
	String quizid = request.getParameter("id");
	if (db.Database.quizExists(quizid)) {
	%>

	<div id="startpt" class="jumbotron" style="text-align: center;">
		<h3>Please wait for the next question!</h3>
	</div>
	<div id="qdata" style="display: none;">
		<div class="container container-question mt-sm-5 my-1">
			<div class="question ml-sm-5 pl-sm-5 pt-2">
				<div class="py-2 h5">
					<b id="disp_qname"></b>
				</div>
				<div class="" id="options">
					<label class="options"><span id="disp_a"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options"><span id="disp_b"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options"><span id="disp_c"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options"><span id="disp_d"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label>
					<button id="smbtn" class="btn btn-success btn-lg"
						onclick="submitAnswer()">Submit</button>
					<br /> <br />
					<div id="loading" style="display: none; text-align: center;"
						class="alert alert-info" role="alert">Waiting for results...</div>
				</div>
			</div>
		</div>
	</div>
	<%
	} else {
	%>
	<div style="text-align: center;" class="jumbotron">
		No such quiz available.<br> <a href="dashboard.jsp"
			class="btn btn-info">Dashboard</a>
	</div>
	<%
	}
	%>
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