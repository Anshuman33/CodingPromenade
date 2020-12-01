<%@page contentType="text/html" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Register</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="View/Register.js"></script>

<link rel="stylesheet" href="css/custom1.css">
<!--  JQUERY TOOLTIP ACTIVATE -->
<script>
$(document).ready(function() {
    $("body").tooltip({ selector: '[data-toggle=tooltip]' ,trigger:'hover'});
});</script>
</head>
<body class="d-flex flex-column" style="overflow: hidden;">
    <div class="navbar navbar-expand-sm sticky-top" style="background-color:rgb(38,38,38)">
        <div class="d-flex mr-auto" style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
			<h2 class="text-weight-bold">
			<span style="color:orange">Coding</span><span style="color:rgb(255, 255, 255)">Promenade &nbsp;</span>
			</h2>
        </div>
        <ul class="navbar-nav d-flex">
			<li class="nav-item mr-5"><a class="nav-link navTextColor font-weight-bold " href="About">About</a></li>
			<li class="nav-item mr-5"><a class="nav-link navTextColor font-weight-bold " href="Login">Sign In</a></li>
		</ul>
    </div>
    <div class="container-fluid pl-0" >
        <div class="row">
            <div class="col-sm-5">
                <img class="img w-100" src="images/side-bg-register4.jpg">
            </div>
            <div class="col-sm-7">
                <div class="d-flex flex-column m-5" >
                    <div>
                        <h1>Let's Get Started!</h1>
                    </div>
                    <div class="mt-2">
                        <p>Please fill in the details</p>
                    </div>
                    <div class="w-75">
                        <form action="RegisterProcess" method="POST" >
                        	<div class="form-row">
	                        	<div class="form-group col-md-6">
	                                <input type="text" class="form-control form-control" placeholder="First Name" id="firstName" name="firstNameInput" onchange="checkFirstName(this.form)" required>
	                            	<small id="invalName" class="invalid-field mt-1 mb-0 ">First name cannot be empty.</small>
	                            </div>
	                            <div class="form-group col-md-6">
	                                <input type="text" class="form-control form-control" placeholder="Last Name" id="lastName" name="lastNameInput">
	                            </div>
	                        </div>
	                       	
	                        
                            <div class="form-group">
                                <input type="email" class="form-control form-control" placeholder="Enter email" id="email" name="emailInput" onchange="checkEmail(this.form)"  required>
                                <small id="invalEmail" class="invalid-field">Invalid email format.</small>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control form-control" placeholder="Enter password" id="pwd" name="pwdInput" oninput="checkPassword(this.form)" required>
                                <small id="invalPwd" class="invalid-field" data-toggle="tooltip" data-placement="right" title="Password must contain atleast 8 characters with atleast one special character,digit and letter.">Invalid Password</small>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control form-control" placeholder="Confirm password" id="confirmPwd" oninput="checkConfirmPassword(this.form)" required>
                                <small id="invalPwd2" class="invalid-field">Confirmation password did not match.</small>
                            </div>

                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text mr-2">Gender</span>
                                </div>
                                <div class="form-check-inline">
                                    <label class="form-check-label">
                                        <input type="radio" class="form-check-input" name="genderInput" value="male" required>Male</input>
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <label class="form-check-label">
                                        <input type="radio" class="form-check-input" name="genderInput" value="female" required>Female</input>
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <label class="form-check-label">
                                        <input type="radio" class="form-check-input" name="genderInput" value="other" required>Other</input>
                                    </label>
                                </div>
                            </div>
                            <div class="input-group mt-4">
                            	<div class="input-group-prepend"><span class="input-group-text">Date of Birth</span></div>
                            	<input id="dob" name="dobInput" type="date" class="form-control" required>
                            </div>
                            <button id="formSubmit" type="submit" class="btn btn-primary btn-block form-control mt-4">Register</button>
                            
                            
                        </form>

                    </div>
                    
                </div>        
            </div>
        </div>
    </div>
    


</body>
</html>