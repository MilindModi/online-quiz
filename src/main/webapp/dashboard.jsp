
<jsp:include page="header.jsp" />
<jsp:include page="auth.jsp" />
<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="css/anime.css">
<title>DashBoard</title>
</head>
<body>
	<div class="back">
		<img src="img/4.jpg" class="bgimg" type="jpg/jpeg">

	</div>

	<div class="container-fluid text-center">
		<div class="row1">
			<div class="col-md-12">
				<p class="text-right heading">
					<a class="btn btn-danger" href="Logout">Logout</a>
				</p>
				<h1 class="heading">Dashboard</h1>

			</div>
		</div>
		<div class="row" style="margin-top: 15vh">

			<div class="col animated slideInLeft">
				<a class="btn btn-primary tbtn" href="q1r1-test.php"><h1
						class="q">Create Quiz</h1></a>
			</div>
			<div class="col animated slideInRight">
				<a class="btn btn-danger tbtn" href="q1r2-test.php"><h1
						class="q">Participate</h1></a>
			</div>
		</div>
		<div class="q3">
			<!--<a class="btn btn-success q3btn" href="quali.php">Qualified Candidates for Round 3</a>-->
		</div>
	</div>

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


</body>
</html>