function checkEmail(form){
    var pattern = /^[a-zA-Z0-9]([!#$%&'*+\-/=?^_`{|}~\.]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]([.-]?[a-zA-Z0-9]+)*$/;
    if(!pattern.test(form.elements["#email"].value)){
        form.elements["#pwd"].disabled = true;
        form.elements["#formSubmit"].disabled = true;
        form.elements["#email"].style.borderColor = "red";
    }
    else{
        
        form.elements["#pwd"].disabled = false;
        form.elements["#formSubmit"].disabled = false;
        form.elements["#email"].style.borderColor = null;

    }
}
