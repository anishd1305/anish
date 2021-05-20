package com.servlet;

import java.io.File;
import java.io.FileReader;
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
 * Servlet implementation class GetBookings
 */
@WebServlet("/GetBookings")
public class GetBookings extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBookings() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		Long id1=(Long) session.getAttribute("id");
		JSONParser parser=new JSONParser();
		File file2=new File("C:\\Users\\User\\Desktop\\user_data1.json");
		Object obj=new Object();
		try {
			obj = parser.parse(new FileReader(file2));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONArray arr=(JSONArray)obj;
		JSONArray bookings =null;
		for(int i=0;i<arr.size();i++)
		{
			JSONObject jsonobj=(JSONObject)arr.get(i);
			Long usrid=(Long)jsonobj.get("id");
			if(id1.equals(usrid))
			{
				bookings=(JSONArray)jsonobj.get("bookings");
			}
		}
		response.getWriter().append(bookings.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
