<%@ include file="/WEB-INF/header.jsp" %>
<%@ include file="/WEB-INF/navbar.jsp" %>

<style>
    body {
        background-image: url('public/home-bg.jpg');
        font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
        }
</style>

<br />

<main class="py-4 mt-4">
    <form action="register" method="post" class="d-flex justify-content-center">
        <div class="col-md-8 justify-content-between">
            <div class="card bg-light mb-5">
                <div class="card-header">
                    <h2>Sign Up</h2>
                </div>
                <c:if test="${not empty wrong_auth}">
                    <div class="alert alert-danger" role="alert">
                        ${wrong_auth}
                    </div>
                    <c:set var="wrong_auth" value="" scope="session"/>
                </c:if>            
                <c:if test="${not empty success}">
                    <div class="alert alert-success" role="alert">
                        ${success}
                    </div>
                    <c:set var="success" value="" scope="session"/>
                </c:if>
                
                <div class="card-body">
                    <div class="form-horizontal">                    
                        <div class="form-group">
                            <label for="name">Name</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" id="name" name="name" >
                            </div>                        
                        </div>
    
                        <div class="form-group">
                            <label for="email">Email</label>
                            <div class="col-md-10">
                                <input type="email" class="form-control" id="email" name="email" >
                            </div>
                        </div>
    
                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="col-md-10">
                                <input type="password" class="form-control" id="password" name="password" >
                            </div>
                        </div>
    
                        <div class="form-group">
                            <label for="confirmation_password">Confirmation Password</label>
                            <div class="col-md-10">
                                <input type="password" class="form-control" id="confirmation_password" name="confirmation_password" >
                            </div>
                        </div>
    
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <input type="submit" value="Create" class="btn btn-secondary" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</main>

<%@ include file="/WEB-INF/footer.jsp" %>
