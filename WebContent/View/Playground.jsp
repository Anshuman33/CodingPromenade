<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
	if(session.getAttribute("userId")==null){
		response.sendRedirect("Login");
		return;
	}
	

%>

<html>
<head><title>Playground</title>
        <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="View/ace-text-editor/src/ace.js"></script>

<script src="View/Playground.js"></script>

<link rel="stylesheet" href="css/Playground.css">

</head>

<body style="overflow:hidden">
    <nav class="navbar navbar-expand-sm sticky-top" style="background-color:rgb(38,38,38)">
		<div class="d-flex mr-auto" style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
			<h2>
			<span style="color:orange">Coding</span><span style="color:rgb(255, 255, 255)">Promenade</span>
			</h2>
		</div>
		<ul class="navbar-nav d-flex">
			<li class="nav-item mr-5 "><a class="nav-link font-weight-bold navTextColor"  href="Dashboard" >Home</a></li>
			<li class="nav-item mr-5 "><a class="nav-link font-weight-bold navTextColor" href="About">About</a></li>
			<li class="nav-item mr-5 "><a class="nav-link font-weight-bold navTextColor" href="LogoutProcess">Sign Out</a></li>
		</ul>
    </nav>
    <div class="container-fluid min-vh-100 pt-4" style="background-color: rgba(50, 50, 50);">
        <div class="row row-no-gutters">
            <div class="col-sm-6 card" style="background-color:rgb(38, 38, 38) ;">
                <div class="dropdown">
                    <select id="language" class="btn bg-dark text-light my-2" onchange="changeLanguage()">
                        <option value="java">Java</option>
                        <option value="python">Python</option>
                        <option value="cpp">C/C++</option>
                    </select>
                </div> 
                <div id="editorDiv" style="font-size: medium;"></div>
                <button class="btn btn-success btn-block mt-2" onclick="sendCode()">Run Code</button>

            </div>

            <div class="col-sm-6">
                <div class="output">
                    <p id="outputConsole">

                    </p>
                </div>
                <script>initEditor()</script>
            </div>
        </div>
    </div>
</body>
</html>