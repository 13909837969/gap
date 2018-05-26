package com.ehtsoft.supervise.services;

import java.beans.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ehtsoft.fw.json.JSONArray;
import com.ehtsoft.fw.json.JSONObject;
import com.mongodb.connection.Connection;

public class lsswsHttpServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	//请求方式get
	protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,
	IOException{
		response.setContentType("application/json;charset=utf-8");//设置数据返回类型
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			java.sql.Connection connect = DriverManager.getConnection("/law/firms/unique");
			java.sql.Statement stmt = connect.createStatement();
			String sql = "select * from ";
			ResultSet rs = stmt.executeQuery(sql);
			ArrayList<Object> arrlist = new ArrayList<>();
			JSONObject jsonObj = new JSONObject();
			//展开结果集数据库
			while(rs.next()){
				jsonObj.put("姓名", rs.getInt("name"));
				
				arrlist.add(jsonObj);
			}
			//输出数据
			out.println(arrlist);
			rs.close();
			
		}catch(Exception e){
			out.println("get date error!");
		}
		
	}
	protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,
	IOException{
		doGet(request,response);
	}
}
