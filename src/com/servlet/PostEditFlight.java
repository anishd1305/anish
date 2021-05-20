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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class PostEditFlight
 */
@WebServlet("/PostEditFlight")
public class PostEditFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostEditFlight() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
    	response.getWriter().append("yes");
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
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
		
		Long id=(Long)j.get("id");
		String name=(String)j.get("name");
		String sno=(String)j.get("sno");
		String start=(String)j.get("start");
		String end=(String)j.get("end");
		String dof=(String)j.get("dof");
		String departure=(String)j.get("departure");
		String arrival=(String)j.get("arrival");
		String tnos=(String)j.get("tnos");
		String nos=(String)j.get("nos");
		String ticket=(String)j.get("ticket");
		String meals=(String)j.get("meals");
		
		File file=new File("C:\\Users\\User\\Desktop\\flight_data1.json");
		Object obj1=new Object();
		try {
			obj1 = parser.parse(new FileReader(file));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONArray jsonarr=(JSONArray) obj1;
		
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
	}

}
