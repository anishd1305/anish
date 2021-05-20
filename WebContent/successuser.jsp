<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.JSONObject"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular-route.js"></script>
<script src="module3.js"></script>
</head>
<body ng-controller="modulectrl as mc">
<%
	response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	HttpSession session1=request.getSession(false);
	if(session1.getAttribute("id")!=null)
	{
	Boolean flag=(Boolean)request.getAttribute("flag");
	Long id1=(Long)request.getAttribute("id");
	String name=(String)request.getAttribute("name");
	String submit=(String)request.getAttribute("submit");
	if(flag)
	{
		if(submit!=null&&submit.equals("Signin"))
		{
		%>
			<h1>Welcome <%=name %>. Your User id is <%=id1 %> </h1>		
		<%
		}
		else if(submit!=null&&submit.equals("login"))
		{
		%>
			<h1>Welcome <%=name %>.</h1>
		<%
		}
		if(flag)
		{
			%>
			<form name="searchfli">
			<h2>Enter the details to search for flights</h2>
				<table ng-init="mc.id='<%=id1 %>'">
					<tr>
						<td>User ID:</td>
						<td><input type="text" ng-model="mc.id" readonly="readonly"></td>
					</tr>
					<tr>
						<td>Date of Flight:</td>
						<td><input type="date" ng-model="mc.dof" min="2021-04-29" required></td>
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
					<td>Enter the No. of tickets: </td>
					<td><input type="text" ng-model="mc.nof" required></td>
				</tr>
				<tr>
					<td>Meals Prefrence: </td>
					<td><input type="radio" ng-model="mc.mp" value="yes" required>Yes</td>
					<td><input type="radio" ng-model="mc.mp" value="no"> No</td>
				</tr>
				<tr>
					<td><button ng-disabled="!searchfli.$valid" ng-click="mc.collectdata()">search</button></td>
				</tr>
				<tr ng-show="mc.showfilteredflights">
								<th>S.no</th>
								<th>Name</th>	
								<th>Date</th>
								<th>Starting</th>
								<th>Destination</th>
								<th>Departure</th>
								<th>Arrival</th>
								<th>Ticket price</th>
				</tr>
				<tr ng-show="mc.showfilteredflights" ng-repeat="x in mc.flights">
				
						<td ng-if="x.start==mc.start && x.end==mc.final">{{$index+1}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final">{{x.name}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final">{{x.dof}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final">{{x.start}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final">{{x.end}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final">{{x.departure}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final">{{x.arrival}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final">{{x.ticket}}</td>
						<td ng-if="x.start==mc.start && x.end==mc.final"><button ng-click="mc.book(x.id)">book</button></td>
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
								<th>Ticket price</th>
							</tr>
						
							<tr ng-repeat="x in mc.flights">
								<td>  {{x.id}} </td>
								<td>  {{x.name}}  </td>
								<td>  {{x.dof}}  </td>
								<td>  {{x.start}}  </td>
								<td>  {{x.end}}  </td>
								<td>  {{x.departure}}  </td>
								<td>  {{x.arrival}}  </td>
								<td>  {{x.ticket}}  </td>
							</tr>
							
							</table>
							</form>
			</div>
			
			<div>
				<button ng-click="mc.showbookingdetails()" ng-show="!mc.bookdetails">Click here to get all the booking details</button>
				<button ng-click="mc.hidebookingdetails()" ng-show="mc.bookdetails">Click here minimize booking details</button>
				<div ng-show="mc.bookdetails">
						<form>
							<table>
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
							<tr ng-repeat="y in mc.bookings" >
								<td ng-if="y.activestatus">  <span ng-bind="y.nameofflight"></span> </td>
								<td ng-if="y.activestatus">  {{y.flightid}}  </td>
								<td ng-if="y.activestatus">  {{y.dof}}  </td>
								<td ng-if="y.activestatus">  {{y.start}}  </td>
								<td ng-if="y.activestatus">  {{y.end}}  </td>
								<td ng-if="y.activestatus">  {{y.departure}}  </td>
								<td ng-if="y.activestatus">  {{y.arrival}}  </td>
								<td ng-if="y.activestatus">  {{y.nobs}}  </td>
								<td ng-if="y.activestatus">  {{y.mealpref}}  </td>
								<td ng-if="y.activestatus">  {{y.totalcost}}  </td>
								<td ng-if="y.activestatus">  <button ng-click="mc.cancel(y.id)">Cancel</button></td>
							</tr>
							
						</table>
						</form>
				</div>
			</div>
			
			<div ng-show="mc.paymentdetails">
				<button ng-click="mc.getpaymentdetails()">Payment Details</button>
			</div>
			<div ng-show="mc.showpaymentdetails">
				<form>
					<table>
						<tr>
						<td>Name of Flight:</td>
						<td>{{mc.payment.nameofflight}}</td>
						</tr>
						<tr>
						<td>Flight ID:</td>
						<td>{{mc.payment.flightid}}</td>
						</tr>
						<tr>
						<td>Starting Destination: </td>
						<td>{{mc.payment.start}}</td>
						</tr>
						<tr>
						<td>Ending Destination: </td>
						<td>{{mc.payment.end}}</td>
						</tr>
						<tr>
						<td>Departure: </td>
						<td>{{mc.payment.departure}}</td>
						</tr>
						<tr>
						<td>Arrival: </td>
						<td>{{mc.payment.arrival}}</td>
						</tr>
						<tr>
						<td>Meals Preferred: </td>
						<td>{{mc.payment.mealpref}}</td>
						</tr>
						<tr>
						<td>Total Cost: </td>
						<td>{{mc.payment.totalcost}}</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
			<%
		}%>
		<form action="logout" method="post">
			<button>Logout</button>
		</form>
	<%
	}
	else{
		%>
		<h1>Invalid Login</h1>
		<% 
	}
	}else{
		response.sendRedirect("userlogin.jsp");
	}
%>
</body>
</html>