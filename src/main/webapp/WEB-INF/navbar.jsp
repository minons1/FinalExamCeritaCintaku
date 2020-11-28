<nav class="navbar fixed-top navbar-expand-md navbar-dark bg-dark text-white shadow-sm">
    <div class="container">            
        <a class="navbar-brand" href="/ceritacintaku/index.jsp">
            CeritaCintaku
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="{{ __('Toggle navigation') }}">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- Left Side Of Navbar -->
            <!-- Right Side Of Navbar -->
            <ul class="navbar-nav ml-auto">
                <c:if test="${not empty user}">
                    <!-- Authentication Links -->
                    <li class="nav-item">
                        <a class="nav-link" href="/ceritacintaku/posts.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/ceritacintaku/post/index.jsp">Ceritaku</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a id="navbarDropdown" class="nav-link dropdown-toggle" href="#" role="button"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" v-pre>
                            ${user.email}<span class="caret"></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="/ceritacintaku/profile/show.jsp" onclick="">
                                Profile
                            </a>
                            <form action="/ceritacintaku/logout" method="post" id="logout-form">
                                <a class="dropdown-item" href="" onclick="event.preventDefault();
                                                        document.getElementById('logout-form').submit();">
                                    Logout
                                </a>                                    
                            </form>
                        </div>
                    </li>
                </c:if>
                <c:if test="${empty user}">
                    <li class="nav-item">
                        <a class="nav-link" href="/ceritacintaku/login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/ceritacintaku/register.jsp">Registration</a>
                    </li>
                </c:if>                    
            </ul>
        </div>
    </div>
</nav>