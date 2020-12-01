function submitTask(form){
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function(){
		if(this.readyState==4 && this.status==200){
			var answer = this.responseText;
			console.log(answer);
			$("#TaskDivParent").load(window.location.href + " #TaskDiv");
		}
	};
	var queryString = "";
	for(var i=0;i<form.elements.length;i++){
		if(form.elements[i].name != ""){
			queryString += form.elements[i].name + "=" + form.elements[i].value;
			if(i<form.elements.length-1)
			queryString += "&";
		}
		
	}
	
	xhttp.open("POST","TaskFormProcess",true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send(queryString);
		
}

function taskCheckHandler(checkbox,taskId){
	var newStatus = null;
	if(checkbox.checked == true){
		newStatus = 1;
	}
	else{
		newStatus = 0;
	}
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function(){
		if(this.readyState == 4 && this.status == 200){
			console.log("Task successfully updated");
			$("#TaskDivParent").load(window.location.href + " #TaskDiv");
		}
	}
	xhttp.open("GET","TaskUpdateHandler?taskId="+taskId + "&newStatus=" + newStatus,true);
	xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhttp.send();
}

function taskDeleteHandler(taskId){
	if(confirm("Confirm task deletion?")){
		var newStatus=2;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				console.log("Task successfully deleted");
				$("#TaskDivParent").load(window.location.href + " #TaskDiv");
			}
		}
		xhttp.open("GET","TaskUpdateHandler?taskId="+taskId + "&newStatus=" + newStatus,true);
		xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xhttp.send();
	}
}