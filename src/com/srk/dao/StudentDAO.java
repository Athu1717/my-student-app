package com.srk.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vo.Student;

public class StudentDAO {

    // ✅ PostgreSQL Connection
    public static Connection getConnection() throws Exception {
        Class.forName("org.postgresql.Driver");

        String url = "jdbc:postgresql://localhost:5432/testdb";
        String user = "postgres";
        String password = "your_password";

        return DriverManager.getConnection(url, user, password);
    }

    public static int saveStudent(Student std) {
        int status = 0;

        try {
            Connection con = StudentDAO.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO students(student_name, student_addr, student_age, student_qual, student_percent, student_year_passed) VALUES (?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, std.getStudentName());
            ps.setString(2, std.getStudentAddr());
            ps.setInt(3, std.getAge());
            ps.setString(4, std.getQualification());
            ps.setDouble(5, std.getPercentage());
            ps.setInt(6, std.getYearPassed());

            status = ps.executeUpdate();

            con.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return status;
    }

    public static int updateStudent(Student std) {
        int status = 0;

        try {
            Connection con = StudentDAO.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE students SET student_name=?, student_addr=?, student_age=?, student_qual=?, student_percent=?, student_year_passed=? WHERE student_id=?"
            );

            ps.setString(1, std.getStudentName());
            ps.setString(2, std.getStudentAddr());
            ps.setInt(3, std.getAge());
            ps.setString(4, std.getQualification());
            ps.setDouble(5, std.getPercentage());
            ps.setInt(6, std.getYearPassed());
            ps.setInt(7, std.getStudentId());

            status = ps.executeUpdate();

            con.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return status;
    }

    public static int deleteStudent(int stdId) {
        int status = 0;

        try {
            Connection con = StudentDAO.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM students WHERE student_id=?"
            );

            ps.setInt(1, stdId);

            status = ps.executeUpdate();

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public static Student getStudentById(int stdId) {
        Student student = new Student();

        try {
            Connection con = StudentDAO.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM students WHERE student_id=?"
            );

            ps.setInt(1, stdId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                student.setStudentId(rs.getInt("student_id"));
                student.setStudentName(rs.getString("student_name"));
                student.setStudentAddr(rs.getString("student_addr"));
                student.setAge(rs.getInt("student_age"));
                student.setQualification(rs.getString("student_qual"));
                student.setPercentage(rs.getDouble("student_percent"));
                student.setYearPassed(rs.getInt("student_year_passed"));
            }

            con.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return student;
    }

    public static List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();

        try {
            Connection con = StudentDAO.getConnection();

            PreparedStatement ps = con.prepareStatement("SELECT * FROM students");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setStudentName(rs.getString("student_name"));
                student.setStudentAddr(rs.getString("student_addr"));
                student.setAge(rs.getInt("student_age"));
                student.setQualification(rs.getString("student_qual"));
                student.setPercentage(rs.getDouble("student_percent"));
                student.setYearPassed(rs.getInt("student_year_passed"));

                students.add(student);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }
}
