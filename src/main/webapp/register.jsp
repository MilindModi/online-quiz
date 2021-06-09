<jsp:include page="header.jsp" />
<title>Register</title>
</head>
<body>
	<div class="container">
		<form action="Register" method="post">
			<table>
				<tr>
					<td><input type="text" name="name" class="form-control"
						placeholder="Full Name" /></td>
				</tr>
				<tr>
					<td><input type="text" name="email" class="form-control"
						placeholder="Email" /></td>
				</tr>
				<tr>
					<td><input type="text" name="username" class="form-control" 
						placeholder="Username" /></td>
				</tr>
				<tr>
					<td><input type="password" name="password"
						class="form-control" placeholder="Password" /></td>
				</tr>
				<tr>
					<td><input type="password" name="repassword"
						class="form-control" placeholder="Re-enter Password" /></td>
				</tr>
				<tr>
					<td><input type="submit" value="Register"
						class="btn btn-primary" /></td>
				</tr>
			</table>
		</form>
		<br>
		<a href="index.jsp"><button class="btn btn-primary">Already
								have an account? Login</button></a>
	</div>
	<jsp:include page="footer.jsp" />