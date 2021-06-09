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
	<div class="container">
		<form action="Login" method="post">
			<table>
				<tr>
					<td><input type="text" name="username" class="form-control"
						placeholder="Username" /></td>
				</tr>
				<tr>
					<td><input type="password" name="password"
						class="form-control" placeholder="Password" /></td>
				</tr>
				<tr>
					<td>
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value=""
								id="defaultCheck1"> <label class="form-check-label"
								for="defaultCheck1"> Remember Me </label>
						</div>
					</td>
				</tr>
			</table>
			<input type="submit" value="Login" class="btn btn-primary" />
		</form>
		<br /> <a href="register.jsp"><button class="btn btn-primary">Register</button></a>
	</div>
<jsp:include page="footer.jsp" />