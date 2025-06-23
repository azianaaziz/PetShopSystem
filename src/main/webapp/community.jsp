<%-- 
    Document   : PetCommunity
    Created on : 22 Jun 2025, 12:12:46 am
    Author     : nurji
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="cn.techtutorial.model.User" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    request.setAttribute("userId", userId);
    User auth = (User) session.getAttribute("auth");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pet Community</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petcommunity.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="css/navbar.css" />
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="community-container">
        <div class="community-header">
            <h1><span class="pet-text">Pet</span><span class="highlight">Community</span></h1>
            <p>Connect with other pet lovers, share stories, and ask questions.</p>
        </div>

        <div class="create-post-section">
            <c:choose>
                <c:when test="${not empty userId}">
                    <button class="create-post-btn" onclick="toggleCreatePost()">
                        <span class="plus-icon">+</span> Create New Post
                    </button>

                    <div id="createPostForm" class="create-post-form" style="display: none;">
                        <form method="post" action="petcommunity" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="createPost">
                            <div class="form-group">
                                <textarea name="content" placeholder="Share your pet moment..." required maxlength="500"></textarea>
                            </div>
                            <div class="form-group">
                                <input type="file" name="imageFile" accept="image/*">
                            </div>
                            <div class="form-actions">
                                <button type="button" onclick="toggleCreatePost()" class="cancel-btn">Cancel</button>
                                <button type="submit" class="submit-btn">Share Post</button>
                            </div>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="login-prompt">
                        <p>Please <a href="login.jsp">login</a> to share your pet moments!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="posts-feed">
            <c:choose>
                <c:when test="${not empty posts}">
                    <c:forEach var="post" items="${posts}">
                        <div class="post-card">
                            <div class="post-header">
                                <div class="user-avatar">${fn:substring(post.username, 0, 1).toUpperCase()}</div>
                                <div class="user-info">
                                    <h3>${post.username}</h3>
                                    <span class="post-time">${post.timeAgo}</span>
                                </div>
                            </div>
                            <div class="post-content">
                                <p>${post.content}</p>
                                <c:if test="${not empty post.imageUrl}">
                                    <div class="post-image">
                                        <img src="${pageContext.request.contextPath}/${post.imageUrl}" alt="Pet photo" onerror="this.style.display='none'">
                                    </div>
                                </c:if>
                            </div>
                            <div class="post-actions">
    <c:choose>
        <c:when test="${not empty userId}">
            <form method="post" action="petcommunity" style="display: inline;">
                <input type="hidden" name="action" value="likePost">
                <input type="hidden" name="postId" value="${post.postId}">
                <button type="submit" class="like-btn">❤️ ${post.likesCount}</button>
            </form>
        </c:when>
        <c:otherwise>
            <span class="like-btn">❤️ ${post.likesCount}</span>
        </c:otherwise>
    </c:choose>

    <button class="comment-btn" onclick="toggleComments(${post.postId})">💬 ${post.commentsCount}</button>
    <a href="post?id=${post.postId}" class="view-btn">View Details</a>
</div>


                           
                            <c:if test="${post.userId == userId}">
    <form method="post" action="petcommunity" style="display: inline;">
        <input type="hidden" name="action" value="deletePost">
        <input type="hidden" name="postId" value="${post.postId}">
        <button type="submit" class="delete-btn">🗑 Delete</button>
    </form>
</c:if>


                            <div id="comments-${post.postId}" class="comments-section" style="display: none;">
                                <c:if test="${not empty userId}">
                                    <form method="post" action="petcommunity" class="comment-form">
                                        <input type="hidden" name="action" value="addComment">
                                        <input type="hidden" name="postId" value="${post.postId}">
                                        <input type="text" name="commentContent" placeholder="Add a comment..." required>
                                        <button type="submit">Send</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-posts">
                        <h3>You haven't posts yet!</h3>
                        <p>Let's share your pet moment with the community.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        function toggleCreatePost() {
            const form = document.getElementById('createPostForm');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }

        function toggleComments(postId) {
            const comments = document.getElementById('comments-' + postId);
            comments.style.display = comments.style.display === 'none' ? 'block' : 'none';
        }

        setTimeout(() => {
            const messages = document.querySelectorAll('.message, .error');
            messages.forEach(msg => msg.style.display = 'none');
        }, 3000);
    </script>
</body>
</html>
