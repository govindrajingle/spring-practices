package com.student.manage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StudentDao {
	public static boolean insertStudentToDB(Student st) {
		boolean f = false;
		// JDBC code to insert data to DB
		try {
			Connection con = CP.createC();
			String q = "insert into students(sname, sphone, scity) values(?, ?, ?)";
			// prepared statement
			PreparedStatement pstmt = con.prepareStatement(q);
			// set values of parameters
			pstmt.setString(1, st.getStudentName());
			pstmt.setString(2, st.getStudentPhone());
			pstmt.setString(3, st.getStudentCity());
			// execute
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return f;
	}

	public static boolean deleteStudent(int userId) {
		// TODO Auto-generated method stub
		boolean f = false;
		// JDBC code to delete data from DB
		try {
			Connection con = CP.createC();
			String q = "delete from student_manage.students where sid=?";
			// prepared statement
			PreparedStatement pstmt = con.prepareStatement(q);
			// set values of parameters
			pstmt.setInt(1, userId);
			// execute
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return f;
	}

	//chat gpt
	public static void showAllStudent() {
		try {
			Connection con = CP.createC();
			String q = "select * from students";
			PreparedStatement pstmt = con.prepareStatement(q);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int studentId = rs.getInt("sid");
				String studentName = rs.getString("sname");
				String studentPhone = rs.getString("sphone");
				String studentCity = rs.getString("scity");
				// Display student information
				System.out.println("Student ID: " + studentId);
				System.out.println("Student Name: " + studentName);
				System.out.println("Student Phone: " + studentPhone);
				System.out.println("Student City: " + studentCity);
				System.out.println("====================");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
