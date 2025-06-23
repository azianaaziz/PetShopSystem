/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.petshop.model;

/**
 *
 * @author nurji
 */
import java.sql.*;

public class LikeDAO {
    private Connection connection;

    public LikeDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean toggleLike(int postId, int userId) {
        if (isUserLiked(postId, userId)) {
            return removeLike(postId, userId);
        } else {
            return addLike(postId, userId);
        }
    }

    public boolean addLike(int postId, int userId) {
        String sql = "INSERT INTO post_likes (post_id, user_id, created_date) VALUES (?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeLike(int postId, int userId) {
        String sql = "DELETE FROM post_likes WHERE post_id = ? AND user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getLikeCount(int postId) {
        String sql = "SELECT COUNT(*) FROM post_likes WHERE post_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean isUserLiked(int postId, int userId) {
        String sql = "SELECT COUNT(*) FROM post_likes WHERE post_id = ? AND user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}