<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirm booking</title>
</head>
<body>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
HttpSession session1=request.getSession(false);
if(session1.getAttribute("id")!=null)
{
		Long userid=Long.parseLong(request.getParameter("userid"));
		Long flightid=Long.parseLong(request.getParameter("book"));
		
		%>
		<form method="post" action="userFlight">
			<table>
				<tr>
				<td>User ID :</td>
				<td><input type="text" name="userid" value=<%=userid %> readonly="readonly"></td>
				</tr>
				<tr>
				<td>Flight ID: </td>
				<td><input type="text" name="flightid" value=<%=flightid %> readonly="readonly"></td>
				</tr>
				<tr>
				<td>Enter the no.of seats to be booked: </td>
				<td><input type="text" name="nos"></td>
				</tr>
				<tr>
				<td>Meals preferred: </td>
				<td><input type="radio" name="meals" value="yes">Yes
				<input type="radio" name="meals" value="no">No</td>
				</tr>
				<tr>
				<td><input type="submit" name="submit" value="book"></td>
				</tr>
			</table>
		</form>
		<%}else{
			response.sendRedirect("userlogin.jsp");
		}%>
</body>
</html>