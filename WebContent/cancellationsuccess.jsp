<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancellation Successfull</title>
</head>
<body>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
HttpSession session1=request.getSession(false);
if(session1.getAttribute("id")!=null)
{
Long userid=(Long)request.getAttribute("userid");
%>
<h1>Cancellation Successful</h1>
<form method="get" action="user">
	<table>
	<tr>
	<td><button name="submit" value=<%=userid %>>Click here to book a ticket</button></td>
	</tr>
	</table>
</form>
<form method="get" action="cancel">
	<table>
	<tr>
	<td><button name="submit" value=<%=userid %>>Click here to cancel a ticket</button></td>
	</tr>
	</table>
</form>
<%}else{
	response.sendRedirect("userlogin.jsp");
} %>
</body>
</html>