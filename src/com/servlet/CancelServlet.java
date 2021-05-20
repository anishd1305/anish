package com.servlet;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class CancelServlet extends HttpServlet
{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Long id1=Long.parseLong(request.getParameter("submit"));
		File file=new File("C:\\Users\\User\\Desktop\\user_data1.json");
		JSONParser parser=new JSONParser();
		Object obj=new Object();
		try {
			obj = parser.parse(new FileReader(file));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONArray arr=(JSONArray)obj;
		JSONArray bookings=new JSONArray();
		for(int i=0;i<arr.size();i++)
		{
			JSONObject jsonobj=(JSONObject)arr.get(i);
			Long usrid=(Long)jsonobj.get("id");
			if(id1.equals(usrid))
			{
				bookings=(JSONArray)jsonobj.get("bookings");
				break;
			}
		}
		request.setAttribute("bookings", bookings);
		request.setAttribute("userid", id1);
		request.getRequestDispatcher("cancellation.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Long userid=Long.parseLong(request.getParameter("userid"));
		Long ticket=Long.parseLong(request.getParameter("button"));
		File file=new File("C:\\Users\\User\\Desktop\\user_data1.json");
		JSONParser parser=new JSONParser();
		Object obj=new Object();
		try {
			obj = parser.parse(new FileReader(file));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		JSONArray arr=(JSONArray)obj;
		JSONArray bookings;
		Long fligh=0l;
		int nobs=0;
		
		for(int i=0;i<arr.size();i++)
		{
			JSONObject jsonobj=(JSONObject)arr.get(i);
			Long usrid=(Long)jsonobj.get("id");
			if(userid.equals(usrid))
			{
				bookings=(JSONArray)jsonobj.get("bookings");
				for(int j=0;j<bookings.size();j++)
				{
					JSONObject details=(JSONObject)bookings.get(j);
					Long ticketid=(Long)details.get("id");
					if(ticket.equals(ticketid))
					{
						nobs=Integer.parseInt((String)details.get("nobs"));
						fligh=(Long)details.get("flightid");
						details.put("activestatus", false);
						break;
					}
				}
				break;
			}
		}
		FileWriter writer=new FileWriter(file); 
		writer.write(arr.toString());
		writer.flush();
		
		
		file=new File("C:\\Users\\User\\Desktop\\flight_data1.json");
		try {
			obj=parser.parse(new FileReader(file));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		arr=(JSONArray)obj;
		for(int i=0;i<arr.size();i++)
		{
			JSONObject jsonobj=(JSONObject)arr.get(i);
			Long flightid=(Long)jsonobj.get("id");
			if(fligh.equals(flightid))
			{
				nobs=Integer.parseInt((String)jsonobj.get("nos"))+nobs;
				jsonobj.put("nos", String.valueOf(nobs));
				break;
			}
		}
		writer=new FileWriter(file); 
		writer.write(arr.toString());
		writer.flush();
		
		request.setAttribute("userid", userid);
		request.getRequestDispatcher("cancellationsuccess.jsp").forward(request, response);
	}
	
}
