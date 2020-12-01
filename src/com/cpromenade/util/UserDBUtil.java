package com.cpromenade.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.time.LocalDate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cpromenade.beans.UserBean;

public class UserDBUtil {
	Connection connection;
	
	private String USER_TABLE = "user";
	
	private String USER_QUERY = "SELECT * FROM " + USER_TABLE + " WHERE userId=?;";
	private String USER_UPDATE = "UPDATE " + USER_TABLE + " SET email=?,phone=?,dob=?,gender=? WHERE userId=?";
	private String PROFILE_UPDATE = "UPDATE " + USER_TABLE + " SET fname=?,lname=?,photoPath=?,bio=? WHERE userId=?;";
	private PreparedStatement userPS;
	private PreparedStatement userUpdatePS;
	private PreparedStatement userProfilePS;

	
	public UserDBUtil(Connection connection) {
		try{
			if(connection == null || connection.isClosed()) {
				System.err.println("USER_DB_UTIL: Connection reference null or is closed.");
			}
			else {
				this.connection = connection;
				userPS = connection.prepareStatement(USER_QUERY);
				userUpdatePS = connection.prepareStatement(USER_UPDATE);
				userProfilePS = connection.prepareStatement(PROFILE_UPDATE);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public UserBean fetchFromUserId(int userId) {
		UserBean userBean = null;
		try {
			userPS.setInt(1, userId);
			ResultSet userResult = userPS.executeQuery();
			if(userResult.next()) {
				// Set the attributes of userBean from the fetched result
				userBean = new UserBean();
				userBean.setUserId(userId);
				userBean.setFirstName(userResult.getString("fname"));
				if(userResult.getString("lname")!=null);
					userBean.setLastName(userResult.getString("lname"));
				userBean.setEmailId(userResult.getString("email"));
				if(userResult.getString("phone")!=null)
					userBean.setPhoneNumber(userResult.getString("phone"));
				if(userResult.getString("photoPath")!=null)
					userBean.setPhotoPath(userResult.getString("photoPath"));
				if(userResult.getString("bio")!=null)
					userBean.setBio(userResult.getString("bio"));
				userBean.setDateOfBirth(LocalDate.parse(userResult.getString("dob")));
				userBean.setGender(userResult.getString("gender"));
				TaskDBUtil taskDBUtil = new TaskDBUtil(connection);
				userBean.setTasks(taskDBUtil.fetchTasksFromId(userId));
				LangDBUtil langDBUtil = new LangDBUtil(connection);
				userBean.setLanguages(langDBUtil.fetchLanguagesFromId(userId));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return userBean;
	}
	
	
	public boolean updateUserDetails(int userId, String emailId, String phone, LocalDate dob , String gender) {
		try {
			userUpdatePS.setString(1,emailId);
			if(phone != null)
				userUpdatePS.setString(2,phone);
			else
				userUpdatePS.setNull(2, Types.VARCHAR);
			userUpdatePS.setDate(3, java.sql.Date.valueOf(dob));
			userUpdatePS.setString(4,gender);
			userUpdatePS.setInt(5,userId);
			int row = userUpdatePS.executeUpdate();
			if(row>0)
				return true;
			else
				return false;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateUserProfile(int userId,String firstName, String lastName,String photoPath, String bio) {
		String sql = "UPDATE " + USER_TABLE + " SET fname='" + firstName + "',lname='" + lastName + "',photoPath='" + photoPath + "',bio='" + bio + "' where userId="+userId + ";";
		System.out.println(sql);
		try {
			/*
			userProfilePS.setString(1, firstName);
			userProfilePS.setString(2, lastName);
			userProfilePS.setString(3, photoPath);
			userProfilePS.setString(4, bio);
			userProfilePS.setInt(5, userId);
			int row = userUpdatePS.executeUpdate();*/
			int row = connection.createStatement().executeUpdate(sql);
			if(row>0)
				return true;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
