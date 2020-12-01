package com.cpromenade.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.ArrayList;

public class LangDBUtil {
	private String LANG_TABLE = "lang_preference";
	private String LANG_QUERY = "SELECT * FROM " + LANG_TABLE + " WHERE userId=?;";
	private String LANG_DELETE = "DELETE FROM " + LANG_TABLE + " WHERE userId=? AND language=?;";
	private String LANG_ADD = "INSERT IGNORE INTO " + LANG_TABLE + " VALUES(?,?);"; 
	
	Connection connection;
	private PreparedStatement langPS;
	private PreparedStatement langAddPS;
	private PreparedStatement langDeletePS;
	

	public LangDBUtil(Connection connection){
		try{
			if(connection == null || connection.isClosed()) {
				System.err.println("LANG_DB_UTIL: Connection reference null or is closed.");
			}
			else {
				this.connection = connection;
				langPS = connection.prepareStatement(LANG_QUERY);
				langAddPS = connection.prepareStatement(LANG_ADD);
				langDeletePS = connection.prepareStatement(LANG_DELETE);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<String> fetchLanguagesFromId(int userId) throws SQLException{
		List<String> list = null;
		try {
			langPS.setInt(1, userId);
			ResultSet rs = langPS.executeQuery();
			if(rs.next()) {
				list = new ArrayList<String>();
				do {
					list.add(rs.getString("language"));
				}while(rs.next());
			}
			while(rs.next()) {
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;

	}
	
	public boolean addLanguages(int userId,List<String> languages) {
		if(languages == null || languages.isEmpty())
			return true;
		try {
			int rows = 0;
			for(String language: languages) {
				langAddPS.setInt(1, userId);
				langAddPS.setString(2,language);
				rows += langAddPS.executeUpdate();
			}
			return true;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteLanguage(int userId,List<String> languages) {
		if(languages == null || languages.isEmpty())
			return true;
		try {
			int rows = 0;
			for(String language:languages) {
				langDeletePS.setInt(1, userId);
				langDeletePS.setString(2,language);
				rows += langDeletePS.executeUpdate();
			}
			
			if(rows>0) {
				return true;
			}
			else {
				return false;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
