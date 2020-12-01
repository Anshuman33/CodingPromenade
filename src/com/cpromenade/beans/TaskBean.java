package com.cpromenade.beans;

import java.time.LocalDate;

public class TaskBean implements java.io.Serializable{
	
	private int userId;
	private int taskId;
	private String title;
	private String description;
	private LocalDate endDate;
	private byte status;
	
	public TaskBean() {
		this.userId = 0;
		this.taskId = 0;
		this.title = null;
		this.description = null;
		this.endDate = null;
		this.status = 0;
	}
	
	/* * * * * * * * * * * * SETTERS * * * * * * * * * * */
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public void setTaskId(int id) {
		this.taskId = id;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}
	
	public void setStatus(byte status) {
		this.status = status;
	}

	
	
	/* * * * * * * * * * * * GETTERS * * * * * * * * * * */
	public int getUserId() {
		return this.userId;
	}
	
	public int getTaskId() {
		return this.taskId;
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getDescription() {
		return description;
	}
	
	public LocalDate getEndDate() {
		return endDate;
	}

	public byte getStatus() {
		return status;
	}

	
		
}
