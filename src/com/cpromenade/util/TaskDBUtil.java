package com.cpromenade.util;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;

import com.cpromenade.beans.TaskBean;

import java.sql.CallableStatement;
import java.sql.Connection;

public class TaskDBUtil {
	// Connection variable
	Connection connection = null;
	
	// TaskStatus
	static public final byte STATUS_PENDING = 0;
	static public final byte STATUS_COMPLETED = 1;
	static public final byte STATUS_DELETED = 2;
	
	// Table Name
	private String TASK_TABLE = "task";

	// Useful Queries
	private String TASK_QUERY = "SELECT * FROM " + TASK_TABLE + " WHERE userId=? AND NOT status=" + STATUS_DELETED+ ";"; 
	private String UPDATE_TASK = "UPDATE " + TASK_TABLE + " SET title=?,description=?,status=?,endDate=? WHERE userId=? AND taskId=?;";
	private String UPDATE_TASK_STATUS = "UPDATE " + TASK_TABLE + " SET status=? WHERE userId=? AND taskId=?;";
	
	// Prepared Statement Objects 
	private PreparedStatement taskPS = null;
	private PreparedStatement updateTaskPS = null;
	private PreparedStatement updateTaskStatusPS = null;
	
	// Constructor takes in connection object for DB connection
	public TaskDBUtil(Connection connection){
		try{
			if(connection == null || connection.isClosed()) {
				System.err.println("TASK_DB_UTIL: Connection reference null or is closed.");
			}
			else {
				this.connection = connection;
				initPreparedStatements();
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// Setter for connection
	public void setConnection(Connection connection) {
		this.connection = connection;
	}
	
	// Initializes all prepared statements
	private void initPreparedStatements() throws SQLException{
		taskPS = connection.prepareStatement(TASK_QUERY);
		updateTaskPS = connection.prepareStatement(UPDATE_TASK);
		updateTaskStatusPS = connection.prepareStatement(UPDATE_TASK_STATUS);
		
	}
	
	// Fetches ArrayList of TaskBean object for a particular user from userId
	public ArrayList<TaskBean> fetchTasksFromId(int userId){
		ArrayList<TaskBean> list = null;
		try {
			taskPS.setInt(1, userId);
			ResultSet rs = taskPS.executeQuery();
			boolean tasksPresent = rs.next();
			if(tasksPresent) {
				list = new ArrayList<TaskBean>();
				do{
					TaskBean task = new TaskBean();
					task.setUserId(rs.getInt("userId"));
					task.setTaskId(rs.getInt("taskId"));
					task.setTitle(rs.getString("title"));
					task.setStatus(rs.getByte("status"));
					if(rs.getString("description") != null)
						task.setDescription(rs.getString("description"));
					if(rs.getString("endDate") != null)
						task.setEndDate(LocalDate.parse(rs.getString("endDate")));
					list.add(task);
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int storeNewTask(TaskBean taskBean) {
		int userId = taskBean.getUserId();
		String title = taskBean.getTitle();
		String description = taskBean.getDescription();
		LocalDate endDate = taskBean.getEndDate();
		
		try {
			// Find whether a query exists which is marked as deleted
			String sql = "SELECT taskId FROM " + TASK_TABLE + " WHERE userId=? AND status=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setByte(2, STATUS_DELETED);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				// If a deleted task is found, insert new task details at its place
				int taskId = rs.getInt("taskId");
				updateTaskPS.setString(1, title);
				updateTaskPS.setString(2, description);
				updateTaskPS.setByte(3,STATUS_PENDING);
				updateTaskPS.setDate(4, java.sql.Date.valueOf(endDate));
				updateTaskPS.setInt(5, userId);
				updateTaskPS.setInt(6, taskId);
				
				int row = updateTaskPS.executeUpdate();
				if(row == 1) {
					return taskId;
				}
			}
			else {
				// If no deleted task is found, insert a new row of task
				CallableStatement cs = connection.prepareCall("{CALL GetNoOfTasks(?,?)}");
				cs.setInt(1, userId);
				cs.registerOutParameter(2, Types.INTEGER);
				cs.execute();
				int newTaskId = cs.getInt(2) + 1;
				String insertNew = "INSERT INTO " + TASK_TABLE + " VALUES (?,?,?,?,?,?);";
				PreparedStatement psNew = connection.prepareStatement(insertNew);
				psNew.setInt(1, userId);
				psNew.setInt(2, newTaskId);
				psNew.setString(3, title);
				psNew.setString(4, description);
				psNew.setDate(5, java.sql.Date.valueOf(endDate));
				psNew.setByte(6, STATUS_PENDING);
				int row = psNew.executeUpdate();
				if(row == 1) {
					return newTaskId;
				}
				else
					return 0;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean deleteTask(int userId,int taskId) {
		try {
			updateTaskStatusPS.setByte(1, STATUS_DELETED);
			updateTaskStatusPS.setInt(2, userId);
			updateTaskStatusPS.setInt(3, taskId);
			int row = updateTaskStatusPS.executeUpdate();
			if(row > 0) {
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
	
	public boolean updateTask(TaskBean updatedTaskBean) {
		int userId = updatedTaskBean.getUserId();
		int taskId = updatedTaskBean.getTaskId();
		try {
			updateTaskPS.setString(1, updatedTaskBean.getTitle());
			updateTaskPS.setString(2, updatedTaskBean.getDescription());
			updateTaskPS.setByte(3, updatedTaskBean.getStatus());
			updateTaskPS.setInt(4, userId);
			updateTaskPS.setInt(5, taskId);
			int row = updateTaskPS.executeUpdate();
			if(row > 1) {
				return true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean checkTaskCompleted(int userId,int taskId) {
		try {
			updateTaskStatusPS.setByte(1, STATUS_COMPLETED);
			updateTaskStatusPS.setInt(2, userId);
			updateTaskStatusPS.setInt(3, taskId);
			int row = updateTaskStatusPS.executeUpdate();
			if(row > 0) {
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
	
	public boolean checkTaskPending(int userId,int taskId) {
		try {
			updateTaskStatusPS.setByte(1, STATUS_PENDING);
			updateTaskStatusPS.setInt(2, userId);
			updateTaskStatusPS.setInt(3, taskId);
			int row = updateTaskStatusPS.executeUpdate();
			if(row > 0) {
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
