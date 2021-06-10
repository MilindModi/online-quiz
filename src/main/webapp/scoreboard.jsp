<!-- Scoreboard Modal HTML -->
<div id="scoreboard" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="card custom-card">
				<div class="card-header">
					<h2 class="custom-heading">Scoreboard</h2>
					<button id="closeScoreboard" type="button" class="close"
						data-dismiss="modal" aria-label="Close" style="display: none;">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="card-body">
					<center id="crtans"><b>Correct Answer: A</b></center>
					<div class="row mt-5">
						<div class="col-md-12">
							<table class="table table-hover table-light table-borderless"
								style="width: 60%; margin: 0 auto;'">
								<thead class="thead-dark">
									<tr>
										<th scope="col">No.</th>
										<th scope="col">Username</th>
										<th scope="col">Score</th>
									</tr>
								</thead>
								<tbody>
									<%@page import="java.sql.*, java.util.*"%>
									<%@page import="models.Score, db.Database"%>
									<%@page import="javax.servlet.*, javax.servlet.http.*"%>

									<%
									String quizid = request.getParameter("id");
									List<Score> scores = Database.getScoreboard(quizid);
									Iterator<Score> itr = scores.iterator();
									int i = 1;
									while (itr.hasNext()) {
										Score s = itr.next();
									%>
									<tr>
										<th scope="row"><%=i++%></th>
										<td><%=s.username%></td>
										<td><%=s.score%></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
					<br />
					<center>
						<div class="form-group" id="nextqbtn">
							<input type="submit" name="submit" value="Next Question"
								class="btn btn-success bb">
						</div>
					</center>
				</div>
			</div>
		</div>
	</div>
</div>