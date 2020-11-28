<%@ include file="/WEB-INF/header.jsp" %>
<%@ include file="/WEB-INF/navbar.jsp" %>    
<%@page import="com.ceritacintaku.repository.PostRepository"%> 
<%@page import="com.ceritacintaku.model.Post"%> 
<%@page import="com.ceritacintaku.model.User"%> 
<%@page import="java.util.List"%> 
<%@page import="javax.servlet.http.HttpSession"%>
    <style>
        body {
            background-image: url('public/bg-7.png');
            }
    </style>
    <br>
    <br>
    <br />
    
    <div class="row justify-content-center ">    
        <div class="col-md-8 "> 
            <c:if test="${not empty status}">
                <div class="alert alert-success" role="alert">
                    ${status}
                </div>
                <c:set var="status" value="" scope="session"/>
            </c:if>       
            <c:if test="${not empty wrong_auth}">
                <div class="alert alert-danger" role="alert">
                    ${wrong_auth}
                </div>
                <c:set var="wrong_auth" value="" scope="session"/>
            </c:if>       
            <div class="pull-left">
                <h2 style="font-weight: bold;">Semua Ceritaku</h2>
            </div>
            <div class="pull-right">
                <a class="btn btn-success" href="create.jsp"> Buat Cerita Baru</a>
            </div>
        </div>
    </div>
    <div class="row justify-content-center "> 
        <table class="table table-bordered table-hover col-md-8 bg-light" style="table-layout: fixed">
            <tr>
                <th width="50px">No</th>
                <th>Judul</th>
                <th>Ceritamu</th>
                <th width="280px">Action</th>
            </tr>
            <tbody>
                <%
                    PostRepository postRepository = new PostRepository();
                    User user = (User) session.getAttribute("user");
                    List<Post> posts = postRepository.getUserPosts(user.getId());
                    for(Post item: posts){%> 
                        <%
                            String title = item.getTitle();
                            title = title.length() > 30 ? title.substring(0,30)+"..." : title;
                            String description = item.getDescription();
                            description = description.length() > 30 ? description.substring(0,30)+"..." : description;
                        %>
                        <tr>
                            <td><%=item.getId()%></td>
                                <td style="word-wrap: break-word"><%=title%></td>
                                <td style="word-wrap: break-word">
                                    <%=description%>
                                </td>
                            <td class="d-flex justify-content-center">
                                <a class="btn btn-info mr-2" href="show.jsp?id=<%=item.getId()%>">Lihat</a>
                                <a class="btn btn-primary mr-2" href="edit.jsp?id=<%=item.getId()%>">Edit</a>
                                <form action="delete" method="post" id="delete-form">
                                    <input type="hidden" name="id" value="<%=item.getId()%>">
                                    <a class="btn btn-danger" href="delete" onclick="event.preventDefault();
                                                                        document.getElementById('delete-form').submit();">
                                        Hapus
                                    </a>
                                </form>
                                
                            </td>
                        </tr>
                    <%}
                %>
            </tbody>
        </table>
    </div>
<%@ include file="/WEB-INF/footer.jsp" %>