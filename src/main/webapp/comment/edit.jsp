<%@ include file="/WEB-INF/header.jsp" %>
<%@ include file="/WEB-INF/navbar.jsp" %>
<%@page import="com.ceritacintaku.repository.PostRepository"%> 
<%@page import="com.ceritacintaku.repository.CommentRepository"%> 
<%@page import="com.ceritacintaku.model.Post"%> 
<%@page import="com.ceritacintaku.model.Comment"%> 
<%@page import="com.ceritacintaku.model.User"%> 
<%@page import="javax.servlet.http.HttpSession"%>
    <br>
    <br>
<style>
    .container-create-post:hover{
        transform:translateY(5px);
    }
</style>
<br />

<div class="page-header clear-filter" filter-color="orange">
    <div class="page-header-image" data-parallax="true">
    </div>
    <div class="container container-create-post shadow p-5" style="transition:all ease 0.3s;background:#ddd;border-radius:10px">
        <form action="update" method="post">
            <div class="d-flex justify-content-center" style="text-transform:uppercase">
                <h3>Edit Comment</h3>
            </div>
            <c:if test="${not empty wrong_auth}">
                <div class="alert alert-danger" role="alert">
                    ${wrong_auth}
                </div>
                <c:set var="wrong_auth" value="" scope="session"/>
            </c:if>
            <div class="form-group">
                <%
                    User user = (User) session.getAttribute("user");
                    Long post_id = Long.parseLong(request.getParameter("id"));
                    Long comment_id = Long.parseLong(request.getParameter("comment_id"));
                    CommentRepository commentRepository = new CommentRepository();
                    Comment comment = commentRepository.getComment(comment_id);
                    if (user.getId() != comment.getUser().getId()) {
                        response.sendRedirect(request.getHeader("referer"));
                    }
                %>
                <label for="description">Comment</label>
                <input type="hidden" name="id" value="<%=comment.getPost().getId()%>">
                <input type="hidden" name="comment_id" value="<%=comment.getId()%>">
                <textarea  placeholder="" class="form-control" id="description" type="text" name="description" style="background-color: white" height="auto" rows="7" ><%=comment.getDescription()%></textarea>
            </div>
            <button class="btn btn-secondary" type="submit">
                Edit
            </button>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/footer.jsp" %>       