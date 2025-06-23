<%-- 
    Document   : postdetails
    Created on : 22 Jun 2025, 1:00:34 am
    Author     : nurji
--%>

<%-- postdetail.jsp - Individual Post Detail Page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post by ${post.username} - Pet Community</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petcommunity.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="community-container">
        <div class="back-button">
            <a href="petcommunity">&lt; Back to Community</a>
        </div>
        
        <div class="post-detail">
            <div class="post-card">
                <div class="post-header">
                    <div class="user-avatar">
                        ${fn:substring(post.username, 0, 1).toUpperCase()}
                    </div>
                    <div class="user-info">
                        <h3>${post.username}</h3>
                        <span class="post-time">${post.timeAgo}</span>
                    </div>
                </div>
                
                <div class="post-content">
                    <p>${post.content}</p>
                    <c:if test="${not empty post.imageUrl}">
                        <div class="post-image">
                            <img src="${post.imageUrl}" alt="Pet photo" onerror="this.style.display='none'">
                        </div>
                    </c:if>
                </div>
                
                <div class="post-stats">
                    <span>❤️ ${post.likesCount} likes</span>
                    <span>💬 ${post.commentsCount} comments</span>
                </div>
            </div>
            
            <!-- Comments Section -->
            <div class="comments-detail">
                <h3>Comments</h3>
                
                <c:if test="${not empty sessionScope.userId}">
                    <form method="post" action="petcommunity" class="comment-form">
                        <input type="hidden" name="action" value="addComment">
                        <input type="hidden" name="postId" value="${post.postId}">
                        <textarea name="commentContent" placeholder="Write a comment..." required></textarea>
                        <button type="submit">Post Comment</button>
                    </form>
                </c:if>
                
                <div class="comments-list">
                    <c:choose>
                        <c:when test="${not empty comments}">
                            <c:forEach var="comment" items="${comments}">
                                <div class="comment">
                                    <div class="comment-avatar">
                                        ${fn:substring(comment.username, 0, 1).toUpperCase()}
                                    </div>
                                    <div class="comment-content">
                                        <strong>${comment.username}</strong>
                                        <p>${comment.content}</p>
                                        <small>${comment.createdAt}</small>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="no-comments">No comments yet. Be the first to comment!</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>