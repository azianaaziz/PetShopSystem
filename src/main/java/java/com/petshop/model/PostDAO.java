/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.petshop.model;

/**
 *
 * @author nurji
 */

import com.petshop.model.Post;
import cn.techtutorial.connection.DbCon;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    
    public boolean createPost(Post post) {
        String sql = "INSERT INTO posts (user_id, username, content, image_url, created_at) VALUES (?, ?, ?, ?, NOW())";
        
        try (Connection conn = DbCon.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, post.getUserId());
            stmt.setString(2, post.getUsername());
            stmt.setString(3, post.getContent());
            stmt.setString(4, post.getImageUrl());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, " +
                    "(SELECT COUNT(*) FROM post_likes WHERE post_id = p.post_id) as likes_count, " +
                    "(SELECT COUNT(*) FROM comments WHERE post_id = p.post_id) as comments_count " +
                    "FROM posts p ORDER BY p.created_at DESC";
        
        try (Connection conn = DbCon.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUsername(rs.getString("username"));
                post.setContent(rs.getString("content"));
                post.setImageUrl(rs.getString("image_url"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setLikesCount(rs.getInt("likes_count"));
                post.setCommentsCount(rs.getInt("comments_count"));
                posts.add(post);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return posts;
    }
    
    public Post getPostById(int postId) {
        String sql = "SELECT p.*, " +
                    "(SELECT COUNT(*) FROM post_likes WHERE post_id = p.post_id) as likes_count, " +
                    "(SELECT COUNT(*) FROM comments WHERE post_id = p.post_id) as comments_count " +
                    "FROM posts p WHERE p.post_id = ?";
        
        try (Connection conn = DbCon.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUsername(rs.getString("username"));
                post.setContent(rs.getString("content"));
                post.setImageUrl(rs.getString("image_url"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setLikesCount(rs.getInt("likes_count"));
                post.setCommentsCount(rs.getInt("comments_count"));
                return post;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean likePost(int postId, int userId) {
        String checkSql = "SELECT COUNT(*) FROM post_likes WHERE post_id = ? AND user_id = ?";
        String insertSql = "INSERT INTO post_likes (post_id, user_id) VALUES (?, ?)";
        String deleteSql = "DELETE FROM post_likes WHERE post_id = ? AND user_id = ?";
        
        try (Connection conn = DbCon.getConnection()) {
            // Check if already liked
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, postId);
            checkStmt.setInt(2, userId);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                // Unlike
                PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
                deleteStmt.setInt(1, postId);
                deleteStmt.setInt(2, userId);
                return deleteStmt.executeUpdate() > 0;
            } else {
                // Like
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, postId);
                insertStmt.setInt(2, userId);
                return insertStmt.executeUpdate() > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
        public boolean deletePost(int postId) {
        String sql = "DELETE FROM posts WHERE post_id = ?";

        try (Connection conn = DbCon.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, postId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}