function initEditor(){
    var divElement = document.getElementById("editorDiv");
    aceEditor = window.ace.edit(divElement);
    aceEditor.resize();
    aceEditor.setOptions({
        autoScrollEditorIntoView:true,
        showPrintMargin:true,
        minLines:25,
        maxLines:25,
        fontSize:"90%",
    });
    aceEditor.setValue(
        "// Write your code here\npublic class Main{\n\tpublic static void main(String[] args){\n\t\tSystem.out.println(\"Hello World\");\n\t}\n}"
    );
    aceEditor.clearSelection();

    aceEditor.setTheme("ace/theme/monokai");
    aceEditor.getSession().setMode("ace/mode/java");
}

function changeLanguage(){
    if(aceEditor != undefined && aceEditor != null){
        var langSelector = document.getElementById("language");
        var language = langSelector.selectedOptions[0].value;
        if(language == "java"){
            aceEditor.getSession().setMode("ace/mode/java");
            aceEditor.setValue(
                "// Write your code here\npublic class Main{\n\tpublic static void main(String[] args){\n\t\tSystem.out.println(\"Hello World\");\n\t}\n}"
            );
            aceEditor.clearSelection();

        }
        else if(language == "python"){
            aceEditor.getSession().setMode("ace/mode/python");
            aceEditor.setValue(
                "print(\"Hello World\")"
            );
            aceEditor.clearSelection();

        }
        else if(language == "cpp"){
            aceEditor.getSession().setMode("ace/mode/c_cpp");
            aceEditor.setValue(
                "#include<iostream>\nusing namespace std;\n\nint main(){\n\tcout<<\"Hello world\";\n}"
            );
            aceEditor.clearSelection();

        }
        
    }
}

function sendCode(){
    // Create an http request object for sending http request without refreshing the page
    var xhttp = new XMLHttpRequest();
    
    // Set the method to call when ready state changes for the http object
    xhttp.onreadystatechange = function(){
        // Fetches the response text on OK state and replaces the <p> tag content with the response from server
        if(this.readyState==4 && this.status==200){
            document.getElementById("outputConsole").innerHTML = xhttp.responseText;
        }
    };

	// get the code from the ace editor
    var codeText = aceEditor.getValue();

	// Get the language used
	var language = document.getElementById("language").value;
	
    // Open an http connection with method POST
    xhttp.open("POST","CodeExecutor",true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var encodedCodeText = encodeURIComponent(codeText);
    xhttp.send("codeText="+encodedCodeText+"&language="+language);	
}
