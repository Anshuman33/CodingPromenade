<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="com.cpromenade.util.UserDBUtil,com.cpromenade.util.DBConnector,com.cpromenade.beans.UserBean" %>
<%@ page import="java.time.LocalDate,java.sql.Connection" %>
<%
	if(session.getAttribute("userId")!=null){
		int userId = (Integer)session.getAttribute("userId");
		
		// Connecting to DB
		Connection connection = DBConnector.startConnection();
		UserDBUtil userDb = new UserDBUtil(connection);
		UserBean userBean = userDb.fetchFromUserId(userId);
		
		// Fetching form data
		String emailId = request.getParameter("emailId");
		if(emailId != null)
			userBean.setEmailId(emailId);
		LocalDate dob = LocalDate.parse(request.getParameter("dateOfBirth"));
		if(dob!=null){
			userBean.setDateOfBirth(dob);
		}
		String phone = request.getParameter("phone");
		if(phone!=null)
			userBean.setPhoneNumber(phone);
		String gender = request.getParameter("gender");
		if(gender!=null){
			userBean.setGender(gender);
		}
				
		// Updating the details
		if(userDb.updateUserDetails(userBean.getUserId(), userBean.getEmailId(), userBean.getPhone(), userBean.getDateOfBirth(), userBean.getGender())){
			System.out.println("Update Successful");
		}else{
			System.out.println("Update Failed");
		}
		
		connection.close();
		response.sendRedirect("MyProfile");
		
		
	}
%>
