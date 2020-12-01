package com.cpromenade.beans;

public class LoginBean implements java.io.Serializable{
	
	Integer userId;
	String password;
	public LoginBean(){
		this.userId = null;
		this.password = null;
	}
	public Integer getUserId() {
		return this.userId;
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

}
