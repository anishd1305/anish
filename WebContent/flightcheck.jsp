<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight details</title>
<style>    
table, th, td {    
border: 1px solid black;  
margin-left: auto;  
margin-right: auto;  
border-collapse: collapse;    
width: 1200px;  
text-align: center;  
font-size: 20px;  
}    
</style> 
</head>
<body>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
HttpSession session1=request.getSession(false);
if(session1.getAttribute("id")!=null)
{
	ArrayList<JSONObject> arr=(ArrayList)request.getAttribute("list");
	Long id=(Long)request.getAttribute("userid");
%>
	<form action="booking.jsp">
		<table>
			<tr>
				<td>User ID:</td>
				<td><input type="text" name="userid" value=<%=id %> readonly="readonly"></td>
			</tr>
			<tr>
				<th>Flight ID</th>
				<th>Name</th>
				<th>S.no</th>
				<th>Date of Flight</th>
				<th>Start destination</th>
				<th>End destination</th>
				<th>Departure</th>
				<th>Arrival</th>
				<th>No.of seats available</th>
				<th>Ticket Price</th>
				<th>Meal Price</th>
			</tr>
<%
	for(int i=0;i<arr.size();i++)
	{
		JSONObject jsonobj=(JSONObject)arr.get(i);
		String name=(String) jsonobj.get("name");
		Long flightid=(Long) jsonobj.get("id");
		String dof=(String)jsonobj.get("dof");
		String startdest=(String)jsonobj.get("start");
		String enddest=(String)jsonobj.get("end");
		String departure=(String) jsonobj.get("departure");
		String arrival=(String) jsonobj.get("arrival");
		String sno=(String) jsonobj.get("sno");
		String nos=(String) jsonobj.get("nos");
		String ticket=(String) jsonobj.get("ticket");
		String meals=(String) jsonobj.get("meals");
		%>
		<tr>
			<td>  	<%=flightid %>  </td>
			<td> 	<%=name %>  </td>
			<td> 	<%=sno %>  </td>
			<td> 	<%=dof %>  </td>
			<td> 	<%=startdest %>  </td>
			<td> 	<%=enddest %>  </td>
			<td> 	<%=departure %>  </td>
			<td> 	<%=arrival %>  </td>
			<td> 	<%=nos %>  </td>
			<td> 	<%=ticket %>  </td>
			<td> 	<%=meals %>  </td>
			<td>  <button name="book" value=<%=flightid %>>Book Tickets</button> </td>
		</tr>
	<%
	}
%>
</table>
</form>
<form method="get" action="user">
 	<p>Click <button>here </button> to search a flight</p>
</form>
<%} else{
		response.sendRedirect("userlogin.jsp");
	}%>

</body>
</html>