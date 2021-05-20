<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking Successful</title>
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

if((boolean)request.getAttribute("flag")){
%>
<h2>Booking Successful</h2>
<h4>Here are your Flight and Payment details</h4>
<form method="get" action="user">
	<table>
		<tr>
		<td>User Name :</td>
		<td> <%=request.getAttribute("username") %></td>
		</tr>
		<tr>
		<td>User ID :</td>
		<td> <%=userid %></td>
		</tr>
		<tr>
		<td>Name of the Flight :</td>
		<td> <%=request.getAttribute("nof") %></td>
		</tr>
		<tr>
		<td> Flight ID : </td>
		<td> <%=request.getAttribute("flightid") %></td>
		</tr>
		<tr>
		<td> Date of Flight : </td>
		<td> <%=request.getAttribute("dof") %></td>
		</tr>
		<tr>
		<td> Starting Destination : </td>
		<td> <%=request.getAttribute("startdst") %></td>
		</tr>
		<tr>
		<td> Ending Destination : </td>
		<td> <%=request.getAttribute("enddst") %></td>
		</tr>
		<tr>
		<td> Departure : </td>
		<td> <%=request.getAttribute("departure") %></td>
		</tr>
		<tr>
		<td> Arrival : </td>
		<td> <%=request.getAttribute("arrival") %></td>
		</tr>
		<tr>
		<td> No.of Tickets booked : </td>
		<td> <%=request.getAttribute("nobs") %></td>
		</tr>
		<tr>
		<td> Meals Preferred : </td>
		<td> <%=request.getAttribute("mealpref") %></td>
		</tr>
		<tr>
		<td> Total Cost: </td>
		<td> <%=request.getAttribute("totalcost") %></td>
		</tr>
		<tr>
		<td> <button name="submit" value=<%=userid %>>Click here for another booking</button></td>
		</tr>
	</table>
</form>
<%} else{%>
<h1>Seats Unavailable</h1>
<%} }else
{
	response.sendRedirect("userlogin.jsp");
}%>
</body>
</html>