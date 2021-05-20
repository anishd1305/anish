<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirm</title>
</head>
<body>
<%

response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
HttpSession session1=request.getSession(false);
if(session1.getAttribute("id")!=null)
{
	JSONArray bookings=(JSONArray)request.getAttribute("bookings");
	Long id1=(Long)request.getAttribute("userid");
%>
<form method="post" action="cancel">
	<table>
		<tr>
		<td>User ID</td>
		<td><input type="text" name="userid" value=<%=id1 %> readonly="readonly"></td>
		</tr>
		<tr>
		<th>Name of Flight </th>
		<th>Flight id </th>
		<th>Date of Flight </th>
		<th>Start destination </th>
		<th>End destination </th>
		<th>Departure </th>
		<th>Arrival </th>
		<th>No. of seats booked </th>
		<th>Meals preferred </th>
		<th>Total Cost </th>
		</tr>
<%
		for(int j=0;j<bookings.size();j++)
		{
			JSONObject details=(JSONObject)bookings.get(j);
			boolean status=(boolean)details.get("activestatus");
			if(status){
			String nobs=(String)details.get("nobs");
			String nof=(String)details.get("nameofflight");
			String mealpref=(String)details.get("mealpref");
			String arrival=(String)details.get("arrival");
			String start=(String)details.get("start");
			Long flightid=(Long)details.get("flightid");
			String dof=(String)details.get("dof");
			String end=(String)details.get("end");
			String departure=(String)details.get("departure");
			Long ticketid=(Long)details.get("id");
			String totalcost=(String)details.get("totalcost");
%>
	<tr>
		<td>  <%=nof %>  </td>
		<td>  <%=flightid %>  </td>
		<td>  <%=dof %>  </td>
		<td>  <%=start %>  </td>
		<td>  <%=end %>  </td>
		<td>  <%=departure %>  </td>
		<td>  <%=arrival %>  </td>
		<td>  <%=nobs %>  </td>
		<td>  <%=mealpref %>  </td>
		<td>  <%=totalcost %>  </td>
		<td> <button name="button" value=<%=ticketid %>>Cancel</button>  </td>
	</tr>
	<%}
}
%>
</table>
</form>
<form method="get" action="user">
 	<p>Click <button>here </button> to search a flight</p>
</form>
<%}else{
	response.sendRedirect("userlogin.jsp");
} %>
</body>
</html>