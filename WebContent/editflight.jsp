<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Flight</title>
</head>
<body>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
	HttpSession session1=request.getSession(false);
	if(session1.getAttribute("name")!=null)
	{
		Long id=Long.parseLong(request.getParameter("id"));
		File file=new File("C:\\Users\\User\\Desktop\\flight_data1.json");
		JSONParser parser=new JSONParser();
		JSONArray jsonarr;
		
		Object obj=parser.parse(new FileReader(file));
		jsonarr=(JSONArray)obj;
		
		for(int i=0;i<jsonarr.size();i++)
		{
			JSONObject jsonobj=(JSONObject)jsonarr.get(i);
			Long objid=(Long)jsonobj.get("id");
			if(id.equals(objid))
			{
				String name=(String) jsonobj.get("name");
				String start=(String) jsonobj.get("start");
				String end=(String) jsonobj.get("end");
				String departure=(String) jsonobj.get("departure");
				String arrival=(String) jsonobj.get("arrival");
				String dof=(String) jsonobj.get("dof");
				String sno=(String) jsonobj.get("sno");
				String tnos=(String) jsonobj.get("tnos");
				String nos=(String) jsonobj.get("nos");
				String ticket=(String) jsonobj.get("ticket");
				String meals=(String) jsonobj.get("meals");
				%>
				<form method="post" action="flight">
					<table>
						<tr>
							<td>ID :</td>
							<td><input type="text" name="id" value=<%=objid %> readonly="readonly"></td>
						</tr>
						<tr>
							<td>Name :</td>
							<td><input type="text" name="name" value=<%=name %>></td>
						</tr>
						<tr>
							<td>Sno :</td>
							<td><input type="text" name="sno" value=<%=sno %>></td>
						</tr>
						<tr>
							<td>Starting destination:</td>
							<td>
								<select name="start">
								<option value="ANI">Andaman and Nicobar Islands</option>
								<option value="AP">Andhra Pradesh</option>
								<option value="BI">Bihar</option>
								<option value="CH">Chandigarh</option>
								<option value="DD">Daman and Diu</option>
								<option value="DE">Delhi</option>
								<option value="GOA">Goa</option>
								<option value="GU">Gujarat</option>
								<option value="HA">Haryana</option>
								<option value="HP">Himachal Pradesh</option>
								<option value="JK">Jammu and Kashmir</option>
								<option value="JH">Jharkhand</option>
								<option value="KA">Karnataka</option>
								<option value="KE">Kerala</option>
								<option value="TN">Tamil Nadu</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>Final destination:</td>
							<td>
								<select name="final">
								<option value="ANI">Andaman and Nicobar Islands</option>
								<option value="AP">Andhra Pradesh</option>
								<option value="BI">Bihar</option>
								<option value="CH" selected>Chandigarh</option>
								<option value="DD">Daman and Diu</option>
								<option value="DE">Delhi</option>
								<option value="GOA">Goa</option>
								<option value="GU">Gujarat</option>
								<option value="HA">Haryana</option>
								<option value="HP">Himachal Pradesh</option>
								<option value="JK">Jammu and Kashmir</option>
								<option value="JH">Jharkhand</option>
								<option value="KA">Karnataka</option>
								<option value="KE">Kerala</option>
								<option value="TN">Tamil Nadu</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>Date of Flight:</td>
							<td><input type="date" name="dof" value=<%=dof %> placeholder="dd-mm-yyyy" required></td>
						</tr>
						<tr>
							<td>Departure:</td>
							<td><input type="text" name="departure" value=<%=departure %> placeholder="hh:mm(24 hrs format)"></td>
						</tr>
						<tr>
							<td>Arrival:</td>
							<td><input type="text" name="arrival" value=<%=arrival %> placeholder="hh:mm(24 hrs format)"></td>
						</tr>
						<tr>
							<td>Total No.of Seats :</td>
							<td><input type="text" name="tnos" value=<%=tnos %>></td>
						</tr>
						<tr>
							<td>No.of Seats available:</td>
							<td><input type="text" name="nos" value=<%=nos %> readonly="readonly"></td>
						</tr>
						<tr>
							<td>Ticket price:</td>
							<td><input type="text" name="ticket" value=<%=ticket %>></td>
						</tr>
						<tr>
							<td>Meals Price:</td>
							<td><input type="text" name="meals" value=<%=meals %>></td>
						</tr>
						<tr>
							<td><input type="submit" name="submit" value="done"></td>
						</tr> 
						<tr>
							<td>Click to remove flight</td>
							<td><input type="submit" name="submit" value="delete"></td>
						</tr> 
					</table>
				</form>
				<%
				break;
			}
		}
	}else{
		request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
	}
%>

</body>
</html>