<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*,java.nio.file.Files,java.nio.file.StandardCopyOption"%>
<%@ page import="com.cpromenade.util.UserDBUtil,com.cpromenade.beans.UserBean,com.cpromenade.util.DBConnector" %>
<%@ page import="java.sql.Connection" %>

<%
	Integer userId = (Integer) session.getAttribute("userId");
	if(userId != null){
		
		// Start UserDB Connection
		Connection connection = DBConnector.startConnection();
		UserDBUtil userDb = new UserDBUtil(connection); 
		
		// Fetch the UserBean
		UserBean user = userDb.fetchFromUserId(userId);
		
		
		// For multipart data i.e. the photo
		Part filePart = request.getPart("photo");
		boolean isPhotoPresent = false;
		if(filePart == null || filePart.getSize() == 0){
			System.out.println("Empty file part");
			isPhotoPresent = false;
		}
		else{
			System.out.println("File part present");
			isPhotoPresent = true;
		}
		
		// Get other parameters
		String fname = request.getParameter("firstName");
		if(fname!=null)
			user.setFirstName(fname);
		String lname = request.getParameter("lastName");
		if(lname!=null)
			user.setLastName(lname);
		String bio = request.getParameter("bio");
		if(bio!=null)
			user.setBio(bio);
		System.out.println(System.getProperty("user.dir"));
		File uploads = new File("D:/CodingPromenadeData/Profiles");
		String newFilePath = userId.toString() + ".png";
		File file = new File(uploads,newFilePath);
		try(InputStream in = filePart.getInputStream()){
			if(isPhotoPresent){
				Files.copy(in,file.toPath(),StandardCopyOption.REPLACE_EXISTING);
			}
			user.setPhotoPath("/CodingPromenadeData/Profiles/" + newFilePath);
			boolean b = userDb.updateUserProfile(user.getUserId(), user.getFirstName(), user.getLastName(), user.getPhotoPath(), user.getBio());
			if(b){
				out.println("Profile Update successful");
			}
			else{
				System.out.println("Profile Update Failed");
			}
		}catch(IOException e){
			e.printStackTrace();
		}
		response.sendRedirect("MyProfile");
		connection.close();
		//out.println("<br>uploaded:<img src='http://localhost:8080/CodingPromenadeData/Profiles/uploaded.png'>");
	}
%>
