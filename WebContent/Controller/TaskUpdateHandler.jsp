<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.Connection,com.cpromenade.util.TaskDBUtil,com.cpromenade.util.DBConnector"  %>
<%
	Integer userId = (Integer) session.getAttribute("userId");
	if(userId != null){
		//String job = request.getParameter("job");
		
			int taskId = Integer.parseInt(request.getParameter("taskId"));
			int newStatus = Integer.parseInt(request.getParameter("newStatus"));
			Connection connection = DBConnector.startConnection();
			TaskDBUtil taskDBUtil = new TaskDBUtil(connection);
			if(newStatus == TaskDBUtil.STATUS_COMPLETED){
				if(taskDBUtil.checkTaskCompleted(userId, taskId))
					System.out.println("Task " + taskId + " changed to completed.");
			}
			else if(newStatus == TaskDBUtil.STATUS_PENDING){
				if(taskDBUtil.checkTaskPending(userId, taskId)){
					System.out.println("Task " + taskId + " changed to pending.");
				}
			}
			else{
				if(taskDBUtil.deleteTask(userId, taskId)){
					System.out.println("Task " + taskId + " deleted");
				}
			}
			
		
	
	}
	

%>