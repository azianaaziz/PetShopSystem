/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.petshop.model;

/**
 *
 * @author nurji
 */
import java.sql.Timestamp;

public class Like {
    private int likeId;
    private int postId;
    private int userId;
    private Timestamp createdDate;

    // Default constructor
    public Like() {}

    // Constructor
    public Like(int postId, int userId) {
        this.postId = postId;
        this.userId = userId;
        this.createdDate = new Timestamp(System.currentTimeMillis());
    }

    // Getters and Setters
    public int getLikeId() { return likeId; }
    public void setLikeId(int likeId) { this.likeId = likeId; }

    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
}
