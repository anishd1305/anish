package com.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class PostUser
 */
@WebServlet("/PostUser")
public class PostUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sb=new StringBuilder();
		BufferedReader reader=request.getReader();
		
		String line;
		while((line= reader.readLine())!=null)
		{
			sb.append(line).append('\n');
		}
		Object obj=new Object();
		JSONParser parser=new JSONParser();
		try {
			obj=parser.parse(sb.toString());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONObject j=(JSONObject)obj;
		HttpSession session=request.getSession(false);
		Long userid=(Long) session.getAttribute("id");
		Long ticket=(Long) j.get("bookid");
		File file=new File("C:\\Users\\User\\Desktop\\user_data1.json");
		Object obj1=new Object();
		try {
			obj1 = parser.parse(new FileReader(file));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		JSONArray arr=(JSONArray)obj1;
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
				for(int k=0;k<bookings.size();k++)
				{
					JSONObject details=(JSONObject)bookings.get(k);
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
	}

}
