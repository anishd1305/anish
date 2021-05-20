package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Logoutservlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		 HttpSession session=request.getSession(false); 
		 session.setAttribute("name", null);
         session.invalidate(); 
         response.sendRedirect("adminlogin.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		 HttpSession session=request.getSession(false);  
         session.invalidate(); 
         request.getRequestDispatcher("userlogin.jsp").forward(request, response);
	}
	
	
}
