package com.petshop.model;

import java.sql.Timestamp;

public class Post {
    private int postId;
    private int userId;
    private String username;
    private String content;
    private String imageUrl;
    private Timestamp createdAt;
    private int likesCount;
    private int commentsCount;
    
    // Constructors
    public Post() {}
    
    public Post(int userId, String username, String content, String imageUrl) {
        this.userId = userId;
        this.username = username;
        this.content = content;
        this.imageUrl = imageUrl;
    }
    
    // Getters and Setters
    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public int getLikesCount() { return likesCount; }
    public void setLikesCount(int likesCount) { this.likesCount = likesCount; }
    
    public int getCommentsCount() { return commentsCount; }
    public void setCommentsCount(int commentsCount) { this.commentsCount = commentsCount; }
    
    public String getTimeAgo() {
        if (createdAt == null) return "Just now";
        
        long diffInMillis = System.currentTimeMillis() - createdAt.getTime();
        long diffInSeconds = diffInMillis / 1000;
        long diffInMinutes = diffInSeconds / 60;
        long diffInHours = diffInMinutes / 60;
        long diffInDays = diffInHours / 24;
        
        if (diffInDays > 0) {
            return diffInDays + (diffInDays == 1 ? " day ago" : " days ago");
        } else if (diffInHours > 0) {
            return diffInHours + (diffInHours == 1 ? " hour ago" : " hours ago");
        } else if (diffInMinutes > 0) {
            return diffInMinutes + (diffInMinutes == 1 ? " minute ago" : " minutes ago");
        } else {
            return "Just now";
        }
    }
}
