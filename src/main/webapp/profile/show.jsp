<%@ include file="/WEB-INF/header.jsp" %>
<%@ include file="/WEB-INF/navbar.jsp" %> 
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.ceritacintaku.model.User"%> 
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
                <%                                            
                    User user = (User) session.getAttribute("user");
                %>
                <c:if test="${not empty status}">
                    <div class="alert alert-success" role="alert">
                        ${status}
                    </div>
                    <c:set var="status" value="" scope="session"/>
                </c:if>
                <div class="card">
                  <div class="d-flex justify-content-center p-3">
                    <img src="../public/programmer.png" class="card-img-top" alt="..." style="width: 50%;">
                  </div>
                  <div class="card-body m-auto">
                    <div class="d-flex justify-content-center" style="flex-direction: column;">
                      <h5 class="card-title text-center" style="font-size: 30px; font-weight: 900;">Profile</h5>
                      <h6 class="card-subtitle mb-2 text-muted" style="font-size: 24px;">Name: <%=user.getName()%></h6>
                      <h6 class="card-subtitle mb-2 text-muted" style="font-size: 24px;">Email: <%=user.getEmail()%></h6>
                    </div>
                  </div>
                </div>
            </div>
        </div>
    </div>
</main>
        <%@ include file="/WEB-INF/footer.jsp" %>