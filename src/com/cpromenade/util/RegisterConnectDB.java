package com.cpromenade.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.Date;

import com.cpromenade.beans.UserBean;
public class RegisterConnectDB {
	Connection connection;
	private final String USER_TABLE = "user";
	private final String CREDENTIALS_TABLE = "credentials";
	private final String COL_USERID = "userId";
	private final String COL_FNAME = "fname";
	private final String COL_LNAME = "lname";
	private final String COL_EMAIL = "email";
	private final String COL_DOB = "dob";
	private final String COL_GENDER = "gender";
	
	
	public RegisterConnectDB(Connection connection){
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
	
	public int storeNewUserBean(UserBean userBean) {
		// This user bean would not be having userId
		String sql = "INSERT INTO " + USER_TABLE + "(fname,lname,email,gender,dob) VALUES(?,?,?,?,?);" ;
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, userBean.getFirstName());
			if(userBean.getLastName()!=null) {
				ps.setString(2, userBean.getLastName());
			}
			else {
				ps.setNull(2, Types.NULL);
			}
			ps.setString(3, userBean.getEmailId());
			ps.setString(4, userBean.getGender());
			LocalDate date = userBean.getDateOfBirth();
			ps.setDate(5, java.sql.Date.valueOf(date));
			ps.executeUpdate();
			
			// Get the last inserted ID
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery("SELECT LAST_INSERT_ID();");
			int id=0;
			if(rs.next()) {
					id = rs.getInt(1);
			}	
			return id;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
}
