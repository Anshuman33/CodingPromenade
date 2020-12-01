package com.cpromenade.beans;

import java.time.LocalDate;
import java.util.List;
public class UserBean implements java.io.Serializable{
	private Integer userId;
	private String firstName;
	private String lastName;
	private String emailId;
	private String phoneNumber;
	private String gender;
	private String bio;
	private LocalDate dob;
	private String photoPath;
	private List<String> languages;
	private List<TaskBean> tasks;
	
	public UserBean(){
		userId = null;
		firstName = null;
		lastName = null;
		emailId = null;
		phoneNumber = null;
		gender = null;
		bio = null;
		dob = null;
		photoPath = null;
		languages = null;
		tasks = null;
	}
	
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	public void setEmailId(String emailAddress) {
		this.emailId = emailAddress;
	}
	
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public void setBio(String bio) {
		this.bio = bio; 
	}
	
	public void setDateOfBirth(LocalDate dateOfBirth) {
		this.dob = dateOfBirth;
	}
	
	public void setLanguages(List<String> languages) {
		this.languages = languages;
	}
	
	public void setTasks(List<TaskBean> tasks) {
		this.tasks = tasks;
	}
	
	public int getUserId() {
		return userId;
	}
	
	public String getFirstName() {
		return this.firstName;
	}
	
	public String getLastName() {
		return this.lastName;
	}
	
	public String getEmailId() {
		return this.emailId;
	}
	
	public String getPhone() {
		return this.phoneNumber;
	}
	
	public String getBio() {
		return this.bio;
	}
	
	public LocalDate getDateOfBirth() {
		return this.dob;
	}
	
	public List<String> getLanguages(){
		return this.languages;
	}

	public String getGender() {
		return gender;
	}

	public String getPhotoPath() {
		return photoPath;
	}

	public List<TaskBean> getTasks() {
		return tasks;
	}

}
