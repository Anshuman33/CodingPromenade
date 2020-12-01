<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.cpromenade.util.*,java.sql.Connection,com.cpromenade.beans.*" %>

<%
	if(session.getAttribute("userId")==null){
		response.sendRedirect("Login");
		return;
	}
	int userId = (Integer) session.getAttribute("userId");
	Connection connection = DBConnector.startConnection();
	UserDBUtil fetcher = new UserDBUtil(connection);
	UserBean user =  fetcher.fetchFromUserId(userId);
	System.out.println(user.getFirstName());
%>
<html>
    <head>
        <title>Profile Setup</title>
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
        
        <link rel="stylesheet" href="css/dashboardCustom.css">
        <script>
			$(document).ready(function() {
    			$("body").tooltip({ selector: '[data-toggle=tooltip]' ,trigger:'hover'});
			});
		</script>
        
        <script src="View/MyProfile.js"></script>
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
                      <h1 style="font-weight:lighter">My Profile</h1>  
                    </div>
                     
                    <div class="list-group list-group-flush mt-5">
                      <a class="list-group-item list-group-item-action font-weight-bold sideNavEntries " href="Dashboard" role="button">Dashboard</a></li>
                      <a class="list-group-item list-group-item-action font-weight-bold sideNavEntries active" href="/MyProfile" role="button">My Profile</a></li>
                      
                      <a class="list-group-item list-group-item-action font-weight-bold sideNavEntries " href="Playground" role="button">Coding Playground</a></li>
                    </div>
                </div>
                <div class="col-sm-9 offset-sm-3">
                
                    <div class="d-flex align-items-center flex-column border my-2 p-3 shadow-sm" >
                   		<button type="button" class="btn ml-auto deleteTaskButton" style="height:41.6px" data-toggle="modal" href="#updateProfileModal"><i class="fas fa-pencil-alt"></i></button>							                    
                           <img src=<%= (user.getPhotoPath()!=null)?"http://localhost:8080" + user.getPhotoPath():"/CodingPromenade/images/ProfileDefault.png" %> class="rounded-circle" style="width:200px;height:200px" >
                           <h1><%=user.getFirstName() + " " + user.getLastName() %></h1>
                           <p><%= (user.getBio()!=null)?user.getBio():"Hello! I am a Promenader" %></p>
                           <div class="modal fade" id="updateProfileModal" role="dialog">
			            	<div class="modal-dialog">
			                	<div class="modal-content">
			                    	<div class="modal-header">
			                     		<h4 class="modal-title">Update Profile</h4>
			                      		<button type="button" class="close" data-dismiss="modal">&times;</button>
			                      	</div>
			                      	<div class="modal-body">
			                        	<p>Here you can change your profile photo, name and bio.</p>
			                        	<form id="profileForm" method="POST" enctype="multipart/form-data" action="ProfileUpdater">
			                        		<div class="form-group">
			                        			<input class="form-control" name="photo" type="file" placeholder="ProfilePhoto" accept="image/jpeg, image/png">
			                        		</div>
			                        		
			                        		<div class="form-group">
			                        			<input class="form-control" name="firstName" type="text" placeholder="First Name" value="<%=user.getFirstName()%>">
			                        		</div>
			                        		
			                        		<div class="form-group">
			                        			<input class="form-control" name="lastName" type="text" placeholder="Last Name" value="<%=user.getLastName()%>">
			                        		</div>
			                        		
			                        		<div class="form-group">
			                        			<input class="form-control" name="bio" type="text" placeholder="Enter your bio" value="<%=(user.getBio()!=null)?user.getBio():"Hello! I am a Promenader"%>">
			                        		</div>
			                        		
			                        		<div class="form-group">
			                        			<button type="submit" class="btn btn-warning btn-block" >Save changes</button> 
			                        		</div>
			                        	</form>
			                      	</div>
			                    </div>
			                  </div>
			              </div>  
                    </div>
                    <div class="d-flex flex-column border my-2 p-3 shadow-sm" >
                    		<div class="d-flex flex-row">
                    			<h3 class="mr-auto">Personal Details</h3>
                    			<button type="button" class="btn deleteTaskButton" onclick="editPersonalDetails()" data-toggle="collapse" data-target="#saveButtonDiv"><i class="fas fa-pencil-alt"></i></button>
                    		</div>
                    									  	
                    		<form id="detailsForm" action="DetailsUpdater" method="POST">
	                    		<div class="row mb-3 mt-3">
									<div class="col">
										<div class="input-group">
											<div class="input-group-prepend">
												<label class="input-group-text" for="emailTextBox">Email ID</label>
											</div>
											<input id="emailTextBox" type="text" class="form-control" name="emailId" value=<%=user.getEmailId() %> disabled>
										</div>
									</div>
									<div class="col">
										<div class="input-group">
											<div class="input-group-prepend">
												<label class="input-group-text" for="dobTextBox">Date of Birth</label>
											</div>
											<input type="date" id="dobTextBox" class="form-control" name="dateOfBirth" value=<%=user.getDateOfBirth() %> disabled>
										</div>
									</div>
								</div>
								<div class="row mb-3">
									<div class="col">
										<div class="input-group">
											<div class="input-group-prepend">
                                    			<span class="input-group-text">Gender</span>
                                			</div>
			                                <select class="form-control" name="gender" disabled>
			                                	<option value="female" <%=(user.getGender().contentEquals("female"))?"selected":""%>>Female</option>
			                                	<option value="male" <%=(user.getGender().contentEquals("male"))?"selected":""%>>Male</option>
			                                	<option value="other" <%=(user.getGender().contentEquals("other"))?"selected":""%>>Other</option>
			                                </select>
										</div>
									</div>
									<div class="col">
										<div class="input-group">
											<div class="input-group-prepend">
												<label class="input-group-text" for="phoneTextBox">Phone</label>
											</div>
											<input id="phoneTextBox" type="text" class="form-control" name="phone" placeholder="Phone number" disabled value=<%=(user.getPhone()!=null)?user.getPhone():""%> >
										</div>
									</div>
								</div>
								<div id="saveButtonDiv" class="row collapse" >
									<div class="col">
										<button type="submit" class="btn btn-warning btn-block">Save Changes</button>
									</div>
                    			</div>
                    		</form>
                    </div>
                    
                    <div class="d-flex flex-column border my-2 p-3 shadow-sm">
                    	<div class="d-flex flex-row">
                        	<h3 class="mr-auto">Preferred Programming Languages</h3>
                        	<button type="button" class="btn ml-auto deleteTaskButton" style="height:41.6px" data-toggle="modal" href="#modifyLangPreference"><i class="fas fa-pencil-alt"></i></button>							                    
                        	
                        </div>
                        <div class="d-flex flex-row ">
                            <h3>
                            <% 
                            	List<String> langList = user.getLanguages();
                            	if(langList==null || langList.size()==0)
        	                		out.println("<h5 class='text-secondary my-2'>No languages selected yet.</h5>");
                            	else{
                            		for(int i=0;i<langList.size();i++){%>
                            		<span class="badge badge-pill badge-warning mr-3"><%=langList.get(i)%></span>
                            		<%	
                            	
                            		}
                            	}
                            %>          
                            </h3>                  
                        </div>
                    </div>
                    <script> var langArr = ["Python","C++","Java","PHP","C","JavaScript"];</script>
                    <div class="modal fade" id="modifyLangPreference" role="dialog">
			            	<div class="modal-dialog">
			                	<div class="modal-content">
			                    	<div class="modal-header">
			                     		<h4 class="modal-title">Select languages</h4>
			                      		<button type="button" class="close" data-dismiss="modal">&times;</button>
			                      	</div>
			                      	<div class="modal-body">
			                        	<form id="preferenceForm" action="LangPrefHandler" >
			                        		<div class="list-group w-100 mb-1">
			                        			<% 
			                        				
			                        				String [] langArr = {"Python","C++","Java","PHP","C","JavaScript"};
			                        				for(int i=0;i<langArr.length;i++){	
			                        					String checked = "";
			                        					if(langList!=null && langList.contains(langArr[i])){
			                        						checked = "checked";
			                        					}
			                        					out.print(
			                        							"<div class='list-group-item list-group-item-action listItem' onclick='checkItem("+ i + ")'>" +
			        	                						"<p class='mr-auto my-auto'>" + langArr[i] + "</p>" +
			        	                						"<label class='taskCheckContainer my-auto mr-3'>" + 
			        	                						"<input type='checkbox' name='languages' value=" + langArr[i] +" id='lang"+ i +"' " + checked + ">" + 
			        	                						"<span class='checkmark' data-toggle='tooltip' title='Mark as preferred'></span></label>"+
			        	                						"</div>"	
			                        					);
			                        				}
			                        				
			                        			%>
			                        		</div>
			                     			
			                        		<div class="form-group">
			                        			<button type="submit" class="btn btn-warning btn-block" >Save changes</button> 
			                        		</div>
			                        	</form>
			                      	</div>
			                    </div>
			                  </div>
			              </div>
                    
                    
                    
                
                        

                    
                </div>
            </div>

        </div>
    </body>
</html>