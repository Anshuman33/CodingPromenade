<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
	if(session.getAttribute("userId")!=null){
		response.sendRedirect("Dashboard");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="View/Login.js" ></script>	

<link rel="stylesheet" href="css/custom1.css">
</head>
<body class="d-flex flex-column min-vh-100 bg" >
	
	<nav class="navbar navbar-expand-sm sticky-top" style="background-color:rgb(38,38,38)">
		<div class="d-flex mr-auto" style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
			<h2 class="text-weights-color">
			<span style="color:orange">Coding</span><span style="color:rgb(255, 255, 255)">Promenade &nbsp;</span>
			</h2>
		</div>
		<ul class="navbar-nav d-flex">
			<li class="mr-5">
				<a class="nav-link font-weight-bold" href="">
					
				</a>
			</li>
			<li class="nav-item mr-5"><a class="nav-link navTextColor font-weight-bold " href="About">About</a></li>
			<li class="nav-item mr-5"><a class="nav-link navTextColor font-weight-bold " href="Register">Register</a></li>
			
		</ul>
	</nav>
	<div class="d-flex flex-row justify-content-center">
		<div class="d-flex justify-content-center mr-5" style="width:45%;">
			<img src="images/Logo2.png" class="img-fluid">
		</div>

		<div class="card mt-5 my-auto ml-5" style="width:30%;opacity:1;">
			<div class="card-header text-center font-weight-bold" >
				Login
			</div>
			<div class="card-body">
				<form action="LoginCheck" method="POST" name="loginForm">
					<div class="form-group mt-2">
						<input name="emailId" type="email" class="form-control" placeholder="Enter email" id="#email" onchange="checkEmail(this.form)"></input>
					</div>
					<div class="form-group mt-2">
						<input name="password" type="password" class="form-control" placeholder="Enter password" id="#pwd" REQUIRED></input>
					</div>
					
					<button type="submit" class="btn btn-primary btn-block mt-2" name="formSubmit" id="#formSubmit">Sign In</button>

					<div class="form-group mt-3 text-center">
						<a href="Register">New Here? Create new account</a>
					</div>	
				</form>
			</div>
		</div>
	</div>
	
</body>







