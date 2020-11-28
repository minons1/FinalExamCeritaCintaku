<%@ include file="/WEB-INF/header.jsp" %>
<%@ include file="/WEB-INF/navbar.jsp" %> 
<%@page import="com.ceritacintaku.repository.CommentRepository"%> 
<%@page import="com.ceritacintaku.model.Post"%> 
<%@page import="com.ceritacintaku.repository.PostRepository"%> 
<%@page import="com.ceritacintaku.model.Comment"%> 
<%@page import="com.ceritacintaku.model.User"%> 
<%@page import="java.util.List"%> 
<%@page import="javax.servlet.http.HttpSession"%>
<style>
    body {
        background-image: url('../public/bg-7.png');
        }
</style>
<main class="py-4">
    <div class="container mt-5 mb-5">
        <div class="d-flex justify-content-center row">
            <div class="col-md-8">
                <c:if test="${not empty wrong_auth}">
                    <div class="alert alert-danger" role="alert">
                        ${wrong_auth}
                    </div>
                    <c:set var="wrong_auth" value="" scope="session"/>
                </c:if>
                <c:if test="${not empty status}">
                    <div class="alert alert-success" role="alert">
                        ${status}
                    </div>
                    <c:set var="status" value="" scope="session"/>
                </c:if>       
                <a href="/ceritacintaku/posts.jsp" class="font-weight-bold" style="color:dark;">Kembali</a>
                <div class="card mb-4 p-4">
                    <%                        
                        Long post_id = Long.parseLong(request.getParameter("id"));
                        PostRepository postRepository = new PostRepository();
                        Post post = postRepository.getPost(post_id);
                    %>
                    <h5 class="card-title"><%=post.getTitle()%></h5>
                    <h6 class="card-subtitle mb-2 text-muted small">Author : <%=post.getUser().getName()%></h6>
                    <div class="dropdown-divider"></div>
                    <div class="card-body">
                        <p><%=post.getDescription()%></p>
                    </div>
                </div>
    
                <!-- BUAT KOMENTAR -->
                <h5> Tambahkan Komentar </h5>
                <form method="POST" action="comment/create">
                    <input type="hidden" name="id" value="<%=post.getId()%>">
                    <div class="form-group">
                        <textarea name="description" class="form-control" rows="3"></textarea>
                    </div>
                    <button class="btn btn-primary mb-5" type="submit">Post</button>
                </form>
    
                <!-- DAFTAR KOMENTAR -->
                <h3 class="mb-3">Komentar </h3>
                <%
                    CommentRepository commentRepository = new CommentRepository();
                    User user = (User) session.getAttribute("user");
                    List<Comment> comments = commentRepository.getPostComments(post_id);
                    for(Comment item: comments){%> 
                        <div class="card bg-white mb-3">
                            <div class="card-header">
                                <%if(item.getUser().getId() == user.getId()){%>
                                    <a class="nav-link nav-link-right dropdown-toggle float-right " role="button" data-toggle="dropdown"></a>
                                    <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                        <div class="d-flex" style="justify-content: space-around;">
                                            <a href="/ceritacintaku/comment/edit.jsp?id=<%=post_id%>&comment_id=<%=item.getId()%>" class="btn btn-warning "type="submit" >Edit</a>
                                        
                                            <form action="comment/delete" class="float-right " method="post">
                                                <input type="hidden" name="comment_id" value="<%=item.getId()%>">
                                                <button class="btn btn-danger "type="submit" >Hapus</button>
                                            </form>
                                        </div>
                                    </div>
                                <%}
                                %>
                                <div><%=item.getUser().getName()%></div>
                            </div>
                            <div class="comment-text-sm ml-3 mt-3 mb-3">
                                <span><%=item.getDescription()%></span>
                            </div>
                        </div>                        
                    <%}
                %>
            </div>
        </div>
    </div>
</main>
        <%@ include file="/WEB-INF/footer.jsp" %>