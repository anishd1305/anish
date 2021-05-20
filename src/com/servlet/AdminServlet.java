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

public class AdminServlet extends HttpServlet 
{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		boolean flag=false;
		String name="";
		
		String login=request.getParameter("login");
		if(login!=null&&login.equals("login"))
		{
			
		String gmail=request.getParameter("gmail");
		String password=request.getParameter("password");
			JSONParser parser=new JSONParser();
			File file=new File("C:\\Users\\User\\Desktop\\admin_data1.json");
			if(file.length()!=0)
			{
				Object obj1=new Object();
				try {
					obj1 = parser.parse(new FileReader("C:\\Users\\User\\Desktop\\admin_data1.json"));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				JSONArray jsonarray=(JSONArray) obj1;
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
							flag=true;
							break;
						}
					}
				}
			}
			HttpSession session=request.getSession();
			session.setAttribute("name", name);
			request.setAttribute("flag", flag);
			request.setAttribute("name", name);
			request.getRequestDispatcher("flightdetails.jsp").forward(request, response);
			}
		else {
			HttpSession session=request.getSession(false);
			request.setAttribute("name",session.getAttribute("name"));
			request.setAttribute("flag", true);
			request.getRequestDispatcher("flightdetails.jsp").forward(request, response);
		}
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			boolean flag=false;
			String name= request.getParameter("name");
			String gmail=request.getParameter("gmail");
			String password=request.getParameter("password");
			JSONObject obj= new JSONObject();
			obj.put("name", name);
			obj.put("gmail", gmail);
			obj.put("password", password);
			
				JSONParser parser=new JSONParser();
				File file=new File("C:\\Users\\User\\Desktop\\admin_data1.json");
					if(file.length()!=0)
						{
							
							Object obj1=new Object();
							try {
								obj1 = parser.parse(new FileReader(file));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							JSONArray jsonarray=(JSONArray) obj1;
							jsonarray.add(obj);
							FileWriter file1=new FileWriter("C:\\Users\\User\\Desktop\\admin_data1.json");
							file1.write(jsonarray.toString());
							file1.flush();	
							flag=true;
						}
					else
						{
							FileWriter file1=new FileWriter("C:\\Users\\User\\Desktop\\admin_data1.json");
							JSONArray jsonarray = new JSONArray();
							jsonarray.add(obj);
							file1.write(jsonarray.toString());
							file1.flush();
							flag=true;
						}
					HttpSession session=request.getSession();
					session.setAttribute("name", name);
					request.setAttribute("flag", flag);
					request.setAttribute("name", name);
					request.getRequestDispatcher("flightdetails.jsp").forward(request, response);
		}
}

