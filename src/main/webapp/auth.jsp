
<%
session = request.getSession(true);
if (session.getAttribute("username") == null) {
	%>
	<jsp:forward page="index.jsp" />
	<%
}
%>