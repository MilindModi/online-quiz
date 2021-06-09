<jsp:include page="header.jsp" />

<%
session = request.getSession(true);
if (session.getAttribute("username") != null) {
%>
<jsp:forward page="dashboard.jsp" />
<%
}
%>

<title>Online Quiz - Login</title>
</head>
<body>
	<div class="back">
		<img src="img/1.jpg" class="bgimg" type="jpg/jpeg">
	</div>
	<div class="card custom-card">
		<div class="card-header">
			<h2 class="custom-heading">Login</h2>
		</div>
		<div class="card-body">
			<form action="Login" method="post">
				<div class="form-group">
					<input type="text" name="username" class="form-control"
						placeholder="Username" />
				</div>

				<div class="form-group">
					<input type="password" name="password" class="form-control"
						placeholder="Password" />
				</div>

				<div class="form-check">
					<input class="form-check-input" type="checkbox" value=""
						id="defaultCheck1"> <label class="form-check-label"
						for="defaultCheck1"> Remember Me </label>
				</div>

				<input type="submit" value="Login" class="btn btn-success" />
			</form>
			<br /> <a href="register.jsp"><button class="btn btn-primary">Register</button></a>
		</div>
	</div>
	<jsp:include page="footer.jsp" />