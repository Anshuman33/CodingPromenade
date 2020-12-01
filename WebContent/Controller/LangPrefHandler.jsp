<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,com.cpromenade.util.LangDBUtil,com.cpromenade.util.DBConnector,java.sql.Connection" %>
<%
	if(session.getAttribute("userId")!=null){
		int userId = (Integer)session.getAttribute("userId");
		
		String[] languages = request.getParameterValues("languages");
		
		// Fetch existing preferences
		Connection connection = DBConnector.startConnection();
		LangDBUtil langDb = new LangDBUtil(connection);
		
		List<String> existing = langDb.fetchLanguagesFromId(userId);
		List<String> newLang = null;
		if(languages!=null)
			newLang = Arrays.asList(languages);
		else
			newLang = new ArrayList<>();
		
		List<String> toBeDeleted = new ArrayList<>();
		if(existing != null){
			for(String language:existing){
				if(!newLang.contains(language)){
					System.out.println(language + " will be deleted");
					toBeDeleted.add(language);
				}
			}
		}
	
		
		if(langDb.addLanguages(userId, newLang)){
			System.out.println("Languages added successfully");
		
			if(langDb.deleteLanguage(userId, toBeDeleted)){
				System.out.println("Languages deleted successfully");
			}
		}
		else{
			System.out.println("Language updation failed");
		}
		connection.close();
		response.sendRedirect("MyProfile");
	}
	
	
%>