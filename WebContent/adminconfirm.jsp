<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="somemodule">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirm</title>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script src="module3.js"></script>
</head>
<body>
	<div ng-controller="modulectrl as mc">
		<div ng-show="mc.some">
			<p>Enter the unique code</p>
			<input type="text" ng-model="mc.ans">
			<form action="adminsignin.jsp">
				<button ng-if="mc.ans==mc.passcode">continue</button>
			</form>
		</div>
	</div>
</body>
</html>