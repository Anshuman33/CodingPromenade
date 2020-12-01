/**
 * 
 */
function editPersonalDetails(){
	var form = document.getElementById("detailsForm");
	if(form.elements[0].disabled == true){
		for(var i=0;i<form.elements.length;i++){
			form.elements[i].disabled = false;
		}
	}else{
		for(var i=0;i<form.elements.length;i++){
			form.elements[i].disabled = true;
		}
	}
	
	//document.getElementById("saveButtonDiv").style.display = "contents";

}

function saveDetailChanges(form){
	for(var i=0;i<form.elements.length;i++){
		if(form.elements[i].name!=""){
			console.log(form.elements[i].name);
		}
	}
}

function checkItem(i){
	console.log("lang" + i);
	var checkBox = document.getElementById("lang" + i);
	
	if(checkBox.checked == true)
		checkBox.checked = false;
	else
		checkBox.checked = true;
}