
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="java.time.LocalDate,java.sql.Connection" %>
<%@page import="com.cpromenade.util.TaskDBUtil,com.cpromenade.beans.TaskBean,com.cpromenade.util.DBConnector"%>

<%
	Integer userId = (Integer) session.getAttribute("userId");
	if(userId != null){
		System.out.println("UserId check passed");
		String title = request.getParameter("taskTitle");
		String description = request.getParameter("taskDescription");
		System.out.println("Inside Task Processing");
		LocalDate endDate = LocalDate.parse(request.getParameter("taskEndDate"));
		Connection connection = DBConnector.startConnection();
		TaskDBUtil taskDBUtil = new TaskDBUtil(connection);
		TaskBean taskBean = new TaskBean();
		taskBean.setTitle(title);
		taskBean.setDescription(description);
		taskBean.setEndDate(endDate);
		taskBean.setUserId(userId);
		if(taskDBUtil.storeNewTask(taskBean)>0){
			response.setContentType("text/html");
			out.print("SUCCESS");
			System.out.println("storing success");

		}
		else{
			System.out.println("storing failed");
			out.print("FAIL");
		}
	}
		
	//System.out.println(title + " " + description + " " + endDate);
	
%>    
