<%@ page import="java.io.*"%>
<%!
    // Deletes a directory recursively
	void removeDirectory(File dir){
		if(dir.isDirectory()){
			File[] files = dir.listFiles();
			for(File file:files){
				removeDirectory(file);
			}
			dir.delete();
		}
		else{
			dir.delete();
		}
	}
%>
<%
	String WORKING_DIR = "D:\\CodingAndProjects\\CodingPromenade\\WebContent\\";
    String PYTHON_COMMAND = "python Main.py";
    String CPP_COMMAND = "g++ Main.cpp -o Main.exe && Main.exe";
    String JAVA_COMMAND = "javac Main.java && java Main";
	String NEW_LINE = "<BR>";
	
	// The following array is used to run a windows commandline and execute compilation commands on it
	// The third element specifies the compilation commands
	String[] commandArr = {"cmd.exe","/c",null};
    

	// Fetch the code from request parameters
	String codeText = request.getParameter("codeText");
	String codeLanguage = request.getParameter("language");
	
	//DEbug
	System.out.println("Selected language:" + codeLanguage);
	
	// Setting up the commands and creating new file
	File file = new File(WORKING_DIR);
	File tempDir = new File(WORKING_DIR + "tmp");
	String fileName = "Main";
	
	if(codeLanguage!=null){
		if(codeLanguage.contentEquals("java")){
			fileName = fileName + ".java";
			commandArr[2] = JAVA_COMMAND;
		}
		else if(codeLanguage.contentEquals("python")){
			fileName = fileName + ".py";
			commandArr[2] = PYTHON_COMMAND;
		}
		else{
			fileName = fileName + ".cpp";
			commandArr[2] = CPP_COMMAND;
		}
	}
	
	// Create a tmp directory
	if(tempDir.mkdir()){
		System.out.println("Directory Created");
		// Create a new file named Main.ext
		try{
			FileWriter javaWriter = new FileWriter(WORKING_DIR + "tmp\\" + fileName);
			javaWriter.write(codeText);
			javaWriter.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	else{
		System.out.println("Directory not created");
	}
	
	
	
	
	// Create a process that executes the commands using the process builder
    ProcessBuilder pb = new ProcessBuilder(commandArr);
    pb.directory(tempDir);
    
	// Redirect the error stream to output stream
	pb.redirectErrorStream(true);
    
	// Run the process
	Process proc = pb.start();
	
	// Read from the standard output stream
    StringBuilder result = new StringBuilder(100);
    try( BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()))){
        while(true){
            String line = in.readLine();
            if(line == null)
                break;
            result.append(line).append(NEW_LINE);
        }
    }
    
    // Send the result of the command as response 
    response.setContentType("text/html");
    out.println(result);
    
    // Remove the temporary directory
    removeDirectory(tempDir);
	
%>

