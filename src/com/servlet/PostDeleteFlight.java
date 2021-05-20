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
 * Servlet implementation class PostDeleteFlight
 */
@WebServlet("/PostDeleteFlight")
public class PostDeleteFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostDeleteFlight() {
        super();
        // TODO Auto-generated constructor stub
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
				jsonarr.remove(jsonobj);
				break;
			}
		}
		FileWriter writer=new FileWriter(file);
		writer.write(jsonarr.toString());
		writer.flush();
	}

}
