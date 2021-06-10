
<jsp:include page="header.jsp" />
<jsp:include page="auth.jsp" />
<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="css/anime.css">

<style>
.table tr th:first-child, .table tr td:first-child {
	width: 10%;
}

.table tr th:last-child, .table tr td:last-child {
	width: 15%;
}
</style>

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
				<a class="btn btn-primary tbtn" href="#createQuizModal"
					data-toggle="modal"><h1 class="q">Create Quiz</h1></a>
			</div>
			<div class="col animated slideInRight">
				<a class="btn btn-danger tbtn" href="q1r2-test.php"><h1
						class="q">Participate</h1></a>
			</div>
		</div>

		<div class="row mt-5">
            <div class="col-md-12">
                <table class="table table-hover table-light table-bordered">
                    <thead>
                      <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Quiz Name</th>
                        <th scope="col">View</th>
                      </tr>
                    </thead>
                    <tbody>
                    
                    <%@page import="java.sql.*" %>
					<%@page import="javax.servlet.*, javax.servlet.http.*" %>
                    
                    <% 
						String username;
						Connection con;
				        Statement stmt;
				        ResultSet rs;
				        
				        HttpSession sess;
						sess = request.getSession();
						username = (String) sess.getAttribute("username");
				        
				        Class.forName("com.mysql.jdbc.Driver");
				        con = DriverManager.getConnection("jdbc:mysql://localhost/online-quiz","root","");
				        stmt = con.createStatement();
				        rs = stmt.executeQuery("SELECT * FROM quiz WHERE username='"+username+"'");
						int i=1;
						
						while(rs.next())
						{
							String quizid = rs.getString("quizid");
							String quizname = rs.getString("quizname");
							%>
							<tr>
		                        <th scope="row"><%=i++ %></th>
		                        <td><%=quizname %></td>
		                        <td><a class="btn btn-warning" href="quiz.jsp?id=<%=quizid %>">View</a></td>
		                      </tr>
							<%
						}
						%>
                    </tbody>
                  </table>
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

<!-- Edit Modal HTML -->
		<div id="createQuizModal" class="modal fade" style="z-index: 9999;" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="card">
						<form method="post" action="CreateQuiz">
							<div class="card-header">
								<h2 class="custom-heading">Quiz</h2>
							</div>

							<div class="card-body">
								<div class="form-group">
									<input type="text" name="quizname" class="form-control"
										placeholder="Quiz Name" required />
								</div>
								
								<div class="form-group">
									<input type="submit" name="submit" value="Create"
										class="btn btn-success bb">
								</div>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>

</html>