<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.io.File"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="somemodule">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script src="module3.js"></script>
</head>
<body ng-controller="modulectrl as mc">
<%
	response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	HttpSession session1=request.getSession(false);
	if(session1.getAttribute("name")!=null)
	{
		%>
		<a href="logout" style="margin-left:1300px;">Logout</a>
		<% 
	boolean flag=(boolean)request.getAttribute("flag");
	String name=(String)request.getAttribute("name");
	if(flag){
	%>
	<h1>Welcome <%=name!=null?name:"" %></h1>
	<h1>Enter the Flight details</h1>
		<form name="addfli">
			<table>
				<tr>
				<td>Name of the Flight:</td>
				<td><input type="text" ng-model="mc.name" required></td>
				</tr>
				<tr>
				<td>Serial no. of the Flight:</td>
				<td><input type="text" ng-model="mc.sno" required></td>
				</tr>
				<tr>
					<td>Starting destination:</td>
					<td>
						<select ng-model="mc.start">
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
						<select ng-model="mc.final">
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
					<td><input type="date" ng-model="mc.dof" placeholder="dd-mm-yyyy" min="2021-04-29" required></td>
				</tr>
				<tr>
					<td>Departure:</td>
					<td><input type="text" ng-model="mc.departure" placeholder="in 24 hrs format(hh:mm)" required></td>
				</tr>
				<tr>
					<td>Arrival:</td>
					<td><input type="text" ng-model="mc.arrival" placeholder="in 24 hrs format(hh:mm)" required></td>
				</tr>
				<tr>
					<td>Total No.of Seats :</td>
					<td><input type="text" ng-model="mc.tnos" required></td>
				</tr>
				<tr>
					<td>No.of Seats available:</td>
					<td><input type="text" ng-model="mc.nos" required></td>
				</tr>
				<tr>
					<td>Ticket price:</td>
					<td><input type="text" ng-model="mc.ticket" required></td>
				</tr>
				<tr>
					<td>Meals Price:</td>
					<td><input type="text" ng-model="mc.meals" required></td>
				</tr>
				<tr>
					<td><button  ng-disabled="!addfli.$valid" ng-click="mc.addflight()">Add</button></td>
				</tr>
			</table>
			
		</form>
		<div>
			<button ng-click="mc.showflightdetails()" ng-show="!mc.flightdetails">Click here to get all the flight details</button>
			<button ng-click="mc.hideflightdetails()" ng-show="mc.flightdetails">Click here minimize flight details</button>
			<div ng-show="mc.flightdetails">
						<form>
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
						
							<tr ng-repeat="x in mc.flights">
								<td>  {{x.id}}  </td>
								<td>  {{x.name}}  </td>
								<td>  {{x.dof}}  </td>
								<td>  {{x.start}}  </td>
								<td>  {{x.end}}  </td>
								<td>  {{x.departure}}  </td>
								<td>  {{x.arrival}}  </td>
								<td> <button ng-click="mc.editflight(x)">Edit</button> </td>
								<td> <button ng-click="mc.deleteflight(x.id)">Delete</button></td>
							</tr>
							</table>
						</form>
						
				<form name="editfli" ng-show="mc.showeditdetails">
					<table>
						<tr>
							<td>ID :</td>
							<td><input type="text" ng-model="mc.tfd.id" readonly="readonly"></td>
						</tr>
						<tr>
							<td>Name :</td>
							<td><input type="text"  ng-model="mc.tfd.name"></td>
						</tr>
						<tr>
							<td>Sno :</td>
							<td><input type="text" ng-model="mc.tfd.sno"></td>
						</tr>
						<tr>
							<td>Starting destination:</td>
							<td>
								<select ng-model="mc.tfd.start">
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
								<select ng-model="mc.tfd.end">
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
							<td><input type="date" ng-model="mc.newdate"  min="2021-04-29" placeholder="dd-mm-yyyy" required></td>
						</tr>
						<tr>
							<td>Departure:</td>
							<td><input type="text" ng-model="mc.tfd.departure"  placeholder="hh:mm(24 hrs format)"></td>
						</tr>
						<tr>
							<td>Arrival:</td>
							<td><input type="text" ng-model="mc.tfd.arrival" placeholder="hh:mm(24 hrs format)"></td>
						</tr>
						<tr>
							<td>Total No.of Seats :</td>
							<td><input type="text" ng-model="mc.tfd.tnos" ></td>
						</tr>
						<tr>
							<td>No.of Seats available:</td>
							<td><input type="text" ng-model="mc.tfd.nos"  readonly="readonly"></td>
						</tr>
						<tr>
							<td>Ticket price:</td>
							<td><input type="text" ng-model="mc.tfd.ticket" ></td>
						</tr>
						<tr>
							<td>Meals Price:</td>
							<td><input type="text" ng-model="mc.tfd.meals"  ></td>
						</tr>
						<tr>
							<td><button  ng-disabled="!editfli.$valid" ng-click="mc.doneedit()">Done</button></td>
							<td><button ng-show="mc.showeditdetails" ng-click="mc.canceledit()">Cancel</button></td>
						</tr> 
					</table>
				</form>	
				
			</div>
	</div>
	<% }
	if(!flag){
		%>
	<h1> Invalid Login </h1>
	<% }
	}else{
		response.sendRedirect("adminlogin.jsp");
	}
%>
</body>
</html>