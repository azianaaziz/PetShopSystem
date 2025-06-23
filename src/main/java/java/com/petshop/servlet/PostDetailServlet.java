package com.petshop.servlet;

import com.petshop.model.PostDAO;
import com.petshop.model.CommentDAO;
import com.petshop.model.Post;
import com.petshop.model.Comment;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/post")
public class PostDetailServlet extends HttpServlet {
    private PostDAO postDAO = new PostDAO();
    private CommentDAO commentDAO = new CommentDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int postId = Integer.parseInt(request.getParameter("id"));
            Post post = postDAO.getPostById(postId);
            
            if (post != null) {
                List<Comment> comments = commentDAO.getCommentsByPostId(postId);
                request.setAttribute("post", post);
                request.setAttribute("comments", comments);
                request.getRequestDispatcher("/jsp/postdetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("petcommunity");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("petcommunity");
        }
    }
}