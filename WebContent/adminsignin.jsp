<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Signin</title>
</head>
<body>
<form method="post" action="admin">
	<table>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="name" required></td>
		</tr>
		<tr>
			<td>G-mail:</td>
			<td><input type="email" name="gmail" required></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td><input type="password" name="password" required></td>
		</tr>
		<tr>
			<td><input type="submit" value="signin" name="submit"></td>
		</tr>
	</table>
</form>
</body>
</html>