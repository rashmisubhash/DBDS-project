package com.example.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.example.model.CustomerQuestions;

public class CustomerQuestionsDao {
    private String dbUrl = "jdbc:mysql://localhost:3306/userdb";
    private String dbUsername = "root";
    private String dbPassword = "villageit@";
    private String dbDriver = "com.mysql.cj.jdbc.Driver";

    // Load MySQL Driver
    public void loadDriver() {
        try {
            Class.forName(dbDriver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Get Database Connection
    public Connection getConnection() {
        Connection con = null;
        try {
            con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return con;
    }

    // Add a Question from Customer
    public void addQuestion(String customerId, String question) {
        String sql = "INSERT INTO customer_questions (customer_id, question, status, created_at) VALUES (?, ?, 'Pending', CURRENT_TIMESTAMP)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ps.setString(2, question);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Reply to a Question
    public void addReply(int questionId, String reply) {
        String sql = "UPDATE customer_questions SET reply = ?, status = 'Answered', replied_at = CURRENT_TIMESTAMP WHERE question_id = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, reply);
            ps.setInt(2, questionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Fetch Questions by Customer
    public List<CustomerQuestions> getQuestionsByCustomer(String customerId) {
        String sql = "SELECT * FROM customer_questions WHERE customer_id = ?";
        List<CustomerQuestions> questions = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                questions.add(new CustomerQuestions(
                        rs.getInt("question_id"),
                        rs.getString("customer_id"),
                        rs.getString("question"),
                        rs.getString("reply"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("replied_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    // Fetch Pending Questions for Representatives
    public List<CustomerQuestions> getPendingQuestions() {
        String sql = "SELECT * FROM customer_questions WHERE status = 'Pending'";
        List<CustomerQuestions> questions = new ArrayList<>();
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                questions.add(new CustomerQuestions(
                        rs.getInt("question_id"),
                        rs.getString("customer_id"),
                        rs.getString("question"),
                        rs.getString("reply"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("replied_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }
}
