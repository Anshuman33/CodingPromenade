<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.cpromenade.util.*,java.sql.Connection,com.cpromenade.beans.*,java.util.List" %>
<%
	int userId ;
	Connection connection = null;
	UserDBUtil fetcher = null;
	UserBean user = null;
	TaskDBUtil taskFetcher = null;
	TipsDBUtil tipFetcher = null;
	if(session.getAttribute("userId") == null){
		response.sendRedirect("Login");
		return;
	}
	else{
		userId = (Integer) session.getAttribute("userId");
		connection = DBConnector.startConnection();
		fetcher = new UserDBUtil(connection);
		taskFetcher = new TaskDBUtil(connection);
		tipFetcher = new TipsDBUtil(connection);
		user =  fetcher.fetchFromUserId(userId);
		//connection.close();
		System.out.println(user.getFirstName());
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- For icons -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

<script src="View/Dashboard.js"></script>
<link rel="stylesheet" href="css/dashboardCustom.css">

<!--  JQUERY TOOLTIP ACTIVATE -->
<script>
$(document).ready(function() {
    $("body").tooltip({ selector: '[data-toggle=tooltip]' ,trigger:'hover'});
});
</script>
</head>
<body>
    <nav class="navbar navbar-expand-sm sticky-top" style="background-color:rgb(38,38,38)">
		<div class="d-flex mr-auto" style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
			<h2>
			<span style="color:orange">Coding</span><span style="color:rgb(255, 255, 255)">Promenade</span>
			</h2>
		</div>
		<ul class="navbar-nav d-flex">
			
			<li class="nav-item mr-5"><a class="nav-link font-weight-bold navTextColor" href="About">About</a></li>
			<li class="nav-item mr-5"><a class="nav-link font-weight-bold navTextColor" href="LogoutProcess">Sign Out</a></li>
		</ul>
    </nav>

    <div class="container-fluid">
        <div class="row">
          <div class="col-sm-3 col-2 min-vh-100" style="position: fixed;background-color: rgb(50,50,50);">
            <div class="container-fluid text-light mt-5">
              <h1 style="font-weight:lighter">Dashboard</h1>  
            </div>
             
            <div class="list-group list-group-flush mt-5">
              <a class="list-group-item list-group-item-action font-weight-bold sideNavEntries active" href="Dashboard" role="button" >Dashboard</a>
              <a class="list-group-item list-group-item-action font-weight-bold sideNavEntries" href="MyProfile" role="button" >My Profile</a>
           
              <a class="list-group-item list-group-item-action font-weight-bold sideNavEntries" href="Playground" role="button">Coding Playground</a>
            </div>
          </div>
          <div class="col-sm-9 offset-sm-3">
            <div class="alert alert-success alert-dismissable fade show text-center mt-2">
              <button type="button" class="close" data-dismiss="alert" >&times;</button>
              <h1>Hi <%=user.getFirstName()%>!</h1>
              <p>
                Welcome to your dashboard.
              </p>
            </div>
          	<% TipBean tipBean = tipFetcher.fetchTipsByLanguage(user.getLanguages()); 
          	   if(tipBean == null){
          		   tipBean = new TipBean();
          		   tipBean.setTitle("Practice takes man closer to perfection!");
          		   tipBean.setDescription("Hey Promenader! The more codes you write, the more conceptually strong you become. Make projects based on your preferred languages and embrace the journey of coding.");
          	   	   tipBean.setLanguage("GENERAL");
          	   }
          	%>
            <div id="tipsCarousel" class="carousel slide mx-1 my-2 border shadow-sm" data-ride="carousel" style="display:flex;max-height:28%;overflow: hidden;">
              
              <a class="carouselControlPrev" href="#tipsCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon"  aria-hidden="true"></span>
              </a>
              
              <div id="tips"  class="carousel-inner text-center" style="width: 80%;font-family:monospace;">
                <div class="carousel-item active" style="background-color:rgb(38,38,38)">
                  <h2 style="color: lime;">Promenader Intel</h2>
                  <h3 style="color: white;"><%= tipBean.getTitle()%></h3>
                  <p style="color:white">Language : <%=tipBean.getLanguage() %></p>
                </div>
                <div class="carousel-item" style="background-color:rgb(38,38,38)">
                  <h2 style="color: lime;">Promenader Intel</h2>
                  <p style="color:white"><%= tipBean.getDescription()%></p>
                </div>
              </div>
              
              	<a class=" carouselControlNext" href="#tipsCarousel" role="button" data-slide="next" >
                	<span class="carousel-control-next-icon" aria-hidden="true"></span>
              	</a>
              
            </div>
            <div id="TaskDivParent">
	            <div class="d-flex flex-column my-3 align-items-center border shadow-sm" id="TaskDiv">
	                <h1>Your Tasks</h1>
	                <%-- Automatically insert the to-do list items here --%>
	                <% 
	                	if(connection == null || connection.isClosed()){
	                		connection = DBConnector.startConnection();
	                	}
	                	taskFetcher.setConnection(connection);
	                	user.setTasks(taskFetcher.fetchTasksFromId(userId));
	                	List<TaskBean> tasks = user.getTasks();
	                	if(tasks != null){
	                		out.println("<div class='list-group w-100'>");
	                		for(int i=0;i<tasks.size();i++){
	                			TaskBean task = tasks.get(i);
	                			String descId = "itemDescription" + task.getTaskId();
	                			String taskTitle = task.getTitle();
	                			String taskDesc = task.getDescription();
	                			String taskStatus = "";
	                			if(task.getStatus() == 1)
	                				taskStatus = "checked";
	                			System.out.println(task.getStatus());
	                			out.println("<div class='list-group-item list-group-item-action listItem' data-toggle='collapse' href='#" + descId + "' role='button' aria-expanded='false' aria-controls='" + descId + "'>" +
	                						"<p class='mr-auto my-auto'>" + taskTitle + "</p>" +
	                						"<p class='mr-3 my-auto badge badge-warning'>" + "Deadline Date: " + task.getEndDate()  + "</p>" +
	                						"<label class='taskCheckContainer my-auto mr-3'>" + 
	                						"<input type='checkbox' id='taskCheck" + task.getTaskId() +  "' onclick='taskCheckHandler(this," + task.getTaskId() + ")' " + taskStatus +">" + 
	                						"<span class='checkmark' data-toggle='tooltip' title='Mark as Done/Incomplete'></span></label>"+
	                						"<button class='btn deleteTaskButton' onclick='taskDeleteHandler("+task.getTaskId()+")'><i class='fas fa-trash-alt'></i></button>" + 
	                						"</div>");
	                			out.println("<div class='collapse' id='" + descId + "'> ");
	                			out.println("<p class='card card-body bg-light'>" + taskDesc + "</p>");
	                			out.println("</div>");
	                		}
	                		out.println("</div>");
	                		
	                	}
	                	else{
	                		out.println("<h5 class='text-secondary my-2'>No tasks yet.</h5>");
	                	}
	                	
	                %>
	                
	                <button class="btn btn-round btn-primary my-2 listAddButton" data-toggle="modal" data-target="#addToDo">
	                  <i class="fas fa-plus"></i>
	                </button>
	                
	                <div class="modal fade" id="addToDo" role="dialog">
	                  <div class="modal-dialog">
	                    <div class="modal-content">
	                      <div class="modal-header">
	                      	<h4 class="modal-title">Add Task</h4>
	                      	<button type="button" class="close" data-dismiss="modal">&times;</button>
	                      </div>
	                     
	                      <div class="modal-body">
	                        <p>Please fill in the task details</p>
	                        <form id="toDoForm" method="POST">
	                        	<div class="form-group">
	                        		<input class="form-control" name="taskTitle" type="text" placeholder="Enter task title">
	                        	</div> 
	                        	<div class="form-group">
	                        		<input class="form-control" name="taskDescription" type="text" placeholder="Enter task description">
	                        	</div>
	                        	<div class="form-group">
	                        		<label for="deadlineDate">Deadline Date</label>
	                        		<input id="deadlineDate" name="taskEndDate" class="form-control" type="date">
	                        	</div>
	                        	<div class="form-group">
	                        		<button type="button" class="btn btn-warning btn-block" onclick="submitTask(this.form)" data-dismiss="modal">ADD TASK</button> 
	                        	</div>
	                        </form>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	             </div>
	          </div>
	       </div>
        </div>
      </div>
</body>
    
</html>
