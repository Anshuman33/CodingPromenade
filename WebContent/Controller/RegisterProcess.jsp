<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.time.LocalDate,com.cpromenade.util.DBConnector,com.cpromenade.util.RegisterConnectDB,java.sql.*" %>
<%@ page import="com.cpromenade.beans.UserBean,com.cpromenade.util.LoginConnect,com.cpromenade.beans.LoginBean" %>
<%
	String email = request.getParameter("emailInput");
	String pwd = request.getParameter("pwdInput");
	String firstName = request.getParameter("firstNameInput");
	String lastName = request.getParameter("lastNameInput");
	String gender = request.getParameter("genderInput");
	String dateOfBirth = request.getParameter("dobInput");
	
	Connection connection = DBConnector.startConnection();
	RegisterConnectDB regCon = new RegisterConnectDB(connection);
	UserBean userBean = new UserBean();
	userBean.setFirstName(firstName);
	userBean.setLastName(lastName);
	userBean.setEmailId(email);
	userBean.setGender(gender);
	userBean.setDateOfBirth(LocalDate.parse(dateOfBirth));
	int insertId = regCon.storeNewUserBean(userBean);
	out.println(insertId);
	if(insertId>0){
		out.println("New user registered");
		LoginConnect logCon = new LoginConnect(connection);
		LoginBean loginBean = new LoginBean();
		loginBean.setUserId(insertId);
		loginBean.setPassword(pwd);
		boolean loginStored = logCon.storeLoginBean(loginBean);
		if(loginStored){
			out.println("NEW LOGIN CREDENTIALS STORED");
			session.setAttribute("userId", insertId);
			response.sendRedirect("MyProfile");
		}
	}
	else{
		RequestDispatcher rd = request.getRequestDispatcher("Login");
		out.println("<script>alert('Account already exists with this email.')</script>");
		rd.include(request, response);
	}
	System.out.println(email + " " + pwd + " " + firstName + " " + lastName + " " + gender + " " + dateOfBirth);
	connection.close();
	
	
%>