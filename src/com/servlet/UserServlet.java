package com.servlet;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class UserServlet extends HttpServlet
{
	File file=new File("C:\\Users\\User\\Desktop\\user_data1.json");
	boolean flag=false;
	Long id1 = 0l;
	JSONArray jsonarray;
	JSONParser parser=new JSONParser();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String name="";
		String submit=request.getParameter("submit");
		if(submit!=null&&submit.equals("login")) {
		String gmail=request.getParameter("gmail");
		String password=request.getParameter("password");
		if(file.length()!=0)
		{
			Object obj1=new Object();
			try {
				obj1 = parser.parse(new FileReader(file));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			jsonarray=(JSONArray) obj1;
			Iterator<JSONObject> itr = jsonarray.iterator();
			while(itr.hasNext())
			{
				JSONObject jsonobj=(JSONObject)itr.next();
				String datagmail= (String)jsonobj.get("gmail");
				if(datagmail.equals(gmail))
				{
					String datapassword=(String)jsonobj.get("password");
					if(datapassword.equals(password))
					{
						name=(String)jsonobj.get("name");
						id1=(Long) jsonobj.get("id");							
						flag=true;
						break;
					}
				}
			}
			HttpSession session =request.getSession(true);
			session.setAttribute("id", id1);
			session.setAttribute("name1", name);
			request.setAttribute("flag", flag);
			request.setAttribute("id", id1);
			request.setAttribute("name", name);
			request.setAttribute("submit", submit);
			request.getRequestDispatcher("successuser.jsp").forward(request, response);
		}
		}
		else {
			HttpSession session=request.getSession(false);
			id1=(Long) session.getAttribute("id");
			name=(String) session.getAttribute("name1");
			flag=true;
			request.setAttribute("flag", flag);
			request.setAttribute("id", id1);
			request.setAttribute("name", name);
			request.getRequestDispatcher("successuser.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		String submit=request.getParameter("submit");
		String name=request.getParameter("name");
		String mail=request.getParameter("gmail");
		String dob=request.getParameter("date");
		String password=request.getParameter("password");
		JSONArray ticket=new JSONArray();
		JSONObject obj= new JSONObject();
		obj.put("name", name);
		obj.put("dob", dob);
		obj.put("gmail", mail);
		obj.put("password", password);
		obj.put("bookings", ticket);
		int id=0;
		if(file.length()!=0)
		{
			Object obj1=new Object();
			try {
				obj1 = parser.parse(new FileReader(file));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			jsonarray=(JSONArray) obj1;
			obj.put("id", 10001+jsonarray.size());
			id=(int)obj.get("id");
			id1=new Long(id);
			jsonarray.add(obj);
			FileWriter file1=new FileWriter(file);
			file1.write(jsonarray.toString());
			file1.flush();	
			flag=true;
			System.out.println(jsonarray.toString());
		}
		else
		{
			FileWriter file1=new FileWriter(file);
			jsonarray = new JSONArray();
			obj.put("id", 10001);
			id=(int)obj.get("id");
			id1=new Long(id);
			jsonarray.add(obj);
			file1.write(jsonarray.toString());
			file1.flush();
			flag=true;
		}
		HttpSession session =request.getSession(true);
		session.setAttribute("id", id1);
		session.setAttribute("name1", name);
		request.setAttribute("flag", flag);
		request.setAttribute("id", id1);
		request.setAttribute("name", name);
		request.setAttribute("submit", submit);
		request.getRequestDispatcher("successuser.jsp").forward(request, response);
	}

}
