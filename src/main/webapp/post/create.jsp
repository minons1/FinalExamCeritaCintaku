<%@ include file="/WEB-INF/header.jsp" %>
<%@ include file="/WEB-INF/navbar.jsp" %>
<style>
    .container-create-post:hover{
        transform:translateY(5px);
    }

    body {
            background-image: url('../public/bg-7.png');
            }

</style>
<br />
<br>
<br>
<div class="page-header clear-filter" filter-color="orange">
    <div class="page-header-image" data-parallax="true">
    </div>
    <div class="container container-create-post shadow p-5" style="transition:all ease 0.3s;background:#ddd;border-radius:10px">
        <div class="d-flex justify-content-center" style="text-transform:uppercase">
            <h3>Buat Cerita</h3>
        </div>
        <c:if test="${not empty wrong_auth}">
            <div class="alert alert-danger" role="alert">
                ${wrong_auth}
            </div>
            <c:set var="wrong_auth" value="" scope="session"/>
        </c:if>
        <form method="POST" action="create">
            <div class="form-group">
                <label for="title">Judul</label>
                <input type="text" style="background-color: white" name="title" class="form-control" id="title" placeholder="Title" required>
            </div>
            <div class="form-group">
                <label for="description">Ceritamu</label>
                <textarea  placeholder="Description" class="form-control" id="description" type="text" name="description" style="background-color: white" height="auto" rows="7" required></textarea>
            </div>
            <div>
                <a class="btn btn-secondary mr-2" href="/ceritacintaku/post/">Back</a>
                <button class="btn btn-primary " type="submit">
                    Post Cerita
                </button>
            </div>

        </form>
    </div>
</div>
<%@ include file="/WEB-INF/footer.jsp" %>