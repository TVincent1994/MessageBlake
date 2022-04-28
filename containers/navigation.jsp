
<%
    String username = (String) session.getAttribute("usernameSession"); // session name when user creates account
%>

<nav>
    <div class="menu-toggle">
        <i class="fas fa-bars" id="menuBtn"></i>
    </div>
    <ul id="mn_menu">
        <li><a href="Home.jsp" class="active">Home</a></li>
        <li><a href="About.jsp">About</a></li>
        <li><a href="Gallery.jsp">Gallery</a></li>
        <% 
            if(username == null){
        %>
        <li><a href="#" onclick="openSignUpForm()">Sign Up</a></li>     
        <li><a href="#" onclick="openLoginForm()">Login</a></li>   
        <%
            }else{
        %>
        <li><a href="LogoutServlet">Logout</a></li>
                
        <!-- Icon to open messages -->
        <jsp:include page="chatboxBtn.jsp" />

        <%}%>
    </ul>
</nav>
