
function checkFirstName(form){
	if(form.elements["firstName"].value == null || form.elements["firstName"].value == ""){
		document.getElementById("invalName").style.visibility = "visible";
		form.elements["firstName"].style.borderColor = "red";
        form.elements["firstName"].style.boxShadow = "0px 0px 1.5px 2.5px red";
		form.elements["formSubmit"].disabled = true;
	}
	else{
		form.elements["firstName"].style.border = "1px solid #ced4da"
		form.elements["firstName"].style.borderColor = "#ced4da;"
		form.elements["firstName"].style.boxShadow = "none";
		document.getElementById("invalName").style.visibility = "hidden";
		form.elements["formSubmit"].disabled = false;
	}
}

function checkEmail(form){
    var pattern = /^[a-zA-Z0-9]([!#$%&'*+\-/=?^_`{|}~\.]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-][a-zA-Z0-9]+)*\.[a-zA-Z0-9]+$/;
   console.log(form);
    if(!pattern.test(form.elements["email"].value)){
        form.elements["pwd"].disabled = true;
        form.elements["formSubmit"].disabled = true;
        form.elements["email"].style.borderColor = "red";
        form.elements["email"].style.boxShadow = "0px 0px 1.5px 2.5px red";
        document.getElementById("invalEmail").style.visibility = "visible";

		
    }
    else{ 
        form.elements["pwd"].disabled = false;
        form.elements["formSubmit"].disabled = false;
        form.elements["email"].style.borderColor = "green";
        form.elements["email"].style.boxShadow = "0px 0px 1.5px 2.5px green";
        document.getElementById("invalEmail").style.visibility = "hidden";
    }
}

function checkPassword(form){
    /*
        Function to check the password contains more than 8 letters 
        and atleast one alphabet,number and one special character 
    */

    var pwd = form.elements["pwd"].value;
    if(/\d/.test(pwd) && /[a-zA-Z]/.test(pwd) && /[^a-zA-Z\s\d]/.test(pwd) && pwd.length>8){
        form.elements["pwd"].style.borderColor = "green";  
        form.elements["pwd"].style.boxShadow = "0px 0px 1.5px 2.5px green"; 
        document.getElementById("invalPwd").style.visibility = "hidden";
		form.elements["formSubmit"].disabled = false;

    }
    else{
        form.elements["pwd"].style.borderColor = "red";
        form.elements["pwd"].style.boxShadow = "0px 0px 1.5px 2.5px red";
        document.getElementById("invalPwd").style.visibility = "visible";
		form.elements["formSubmit"].disabled = true;

    }
}

function checkConfirmPassword(form){
    var password = form.elements["pwd"];
    var confirmPassword = form.elements["confirmPwd"];
    if(password.value.localeCompare(confirmPassword.value)!=0){
        confirmPassword.style.borderColor = "red";
        confirmPassword.style.boxShadow = "0px 0px 1.5px 2.5px red";
        document.getElementById("invalPwd2").style.visibility = "visible";
		form.elements["formSubmit"].disabled = true;

    }
    else{
		form.elements["formSubmit"].disabled = false;
        confirmPassword.style.borderColor = "green";
        confirmPassword.style.boxShadow = "0px 0px 1.5px 2.5px green";
        document.getElementById("invalPwd2").style.visibility = "hidden";
		validConfirmPwd = true;
    }
}

