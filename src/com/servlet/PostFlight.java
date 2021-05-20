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
 * Servlet implementation class PostFlight
 */
@WebServlet("/PostFlight")
public class PostFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostFlight() {
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
		HttpSession session=request.getSession(false);
		Long userid=(Long) session.getAttribute("id");
		Long flightid=(Long)j.get("fid");
		Integer nobs=Integer.parseInt((String)j.get("nos"));
		String mealpref=(String)j.get("meal");
		boolean flag=true;
		Integer ticket=0;
		Integer meals=0;
		String name="";
		String dof="";
		String departure="";
		String arrival="";
		int totalcost=0;
		String username="";
		String startdst="";
		String enddst="";
		Integer nos=0;
		Long surge=0l;
		Integer tnos=0;
		
		File flightfile=new File("C:\\Users\\User\\Desktop\\flight_data1.json");
		
		Object obj1=new Object();
		try {
			obj1 = parser.parse(new FileReader(flightfile));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		JSONArray jsonarr1=(JSONArray)obj1;
		for(int i=0;i<jsonarr1.size();i++)
		{
			JSONObject jsonobj1=(JSONObject)jsonarr1.get(i);
			Long fltid=(Long)jsonobj1.get("id");
			
			if(fltid.equals(flightid))
			{
				nos=Integer.parseInt((String)jsonobj1.get("nos"));
				tnos=Integer.parseInt((String)jsonobj1.get("tnos"));
				ticket=Integer.parseInt((String)jsonobj1.get("ticket"));
				meals=Integer.parseInt((String)jsonobj1.get("meals"));
				name=(String)jsonobj1.get("name");
				dof=(String)jsonobj1.get("dof");
				departure=(String)jsonobj1.get("departure");
				arrival=(String)jsonobj1.get("arrival");
				startdst=(String)jsonobj1.get("start");
				enddst=(String)jsonobj1.get("end");
				surge=(Long)jsonobj1.get("surge");
						
				if(nobs>nos)
				{
					flag=false;
				}
				else
				{
					nos=nos-nobs;
					if((long)((tnos-nos)/10)>surge) 
					{
						surge=(long) ((tnos-nos)/10);
						int ti=ticket+(int) (ticket*0.05);
						jsonobj1.put("ticket", String.valueOf(ti));
						jsonobj1.put("surge", surge);
					}
					jsonobj1.put("nos", String.valueOf(nos));
				}
				break;
			}
		}
		FileWriter writer=new FileWriter(flightfile);
		writer.write(jsonarr1.toString());
		writer.flush();
		if(flag)
		{
			File userfile=new File("C:\\Users\\User\\Desktop\\user_data1.json");
			try {
				obj1=parser.parse(new FileReader(userfile));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			jsonarr1=(JSONArray)obj1;
			for(int i=0;i<jsonarr1.size();i++)
			{
				JSONObject jsonobj1=(JSONObject)jsonarr1.get(i);
				Long usrid=(Long)jsonobj1.get("id");
				if(usrid.equals(userid))
				{
					username=(String)jsonobj1.get("name");
					JSONObject details=new JSONObject();
					details.put("activestatus",true);
					details.put("nameofflight", name);
					details.put("flightid", flightid);
					details.put("dof", dof);
					details.put("departure", departure);
					details.put("arrival", arrival);
					details.put("nobs", String.valueOf(nobs));
					details.put("mealpref", mealpref);
					details.put("start", startdst);
					details.put("end", enddst);
					totalcost=mealpref.equals("yes")?(nobs*meals):0;
					totalcost+=(nobs*ticket);
					details.put("totalcost", String.valueOf(totalcost));
					JSONArray bookings=(JSONArray)jsonobj1.get("bookings");
					details.put("id", bookings.size()+1);
					bookings.add(details);
					break;
				}
			}
			writer=new FileWriter(userfile);
			writer.write(jsonarr1.toString());
			writer.flush();
		}
		
	}

}
