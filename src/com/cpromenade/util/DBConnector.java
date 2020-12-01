package com.cpromenade.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
	private final static String USERNAME = "anshuman";
	private final static String PASSWORD = "helloWorld";
	private final static String DB_NAME = "cpromenade_db";
	private final static String DB_URL = "jdbc:mysql://localhost:3306/" + DB_NAME;
	private final static String MYSQL_DRIVER = "com.mysql.cj.jdbc.Driver";
	
	public static Connection startConnection() {
		Connection connection = null;
		try {
			try {
				Class.forName(MYSQL_DRIVER);
			}catch(ClassNotFoundException e) {
				e.printStackTrace();
			}
			connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
			System.out.println("DBCONNECTOR: Connection established with "+ connection);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

}
