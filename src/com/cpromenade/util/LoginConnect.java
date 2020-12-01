package com.cpromenade.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

import com.cpromenade.beans.LoginBean;

public class LoginConnect {
	Connection connection;
	private final String TABLE_NAME = "credentials";
	private final String COL_USERID = "userID";
	private final String COL_PASSWORD = "password";
	
	public LoginConnect(Connection connection){
		try {
			if(connection == null || connection.isClosed()) {
				System.out.println("ERROR: LOGIN_CONNECT: The provided connection is null or is closed");
			}
			else {
				this.connection = connection;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public LoginBean getLoginBeanByEmailId(String emailId) {
		LoginBean loginBean = null;
		try {
			String query = "SELECT userID,password FROM " + TABLE_NAME + " WHERE userID IN (SELECT userId FROM user WHERE email=?);";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, emailId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				loginBean = new LoginBean();
				loginBean.setUserId(rs.getInt("userID"));
				loginBean.setPassword(rs.getString("password"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return loginBean;
	}
	
	public LoginBean getLoginBeanByUserId(int userId) {
		LoginBean loginBean = null;
		try {
			String query = "SELECT * FROM " + TABLE_NAME + " WHERE userID='" + userId +"';";
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery(query);
			if(rs.next()) {
				int id = rs.getInt(COL_USERID);
				String password = rs.getString(COL_PASSWORD);
				loginBean = new LoginBean();
				loginBean.setUserId(userId);
				loginBean.setPassword(password);
				
			}
			else {
				System.out.println("LOGIN CONNECT: Email ID not present in database");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return loginBean;
	}
	
	public boolean storeLoginBean(LoginBean loginBean) {
		try {
			int userId = loginBean.getUserId();
			String password = loginBean.getPassword();
			String query = "INSERT INTO " + TABLE_NAME + " VALUES(?,?);";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setInt(1, userId);
			ps.setString(2, password);
			int row = ps.executeUpdate();
			return true;
		}catch(java.sql.SQLIntegrityConstraintViolationException e) {
			System.out.println("Email Id already present");
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean deleteLoginFromEmail(String emailId) {
		try {
			String query = "DELETE * FROM " + TABLE_NAME + " WHERE email='" + emailId +"';";
			Statement st = connection.createStatement();
			int row = st.executeUpdate(query);
			if(row == 1) {
				System.out.println("LOGIN CONNECT: Email ID deleted from credentials");
				return true;
			}
			else {
				System.out.println("LOGIN CONNECT: Email ID not present in database");
			}
		}catch(SQLException e) {
			System.out.println("ERRORCODE:" + e.getErrorCode());
			e.printStackTrace();
			return false;
		}
		return false;
	}
	
	/*public static void main(String[] args) {
		Connection con = DBConnector.startConnection();
		LoginConnect loginConnect = new LoginConnect(con);
		LoginBean loginBean = new LoginBean();
		loginBean.setEmail("gupta.anshuman20@gmail.com");
		loginBean.setPassword("helloWorld");
		if(loginConnect.storeLoginBean(loginBean)) {
			System.out.println("Email ID succesfully added");
		}
		else {
			System.out.println("Failed");
		}
		try {
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}*/

}
