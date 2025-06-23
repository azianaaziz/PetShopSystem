package com.petshop.servlet;

import com.petshop.model.Post;
import com.petshop.model.Comment;
import com.petshop.model.PostDAO;
import com.petshop.model.CommentDAO;

import java.io.*;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/petcommunity")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class PetCommunityServlet extends HttpServlet {
    private PostDAO postDAO = new PostDAO();
    private CommentDAO commentDAO = new CommentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Post> posts = postDAO.getAllPosts();
        request.setAttribute("posts", posts);
       request.getRequestDispatcher("community.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if ("createPost".equals(action)) {
            handleCreatePost(request, response, session);
        } else if ("likePost".equals(action)) {
            handleLikePost(request, response, session);
        } else if ("addComment".equals(action)) {
            handleAddComment(request, response, session);
        }
        else if ("deletePost".equals(action)) {
    handleDeletePost(request, response, session);
}

    }

    private void handleCreatePost(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        Integer userId = (Integer) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");

        if (userId == null || username == null) {
            response.sendRedirect("login.jsp?redirect=petcommunity");
            return;
        }

        String content = request.getParameter("content");
        Part imageFilePart = request.getPart("imageFile");
        String fileName = Paths.get(imageFilePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String imagePath = null;
        if (fileName != null && !fileName.isEmpty()) {
            imageFilePart.write(uploadPath + File.separator + fileName);
            imagePath = "uploads/" + fileName;
        }

        if (content != null && !content.trim().isEmpty()) {
            Post post = new Post(userId, username, content.trim(), imagePath);
            postDAO.createPost(post);
        }

        response.sendRedirect("petcommunity");
    }

    private void handleLikePost(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp?redirect=petcommunity");
            return;
        }

        try {
            int postId = Integer.parseInt(request.getParameter("postId"));
            postDAO.likePost(postId, userId);
        } catch (NumberFormatException ignored) {}

        response.sendRedirect("petcommunity");
    }

    private void handleAddComment(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        Integer userId = (Integer) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");

        if (userId == null || username == null) {
            response.sendRedirect("login.jsp?redirect=petcommunity");
            return;
        }

        try {
            int postId = Integer.parseInt(request.getParameter("postId"));
            String content = request.getParameter("commentContent");

            if (content != null && !content.trim().isEmpty()) {
                Comment comment = new Comment(postId, userId, username, content.trim());
                commentDAO.createComment(comment);
            }
        } catch (NumberFormatException ignored) {}

        response.sendRedirect("petcommunity");
    }
    
    
    private void handleDeletePost(HttpServletRequest request, HttpServletResponse response, HttpSession session)
        throws ServletException, IOException {
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        int postId = Integer.parseInt(request.getParameter("postId"));

        // Optional: check if the post belongs to the user before deleting
        Post post = postDAO.getPostById(postId);
        if (post != null && post.getUserId() == userId) {
            postDAO.deletePost(postId);
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }

    response.sendRedirect("petcommunity");
}

}
