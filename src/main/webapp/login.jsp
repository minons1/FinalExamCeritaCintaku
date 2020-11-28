
<%@ include file="/WEB-INF/header.jsp" %>
<%@ include file="/WEB-INF/navbar.jsp" %>
<style>
    body {
        background-image: url('public/home-bg.jpg');
        font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
        }
</style>

<br />
<main class="py-4 mt-4">
    <form action="login" method="post" class="d-flex justify-content-center">
        <div class="col-md-8 justify-content-between">
            <div class="card mb-5 bg-light">
                <div class="card-header">
                    <h2>Login</h2>
                </div>            
                <c:if test="${not empty wrong_auth}">
                    <div class="alert alert-danger" role="alert">
                        ${wrong_auth}
                    </div>
                    <c:set var="wrong_auth" value="" scope="session"/>
                </c:if>
                <div class="card-body">
                    <div class="form-horizontal">
                        <div class="form-group">                        
                            <label for="email">Email</label>
                            <div class="col-md-10">
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                        </div>
        
                        <div class="form-group">                        
                            <label for="password">Password</label>
                            <div class="col-md-10">
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                        </div>
        
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <input type="submit" value="Log In" class="btn btn-secondary" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</main>
<%@ include file="/WEB-INF/footer.jsp" %>    
