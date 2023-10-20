package com.postgres.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	// create the table..
	public void createTable() {
		var query = "CREATE TABLE student (id SERIAL PRIMARY KEY, name varchar(255) NOT NULL, city varchar(255) NOT NULL)";
		int update = this.jdbcTemplate.update(query);
		System.out.println("***** Table create query executed " + update);
	}

	// adding data to database...
	public void insertData(String name, String city) {
		String insertQuery = "INSERT INTO student (name, city) VALUES (?, ?)";
		int update = jdbcTemplate.update(insertQuery, name, city);
		System.out.println("*****Data inserted successfully " + update);
	}
}
