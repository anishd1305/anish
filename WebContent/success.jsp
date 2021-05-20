<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.File"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success</title>
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
	HttpSession session1=request.getSession(false);
	if(session1.getAttribute("name")!=null)
	{
	JSONParser parser=new JSONParser();
	File file=new File("C:\\Users\\User\\Desktop\\flight_data1.json");
	String submit=(String)request.getAttribute("submit");

	if(submit!=null&&submit.equals("add"))
	{
		%>
		<h1>Flight Successfully added</h1>
		<% 
	}
	if(submit!=null&&submit.equals("done"))
	{
		%>
		<h1>Flight Successfully Updated</h1>
		<% 
	}
	%><%
	if(file.length()!=0)
	{
		Object obj=parser.parse(new FileReader(file));
		JSONArray jsonarr=(JSONArray) obj;
	%>
	<form action="editflight.jsp">
	<table>
		<tr>
			<th>S.no</th>
			<th>Name</th>	
			<th>Date</th>
			<th>Starting</th>
			<th>Destination</th>
			<th>Departure</th>
			<th>Arrival</th>
		</tr>
	<% 
		for(int i=0;i<jsonarr.size();i++)
		{
			JSONObject object=(JSONObject)jsonarr.get(i);
			
			Long id=(Long) object.get("id");
			String name=(String) object.get("name");
			String start=(String) object.get("start");
			String end=(String) object.get("end");
			String departure=(String) object.get("departure");
			String arrival=(String) object.get("arrival");
			String dof=(String) object.get("dof");
		%>
			<tr>
			<td>  <%=id %>  </td>
			<td>  <%=name %>  </td>
			<td>  <%=dof %>  </td>
			<td>  <%=start %>  </td>
			<td>  <%=end %>  </td>
			<td>  <%=departure %>  </td>
			<td>  <%=arrival %>  </td>
			</tr>
		<%
		}
		%>
		</table>
		<table>
		<tr>
			<td>Enter the S.no of the flight to be edited</td>
			<td><input type="text" name="id" size="1" required></td>
			<td> <input type="submit" value="edit" name="submit"> </td>
		</tr>
		</table>
		</form>
		<form method="get" action="admin">
			<p>Click <button name="login" value="redirect"> here</button> to enter a new flight</p>
		</form>
		<% 	
	}
	}else{
		request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
	}
%>
	
</body>
</html>