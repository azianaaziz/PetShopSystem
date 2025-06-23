/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.petshop.model;

/**
 *
 * @author nurji
 */

import cn.techtutorial.connection.DbCon;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
    
    public boolean createComment(Comment comment) {
        String sql = "INSERT INTO comments (post_id, user_id, username, content, created_at) VALUES (?, ?, ?, ?, NOW())";
        
        try (Connection conn = DbCon.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, comment.getPostId());
            stmt.setInt(2, comment.getUserId());
            stmt.setString(3, comment.getUsername());
            stmt.setString(4, comment.getContent());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Comment> getCommentsByPostId(int postId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM comments WHERE post_id = ? ORDER BY created_at ASC";
        
        try (Connection conn = DbCon.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPostId(rs.getInt("post_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setUsername(rs.getString("username"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                comments.add(comment);
            }
            
        } catch (SQLException e) {
        }
        
        return comments;
    }
}