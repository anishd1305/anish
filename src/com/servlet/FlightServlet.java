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

public class FlightServlet extends HttpServlet
{
	JSONParser parser=new JSONParser();
	File file=new File("C:\\Users\\User\\Desktop\\flight_data1.json");

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String submit=request.getParameter("submit");
		if(submit.equals("add")) 
		{
			String name=request.getParameter("name");
			String sno=request.getParameter("sno");
			String start=request.getParameter("start");
			String end=request.getParameter("final");
			String dof=request.getParameter("dof");
			String departure=request.getParameter("departure");
			String arrival=request.getParameter("arrival");
			String tnos=request.getParameter("tnos");
			String nos=request.getParameter("nos");
			String ticket=request.getParameter("ticket");
			String meals=request.getParameter("meals");
			
			JSONObject jsonobj=new JSONObject();
			jsonobj.put("name", name);
			jsonobj.put("sno", sno);
			jsonobj.put("start", start);
			jsonobj.put("end", end);
			jsonobj.put("dof", dof);
			jsonobj.put("departure", departure);
			jsonobj.put("arrival", arrival);
			jsonobj.put("tnos", tnos);
			jsonobj.put("nos", nos);
			jsonobj.put("ticket", ticket);
			jsonobj.put("meals", meals);
			jsonobj.put("surge", 0l);
			
			JSONArray jsonarray;
			if(file.length()!=0)
			{
				Object obj=new Object();
				try {
					obj = parser.parse(new FileReader(file));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				jsonarray=(JSONArray) obj;
				jsonobj.put("id", jsonarray.size()+20001);
				jsonarray.add(jsonobj);
			}
			else
			{
				jsonarray=new JSONArray();
				jsonobj.put("id", 20001);
				jsonarray.add(jsonobj);
			}
			FileWriter writer=new FileWriter(file);
			writer.write(jsonarray.toString());
			writer.flush();
			request.setAttribute("submit", submit);
			request.getRequestDispatcher("success.jsp").forward(request, response);
		}
		else if(submit.equals("done")) 
		{
			Long id=Long.parseLong(request.getParameter("id"));
			String name=request.getParameter("name");
			String sno=request.getParameter("sno");
			String start=request.getParameter("start");
			String end=request.getParameter("final");
			String dof=request.getParameter("dof");
			String departure=request.getParameter("departure");
			String arrival=request.getParameter("arrival");
			String tnos=request.getParameter("tnos");
			String nos=request.getParameter("nos");
			String ticket=request.getParameter("ticket");
			String meals=request.getParameter("meals");
			
			Object obj=new Object();
			try {
				obj = parser.parse(new FileReader(file));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONArray jsonarr=(JSONArray) obj;
			for(int i=0;i<jsonarr.size();i++)
			{
				JSONObject jsonobj=(JSONObject)jsonarr.get(i);
				Long objid=(Long)jsonobj.get("id");
				if(objid.equals(id))
				{
					jsonobj.put("name", name);
					jsonobj.put("sno", sno);
					jsonobj.put("start", start);
					jsonobj.put("end", end);
					jsonobj.put("dof", dof);
					jsonobj.put("departure", departure);
					jsonobj.put("arrival", arrival);
					jsonobj.put("tnos", tnos);
					jsonobj.put("nos", nos);
					jsonobj.put("ticket", ticket);
					jsonobj.put("meals", meals);
					break;
				}
			}
			FileWriter writer=new FileWriter(file);
			writer.write(jsonarr.toString());
			writer.flush();
			request.setAttribute("submit", submit);
			request.getRequestDispatcher("success.jsp").forward(request, response);
		}
		
		else if(submit.equals("delete"))
		{
			Long id=Long.parseLong(request.getParameter("id"));
			
			Object obj=new Object();
			try {
				obj = parser.parse(new FileReader(file));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONArray jsonarr=(JSONArray) obj;
			for(int i=0;i<jsonarr.size();i++)
			{
				JSONObject jsonobj=(JSONObject)jsonarr.get(i);
				Long objid=(Long)jsonobj.get("id");
				if(objid.equals(id))
				{
					jsonarr.remove(jsonobj);
					break;
				}
			}
			FileWriter writer=new FileWriter(file);
			writer.write(jsonarr.toString());
			writer.flush();
			request.getRequestDispatcher("success.jsp").forward(request, response);
		}
	}
	
}
