<%@ include file="WEB-INF/header.jsp" %>
<%@ include file="WEB-INF/navbar.jsp" %>
<%@page import="com.ceritacintaku.repository.PostRepository"%> 
<%@page import="com.ceritacintaku.model.Post"%> 
<%@page import="java.util.List"%> 
<style>
    body {
        background-image: url('public/home-bg.jpg');
        font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
        }
</style>
<br>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header ">
                        <h2 style="font-weight: bold;"> Semua Cerita </h2>
                        <!-- kalo mau dikasih Search -->
                        <!-- <ul class="navbar-nav float-right">
                            <form class="form-inline" method="GET" action="/home">
                                <input name="cari" class="form-control mr-sm-2" type="search"
                                       placeholder="Search Jobs..." aria-label="Search">
                                <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </ul> -->
                    </div>
                    <%
                        PostRepository postRepository = new PostRepository();
                        List<Post> posts = postRepository.getAllPosts();
                        for(Post item: posts){%> 
                            <%
                                String title = item.getTitle();
                                title = title.length() > 30 ? title.substring(0,30)+"..." : title;
                                String description = item.getDescription();
                                description = description.length() > 25 ? description.substring(0,25)+"..." : description;
                            %>
                            <div class="list-group list-group-flush">
                                <a href="/ceritacintaku/post/show.jsp?id=<%=item.getId()%>" class="list-group-item list-group-item-action">
                                    <div class="d-flex">
                                        <small class="mb-1">
                                            Author: <%=item.getUser().getName()%>
                                        </small>
                                    </div>
                                    <p style="font-size: 18px; font-weight: 700"><%=title%></p>
                                    <small style="font-size:16px"><%=description%></small>
                                </a>
                            </div>
                        <%}
                    %>                    
                </div>
            </div>
        </div>
    </div>
<%@ include file="WEB-INF/footer.jsp" %>       





