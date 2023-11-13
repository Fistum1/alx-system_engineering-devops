(1) Issue Summary (that is often what executives will read) : 

What is the duration of the outage start ? Thur 2023-11-09 01:20:40 EAT
what is the duration of the outage end ? Thur 2023-11-09 03:10:20 EAT

Timeline

    01:20 ETA - 503 error when trying to access the website
    01:25 ETA - checked and ensured Apache and MySQL are up and running but unable to logged in to mysql server.
    01:26 ETA - MySQL server had been throwing error when I try to loggin.
    01:47 ETA - Reviewed the error logs to check where the issue might be coming from. 
    02:05 ETA - Checked '/var/run/mysqld/mysqld.sock' to see that what happened in mysqld.sock.
    02:33 ETA - Restarting mysql server and going to the error logs to check if I get further info from systemctl status mysql.service.
    02:45 ETA - Reviewing error logs and reinstall mysql and php.
    02:52 ETA - Added sub processor using "sudo usermod -d /var/lib/mysql/ mysql"
    02:58 ETA - After that when I restarting mysql server the issue is fixed.
    03:10 ETA - Finally I am able to login in mysql server and Web server is now running normally as expected.
    
What was the impact?  My web server was not working as expected.
What service was down/slow? Mysql server and/or php.
What were user experiencing? Unable to access my web server in my local machine.
How many % of the users were affected? 1 user only affected.


(2) Timeline (format bullet point, format: time - keep it short, 1 or 2 sentences) :

When was the issue detected? Thur 2023-11-09 01:20:40 EAT
How was the issue detected? When I was trying to access my web server I got 503 error messages and when I check mysql server I was not able to loggin.
What were the assumption on the root cause of the issue? I thought the issue is related with php installation.
What was the misleading investigation/debugging paths that were taken? I reinstall the php but it didn't resolve the orginal issue.
Which team/individuals was the incident escalated to? It was on test environment so no one expriance this issue except me.
How the incident was resolved? I exposed the directory which has the socket configurations to the user who is running the process and it start working as expected.


(3) Root cause and resolution :

What was causing the issue? Error Messages from mysql server: ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
How the issue was fixed? To solve this issue I tried to stop mysql process through "systemctl stop mysql", after than I exposed the directory which has the socket configurations to the user who is running the process, this can happen through "sudo usermod -d /var/lib/mysql/ mysql", then I go back and start / restart mysql process again through "systemctl start mysql" and finally I am able to access mysql server and my website as well.


(4) Corrective and preventative measures :

What are the things that can be improved/fixed? All server should be checked and confirm working properly when we are facing this kind of issues.
What are the list of tasks to address the issue? Should check the error messages and take a corrective action on mysql and php server.

(5) Be brief and straight to the point, between 400 to 600 words :
 
Based on my research this issue was connected with one of my backend server and unable to access my webserver. The error was happened when I try to access my webserver and return 503 error code. However, when I check mysql server I couldn't loggin and got the following error "ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)". By checking the error logs it was found that the mysqld.sock doesn't exist and then I reinstall mysql server and php with --fix-missing as well as exposed the directory which has the socket configurations to the user who is running the process, this can happen through "sudo usermod -d /var/lib/mysql/ mysql", then I go back and start / restart mysql process again through "systemctl start mysql" and finally I am able to access mysql server and my website as well.
