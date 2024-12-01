package com.example.model;

import java.sql.Timestamp;

public class CustomerQuestions {
    private int questionId;
    private String customerId;
    private String question;
    private String reply;
    private String status;
    private Timestamp createdAt;
    private Timestamp repliedAt;

    public CustomerQuestions(int questionId, String customerId, String question, String reply, String status, Timestamp createdAt, Timestamp repliedAt) {
        this.questionId = questionId;
        this.customerId = customerId;
        this.question = question;
        this.reply = reply;
        this.status = status;
        this.createdAt = createdAt;
        this.repliedAt = repliedAt;
    }

    public CustomerQuestions() {}

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getRepliedAt() {
        return repliedAt;
    }

    public void setRepliedAt(Timestamp repliedAt) {
        this.repliedAt = repliedAt;
    }
}
