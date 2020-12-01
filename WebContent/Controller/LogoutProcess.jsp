<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	if(session.getAttribute("userId")!=null){
		session.invalidate();
	}
	response.sendRedirect("Login");	
%>