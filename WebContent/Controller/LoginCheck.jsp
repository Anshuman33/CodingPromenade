<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%----------------------------------------  IMPORT BEAN CLASSES------------------------------------------%>
<%@ page import="com.cpromenade.beans.LoginBean" %>

<%-------------------------------------IMPORT LOCAL UTILITY CLASSES -------------------------------------%>
<%@ page import="com.cpromenade.util.DBConnector,com.cpromenade.util.LoginConnect" %>

<%---------------------------------------- IMPORT OTHER CLASSES --------------------------------------%>
<%@ page import="java.sql.Connection" %>


<%-------------------------------- JAVA CODE FOR VERIFICATION START HERE --------------------------------%>
<%
	// Fetch request parameters
	String emailId = request.getParameter("emailId");
	String password = request.getParameter("password");
	
	// Start database connection
	Connection connection = DBConnector.startConnection();
	LoginConnect login = new LoginConnect(connection);
	
	// Fetch LoginBean from database corresponding to the provided emailID
	LoginBean loginBean = login.getLoginBeanByEmailId(emailId);
	
	// Close database connection
	connection.close();
	
	if(loginBean!=null){
		if(loginBean.getPassword().contentEquals(password)){
			System.out.println("Login Successful. User Id: " + loginBean.getUserId());
			session.setAttribute("userId",loginBean.getUserId());
			/*RequestDispatcher rd = request.getRequestDispatcher("Dashboard.jsp");
			rd.forward(request, response);*/
			response.sendRedirect("Dashboard");
			return;
		}
		/*else{
			
		}*/
	}
	out.println("<script>alert('Either the email or password is incorrect')</script>");
	RequestDispatcher rd = request.getRequestDispatcher("Login");
	rd.include(request,response);
	
	
	

%>
