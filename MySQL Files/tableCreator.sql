CREATE TABLE credentials(
	userID int PRIMARY KEY,
    password VARCHAR(100) NOT NULL,
    foreign key(userID) references user(userId) on delete cascade on update cascade
);

SELECT * FROM credentials;

CREATE TABLE user(
	userId integer primary key auto_increment,
    fname varchar(20),
    lname varchar(20),
    email varchar(60) unique not null,
    phone char(10) check(length(phone)=10),
    photoPath varchar(1024),
    bio varchar(300),
    dob date,
    gender varchar(20)
);

CREATE TABLE task(
	userId integer,
    taskId integer,
    title varchar(200),
    description varchar(2048),
    endDate date,
    primary key(userId,taskId),
    foreign key(userId) references user(userId) on delete CASCADE on update CASCADE
);

ALTER TABLE lang_preference add foreign key(userId) references user(userId) on delete cascade;

DROP PROCEDURE  if exists GetNoOfTasks;
# Create a stored procedure for getting number of tasks rows for a particular userId
DELIMITER //
CREATE PROCEDURE GetNoOfTasks
( IN inputUserId int, OUT numberOfTasks int)
BEGIN
	Select Count(taskId) Into numberOfTasks from task where userId=inputUserId;
END//
DELIMITER ;


SELECT * FROM TASK;

 
