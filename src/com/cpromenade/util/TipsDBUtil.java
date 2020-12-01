package com.cpromenade.util;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.lang.Math;

import com.cpromenade.beans.TipBean;

public class TipsDBUtil {
	Connection connection;
	
	public TipsDBUtil(Connection connection){
		try {
			if(connection == null || connection.isClosed()) {
				System.out.println("ERROR: TIPS_DB_UTIL: The provided connection is null or is closed");
			}
			else {
				this.connection = connection;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public TipBean fetchTipsByLanguage(List<String> languages) {
		String langString = "";
		TipBean tipBean = null;
		if(languages!=null && !languages.isEmpty()) {
			for(String language:languages) {
				langString = langString.concat(",'"+language + "'");
			}
		}
		String sql = "SELECT * FROM tips WHERE language IN ('GENERAL'" + langString + ")";
		try {
			Statement st = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ResultSet rs = st.executeQuery(sql);
			if(rs.next()) {
				rs.last();
				int rows = rs.getRow();
				rs.beforeFirst();
				int i = (int)(Math.random() * rows) + 1;
				rs.absolute(i);
				tipBean = new TipBean();
				tipBean.setTipId(rs.getInt("tipId"));
				tipBean.setTitle(rs.getString("title"));
				tipBean.setLanguage(rs.getString("language"));
				tipBean.setDescription(rs.getString("description"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return tipBean;
		
	}
	
	
	
	

}
