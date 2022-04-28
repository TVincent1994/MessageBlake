<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%           
    //To disable browser cache for JSP pages, create a Filter which is mapped on an url-pattern of *.jsp 
    // and does basically the following in the doFilter() method. Setting the headers to not save web pages.
    // Prevents after logging out from our website you could press the back button and view cached pages.
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // supports HTTP 1.1
    httpResponse.setHeader("Pragma", "no-cache"); // supports HTTP 1.0
    httpResponse.setDateHeader("Expires", 0); // supports Proxies.
 %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="css/Style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
        <title>Message The Blake</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="JS/open_close_forms.js"></script>
        <script src="JS/signUpValidation.js"></script> 
        <script src="JS/loginValidation.js"></script> 
        <script src="JS/emailExistCheck.js"></script>
        <script src="JS/open_messages.js"></script>
        <script src="JS/messageValidation.js"></script>
    </head>
    <body>       
        <div id="SIGNUPOVERLAY" class="overlay">
            <span class="closebtn" onclick="closeSignUpForm()">&#215</span>
            <div class ="wrap">
                <h2>Sign Up Here</h2>
                <form name="signUpForm" method="post" action="RegistrationServlet" onsubmit="return signupvalidate()">
                    <span id="emailExistError"></span>
                    <input type="text" name="emailInput" placeholder="Enter Email" id="EMAIL_ID" onkeyup="checkExist()"/>  <!--While user is typing, "onkeyup" automatically updates text to the user instantly -->
                    <input type="text" name="usernameInput" placeholder="Enter Username"/>
                    <input type="password" name="passwordInput" placeholder="Enter Password"/>
                    <input type="password" name="repasswordInput" placeholder="Re-Enter Password"/>
                    <input type="submit" name="SignUp" value="Sign Up"/>
                </form>
            </div>
        </div>
        <div id="LOGINOVERLAY" class="overlay">
            <span class="closebtn" onclick="closeLoginForm()">&#215</span>
            <div class ="wrap">
                <h2>Login</h2>
                <form name="loginForm" method="post" action="LoginServlet" onsubmit="return loginvalidate()">
                    <input type="text" name="usernameInput" placeholder="Enter Username" id="username_ID"/>
                    <input type="password" name="passwordInput" placeholder="Enter Password" id="password_ID"/>
                    <a href="forgotPwd.jsp" class="forgotPwdBtn">Forgot Password</a>
                    <input type="submit" name="login" value="Login"/>    
                </form>
            </div>
        </div>
        <header>
            
            <!-- Click logo to navigate back to Home -->
            <a href="Home.jsp" class="active">
                <img src="logoMTB.png" class="logo">
            </a>
            
            <%
                    String username = (String) session.getAttribute("usernameSession"); // session name when user creates account  
                    if(username != null){
            %>
                <div class="welcomeUser">
                    <h1>Welcome, <span id="headerUsername"><%=username%></span></h1>
                </div>
            <%}%>
        </header>
        
        <!-- Implementation of Navigation Bar -->
        <jsp:include page="containers/navigation.jsp" />
        
        <!-- Container that implements the Message Modal -->
        <jsp:include page="containers/messageModal.jsp" />
        
        <section class="aboutSec1">
            <img src="blackbackground.jpg">
            <div class="AboutTxt">
                <h2>About Me</h2>
                <p>Blake is my middle name, but my real name is Taylor and my trade for work is I'm a Programmer. I work for Accenture
                as an RPA Developer and grateful the team there gave me this great opportunity to learn this cool tool. I appreciate everyone 
                there helping me becoming a better RPA Developer along with learning the business side behind every automation process we work with 
                to visually see the bot somewhat control the computer and work tasks for you all by itself from how you programmed it. Definitely 
                see this as an essential tool more in the future to handle repetitive work.
                <br><br>Going back to early 2000's, my first interest in computers were PC games my grandparents had that they installed or on discs.
                I remember spending a lot time playing <a href="https://hamumu.fandom.com/wiki/Spooky_Castle" target="_blank" title="Spooky Castle">Spooky Castle</a>,
                <a href="https://www.qvc.com/eGames-101-Incredible-Games%2C-Collectors-Edition---Windows.product.E113571.html" target="_blank" title="101 Games">101 Games</a>,
                <a href="https://sega.fandom.com/wiki/Vectorman_2" target="_blank" title="Vectorman 2">Vectorman 2</a>, 
                <a href="https://sonic.fandom.com/wiki/Sega_Smash_Pack_2" target="_blank" title="Sega Smash Pack 2">Sega Smash Pack 2</a>, and as the years past I moved onto <a href="https://gmod.facepunch.com/" target="_blank" title="Garry's Mod">Garry's Mod</a>,
                <a href="https://warhammer40k.fandom.com/wiki/Dawn_of_War" target="_blank" title="Dawn of War">Dawn of War</a>,
                <a href="https://www.dayofdefeat.com/" target="_blank" title="Day of Defeat">Day of Defeat</a>, and so on. Garry's Mod was one 
                of the few I spent hours playing because the mod gave us the ability to modify objects in a free world based from the map you chose.
                The creativity was limitless. I'd customize maps for my brother to play and test how good of a <a href="https://store.steampowered.com/app/17500/Zombie_Panic_Source/" target="_blank" title="Zombie Panic">Zombie Panic</a> 
                shooter he was by me spawning either zombies, <a href="https://combineoverwiki.net/wiki/Civil_Protection" target="_blank" title="Combine">Combine</a>, 
                or other <a href="https://garrysmods.org/browse/type/npcs" target="_blank" title="NPCs">NPCs</a> I placed around the map for the hope and pleasure that he couldn't win on what I created. Building this
                wasn't easy. It took a lot of time but it was the start of where my curiosity grew on how computers work. Downloading files and placing them
                in the right folder while following directions to make a mod run right is where it started for me. Why that folder? Why zip the file then 
                extract there? What's reading the file I just placed there and what the hell is all this code I'm looking at when opening these other files in the
                same directory? This brought attention to researching, configuring, and editing in the past not knowing what I was doing but also not realizing it was 
                going to help benefit me in the long run. <br><br>After graduating High School, I didn't have the interest of going to school again. I switched careers throughout the years coming to
                find out I got an interest in developing music. It was a side hobby while doing labor work which was my income. I bought <a href="https://www.image-line.com/" target="_blank" title="FL Studio">FL Studio</a> which I believe 
                is still the best production software out there to create music. Once again, spent more time learning a software and researching the tricks on how to find
                the sound I'm looking for. If I couldn't find that sound in my head, I'd search the Internet in the hunt for <a href="https://soundpacks.com/category/free-sound-packs/" target="_blank" title="Sample Packs">sample packs</a>.
                These bundles would come with all sorts of samples depending on what your looking for. This was limitless. My creativity was limitless.
                Coming to found out, these sample packs had to be placed in the folder for these sounds to work and play with too. Curiosity struck again.
                Digesting the details became an interest to me again and I wanted to do something more than just make music. I wanted to learn the behind the scenes of 
                how softwares like FL Studio or any application is built from scratch. At that moment, I started to explore videos and forums on what steps to take to become 
                a Programmer. Found movies like <a href="https://en.wikipedia.org/wiki/Who_Am_I_(2014_film)" target="_blank" title="Who Am I">No System is Safe: Who Am I</a> that built inspiration. Viewed Youtuber / Programmer, 
                <a href="https://www.youtube.com/c/noobtoprofessional/featured" target="_blank" title="Chris Hawkes">Chris Hawkes</a> who says it how it is and doesn't sugar coat anything
                on what to expect becoming a Programmer based off of his 10+ years of experience from 100+ videos uploaded. So far he's been accurate. All this researching influenced and helped me decided
                what I really wanted to do in life. <br><br>I quit labor work and made the decision to go back to school. Eventually quit retail never wanting to do that again and pursuing what is now one of my passions.
                Bought books. Lots of computer books. I still go back looking something up for a refresher or applying an example of code to help me solve a problem. These books helped me become the Programmer
                I am today and if it wasn't for them I wouldn't have an interest of picking up any type of book at all to read. <br><br>In 2019, I got my Associates Degree in Secure Software Development 
                at San Antonio College (SAC). That was the year I started my career as a developer. It was definitely difficult landing a job but hard work and preparation paid off. Later that year, I was hired 
                as an Applied Intelligence (my job title) at Accenture and the project I'm currently on, I'm working as a RPA Developer. <br><br>The goal of MessageTheBlake at first was to show proof of my value. Back in College, I 
                didn't really have anything to show for. Not that we didn't do anything there; the work can be fun and cumbersome but nothing to show for realistically. MessageTheBlake is my first
                serious project I'm very happy about sharing to the world and the journey creating it changed the purpose of it multiple times. I will keep making updates to it from time to time to further on my knowledge 
                and see the direction where it goes. This project has definitely taught me a lot on what it takes to build a website from scratch and to the success of reaching its first goal has opened interests into photography, traveling, getting
                into other hobbies, and many more just to keep this site alive to share with the world. I have a couple of other ideas in mind for the future that I'm really excited to get started on, but for now, MessageTheBlake has given me opened opportunities 
                I find myself I need to get into. My lesson learned from all this is to take breaks from computer screens! Our eyes and brain definitely need the rest from the Internet but if you ever stop by again, check out the Gallery to view my latest work.
                <br><br></p> 
            </div>
        </section> 
        <script src="JS/navigation.js"></script>
        <script src="JS/sendMessage.js"></script>
    </body>
</html>
